"""Fine-tuning LoRA de Qwen2.5-Coder-1.5B-Instruct para Text-to-SQL (Colab, GPU T4).

Dos configuraciones que difieren en UN solo factor (los módulos con LoRA):
  A: LoRA solo en atención       (q_proj, k_proj, v_proj, o_proj)
  B: LoRA en atención + MLP      (q, k, v, o, gate_proj, up_proj, down_proj)
Todo lo demás es igual: r=16, alpha=32, dropout=0.05, lr=2e-4, 1 época, batch efectivo 16.

El loss se calcula solo sobre la respuesta (la consulta SQL + <|im_end|>), no sobre el prompt.

Salidas en resultados/entrenamiento/<config>/:
  adapter/          pesos LoRA
  historial.json    loss de train y de dev_interno por paso
  resumen.json      parámetros entrenables, tiempo, hiperparámetros
  curva_loss.png

Checkpoints cada 50 pasos en --checkpoints (en Colab, una carpeta de Google Drive). Si la sesión
se desconecta, volver a correr el mismo comando continúa desde el último checkpoint.

Uso (Colab):  python scripts/entrenamiento/entrenar.py --config A --checkpoints /content/drive/MyDrive/t2s_checkpoints
"""
import argparse
import json
import math
import time
from pathlib import Path

import torch
from peft import LoraConfig, get_peft_model
from transformers import (AutoModelForCausalLM, AutoTokenizer, Trainer, TrainingArguments,
                          set_seed)
from transformers.trainer_utils import get_last_checkpoint

RAIZ = Path(__file__).resolve().parents[2]
CONFIG = json.loads((RAIZ / "config.json").read_text())

ATENCION = ["q_proj", "k_proj", "v_proj", "o_proj"]
MLP = ["gate_proj", "up_proj", "down_proj"]
CONFIGURACIONES = {
    "A": dict(target_modules=ATENCION),
    "B": dict(target_modules=ATENCION + MLP),
}
COMUNES = dict(r=16, lora_alpha=32, lora_dropout=0.05)
HIPER = dict(lr=2e-4, epocas=1, batch=1, acumulacion=16, max_tokens=3072,
             warmup=0.03, max_dev=300, eval_cada=100, guardar_cada=50)


def tokenizar(ejemplo, tok):
    mensajes = ejemplo["messages"]
    prompt_ids = tok.apply_chat_template(mensajes[:-1], tokenize=True, add_generation_prompt=True)
    completo_ids = tok.apply_chat_template(mensajes, tokenize=True)
    # Qwen agrega "\n" después de <|im_end|>; se entrena hasta <|im_end|> inclusive
    if completo_ids[-1] != tok.convert_tokens_to_ids("<|im_end|>"):
        completo_ids = completo_ids[:-1]
    assert completo_ids[:len(prompt_ids)] == prompt_ids, "el prompt no es prefijo del ejemplo"
    etiquetas = [-100] * len(prompt_ids) + completo_ids[len(prompt_ids):]
    return dict(input_ids=completo_ids[:HIPER["max_tokens"]],
                labels=etiquetas[:HIPER["max_tokens"]])


class Collator:
    def __init__(self, pad_id):
        self.pad_id = pad_id

    def __call__(self, lote):
        n = max(len(x["input_ids"]) for x in lote)
        ids = [x["input_ids"] + [self.pad_id] * (n - len(x["input_ids"])) for x in lote]
        lab = [x["labels"] + [-100] * (n - len(x["labels"])) for x in lote]
        att = [[1] * len(x["input_ids"]) + [0] * (n - len(x["input_ids"])) for x in lote]
        return dict(input_ids=torch.tensor(ids), labels=torch.tensor(lab),
                    attention_mask=torch.tensor(att))


class Lista(torch.utils.data.Dataset):
    def __init__(self, filas):
        self.filas = filas

    def __len__(self):
        return len(self.filas)

    def __getitem__(self, i):
        return self.filas[i]


def leer(ruta, limite=None):
    filas = [json.loads(l) for l in open(ruta, encoding="utf-8")]
    return filas[:limite] if limite else filas


def graficar(historial, ruta, titulo):
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    tr = [(h["step"], h["loss"]) for h in historial if "loss" in h]
    ev = [(h["step"], h["eval_loss"]) for h in historial if "eval_loss" in h]
    plt.figure(figsize=(7, 4))
    if tr:
        plt.plot(*zip(*tr), label="train")
    if ev:
        plt.plot(*zip(*ev), marker="o", label="dev interno (esquemas no vistos)")
    plt.xlabel("paso")
    plt.ylabel("loss")
    plt.title(titulo)
    plt.legend()
    plt.grid(alpha=.3)
    plt.tight_layout()
    plt.savefig(ruta, dpi=150)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--config", choices=sorted(CONFIGURACIONES), required=True)
    ap.add_argument("--max-ejemplos", type=int, default=None, help="para pruebas rápidas")
    ap.add_argument("--max-dev", type=int, default=HIPER["max_dev"])
    ap.add_argument("--checkpoints", default=str(RAIZ / "checkpoints"),
                    help="carpeta de checkpoints (en Colab, una de Google Drive)")
    args = ap.parse_args()

    set_seed(CONFIG["semilla"])
    salida = RAIZ / "resultados/entrenamiento" / args.config
    salida.mkdir(parents=True, exist_ok=True)

    tok = AutoTokenizer.from_pretrained(CONFIG["modelo_base"])
    cuda = torch.cuda.is_available()   # sin GPU (prueba local) se entrena en fp32
    modelo = AutoModelForCausalLM.from_pretrained(
        CONFIG["modelo_base"], dtype=torch.float16 if cuda else torch.float32,
        device_map={"": 0} if cuda else None)
    modelo.gradient_checkpointing_enable(gradient_checkpointing_kwargs={"use_reentrant": False})
    modelo.enable_input_require_grads()
    lora = LoraConfig(task_type="CAUSAL_LM", bias="none", **COMUNES,
                      **CONFIGURACIONES[args.config])
    modelo = get_peft_model(modelo, lora)
    for p in modelo.parameters():       # T4: pesos LoRA en fp32 para entrenar con fp16 mixto
        if p.requires_grad:
            p.data = p.data.float()
    entrenables = sum(p.numel() for p in modelo.parameters() if p.requires_grad)
    totales = sum(p.numel() for p in modelo.parameters())
    print(f"Parámetros entrenables: {entrenables:,} de {totales:,} "
          f"({100 * entrenables / totales:.3f} %)")

    datos = RAIZ / "datos/entrenamiento"
    train = Lista([tokenizar(e, tok) for e in leer(datos / "train.jsonl", args.max_ejemplos)])
    dev = Lista([tokenizar(e, tok) for e in leer(datos / "dev_interno.jsonl", args.max_dev)])

    dir_checkpoints = Path(args.checkpoints) / args.config
    dir_checkpoints.mkdir(parents=True, exist_ok=True)
    ultimo = get_last_checkpoint(str(dir_checkpoints))
    print(f"Reanudando desde {ultimo}" if ultimo else "Sin checkpoints previos: desde cero")

    targs = TrainingArguments(
        output_dir=str(dir_checkpoints),
        num_train_epochs=HIPER["epocas"], learning_rate=HIPER["lr"],
        per_device_train_batch_size=HIPER["batch"], per_device_eval_batch_size=HIPER["batch"],
        gradient_accumulation_steps=HIPER["acumulacion"],
        lr_scheduler_type="cosine", warmup_ratio=HIPER["warmup"], weight_decay=0.0,
        fp16=cuda, logging_steps=10, eval_strategy="steps", eval_steps=HIPER["eval_cada"],
        save_strategy="steps", save_steps=HIPER["guardar_cada"], save_total_limit=2,
        report_to="none", seed=CONFIG["semilla"],
        data_seed=CONFIG["semilla"], group_by_length=True, remove_unused_columns=False, dataloader_num_workers=0,
    )
    trainer = Trainer(model=modelo, args=targs, train_dataset=train, eval_dataset=dev,
                      data_collator=Collator(tok.pad_token_id or tok.eos_token_id))
    inicio = time.time()
    trainer.train(resume_from_checkpoint=ultimo)
    minutos = (time.time() - inicio) / 60
    final = trainer.evaluate()

    modelo.save_pretrained(salida / "adapter")
    tok.save_pretrained(salida / "adapter")
    historial = trainer.state.log_history
    (salida / "historial.json").write_text(json.dumps(historial, indent=1))
    resumen = dict(
        config=args.config, modelo_base=CONFIG["modelo_base"],
        lora={**COMUNES, **CONFIGURACIONES[args.config]}, hiperparametros=HIPER,
        parametros_entrenables=entrenables, parametros_totales=totales,
        porcentaje_entrenable=round(100 * entrenables / totales, 4),
        ejemplos_train=len(train), ejemplos_dev=len(dev), pasos=trainer.state.global_step,
        minutos_entrenamiento=round(minutos, 1), reanudado_desde=ultimo,
        eval_loss_final=final["eval_loss"],
        perplejidad_dev=round(math.exp(final["eval_loss"]), 3),
        gpu=torch.cuda.get_device_name(0) if cuda else "sin GPU (prueba)",
    )
    (salida / "resumen.json").write_text(json.dumps(resumen, indent=2))
    graficar(historial, salida / "curva_loss.png", f"Configuración {args.config}")
    print(json.dumps(resumen, indent=2))


if __name__ == "__main__":
    main()
