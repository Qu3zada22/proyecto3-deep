CREATE TABLE terr (
  terr_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del territorio de ventas (terr = territorio)',
  terr_nm VARCHAR(60) NOT NULL COMMENT 'Nombre del territorio (nm = nombre)',
  rgn ENUM('NA','LATAM','EMEA','APAC') NOT NULL COMMENT 'Región comercial (rgn = región): NA Norteamérica, LATAM Latinoamérica, EMEA Europa/Medio Oriente/África, APAC Asia-Pacífico',
  ann_quota_amt DECIMAL(12,2) NOT NULL COMMENT 'Cuota anual de ventas del territorio en USD (ann = anual, amt = monto)',
  PRIMARY KEY (terr_id)
) COMMENT='Territorios de ventas (terr = territorio) en los que se divide la fuerza comercial';

CREATE TABLE rep (
  rep_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del representante de ventas (rep = representante)',
  terr_id INT NOT NULL COMMENT 'Territorio asignado al representante',
  first_nm VARCHAR(50) NOT NULL COMMENT 'Nombre de pila del representante (first_nm = primer nombre)',
  last_nm VARCHAR(50) NOT NULL COMMENT 'Apellido del representante (last_nm = apellido)',
  email VARCHAR(120) NOT NULL COMMENT 'Correo corporativo del representante',
  hire_dt DATE NOT NULL COMMENT 'Fecha de contratación (hire_dt = fecha de contratación)',
  mgr_id INT NULL COMMENT 'Representante que es su jefe directo (mgr = manager/gerente); NULL si no tiene jefe',
  is_actv TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Indica si el representante sigue activo (actv = activo; 1 = sí, 0 = no)',
  PRIMARY KEY (rep_id),
  FOREIGN KEY (terr_id) REFERENCES terr(terr_id),
  FOREIGN KEY (mgr_id) REFERENCES rep(rep_id)
) COMMENT='Representantes de ventas (rep = representante) del equipo comercial';

CREATE TABLE acct (
  acct_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la cuenta cliente (acct = account/cuenta)',
  acct_nm VARCHAR(100) NOT NULL COMMENT 'Razón social de la cuenta (nm = nombre)',
  ind VARCHAR(40) NOT NULL COMMENT 'Industria o sector de la empresa (ind = industria)',
  terr_id INT NOT NULL COMMENT 'Territorio al que pertenece la cuenta',
  ownr_rep_id INT NOT NULL COMMENT 'Representante dueño de la cuenta (ownr = owner/propietario)',
  emp_cnt INT NULL COMMENT 'Número de empleados de la empresa cliente (emp = empleados, cnt = conteo); NULL si se desconoce',
  ann_rev_amt DECIMAL(14,2) NULL COMMENT 'Ingresos anuales estimados de la empresa en USD (ann = anual, rev = revenue/ingresos, amt = monto)',
  tier ENUM('A','B','C') NOT NULL COMMENT 'Nivel de prioridad de la cuenta: A alta, B media, C baja',
  crt_dt DATE NOT NULL COMMENT 'Fecha de alta de la cuenta en el CRM (crt = creación, dt = fecha)',
  PRIMARY KEY (acct_id),
  FOREIGN KEY (terr_id) REFERENCES terr(terr_id),
  FOREIGN KEY (ownr_rep_id) REFERENCES rep(rep_id)
) COMMENT='Cuentas (acct = account): empresas clientes o prospectos B2B';

CREATE TABLE cntct (
  cntct_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del contacto (cntct = contacto)',
  acct_id INT NOT NULL COMMENT 'Cuenta a la que pertenece el contacto',
  first_nm VARCHAR(50) NOT NULL COMMENT 'Nombre de pila del contacto',
  last_nm VARCHAR(50) NOT NULL COMMENT 'Apellido del contacto',
  job_ttl VARCHAR(80) NULL COMMENT 'Cargo del contacto en su empresa (job_ttl = job title/puesto); NULL si se desconoce',
  email VARCHAR(120) NULL COMMENT 'Correo electrónico del contacto; NULL si no se tiene',
  phn VARCHAR(25) NULL COMMENT 'Teléfono del contacto (phn = phone/teléfono); NULL si no se tiene',
  is_prim TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica si es el contacto principal de la cuenta (prim = primario; 1 = sí, 0 = no)',
  PRIMARY KEY (cntct_id),
  FOREIGN KEY (acct_id) REFERENCES acct(acct_id)
) COMMENT='Contactos (cntct = contacto): personas de las empresas cliente';

CREATE TABLE opp_stage (
  stage_id INT NOT NULL COMMENT 'Identificador de la etapa del embudo de ventas',
  stage_nm VARCHAR(40) NOT NULL COMMENT 'Nombre de la etapa (nm = nombre)',
  seq_no TINYINT NOT NULL COMMENT 'Orden de la etapa dentro del embudo (seq_no = número de secuencia)',
  win_prob_pct TINYINT NOT NULL COMMENT 'Probabilidad de ganar la oportunidad en esta etapa, en porcentaje (prob = probabilidad, pct = porcentaje)',
  is_clsd TINYINT(1) NOT NULL COMMENT 'Indica si la etapa es de cierre (clsd = closed/cerrada; 1 = sí, 0 = no)',
  is_won TINYINT(1) NOT NULL COMMENT 'Indica si la etapa corresponde a una venta ganada (1 = ganada, 0 = no)',
  PRIMARY KEY (stage_id)
) COMMENT='Etapas de las oportunidades (opp = opportunity/oportunidad) en el embudo de ventas';

CREATE TABLE opp (
  opp_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la oportunidad de venta (opp = opportunity/oportunidad)',
  acct_id INT NOT NULL COMMENT 'Cuenta a la que se le quiere vender',
  rep_id INT NOT NULL COMMENT 'Representante responsable de la oportunidad',
  stage_id INT NOT NULL COMMENT 'Etapa actual de la oportunidad',
  opp_nm VARCHAR(120) NOT NULL COMMENT 'Nombre descriptivo de la oportunidad',
  amt DECIMAL(12,2) NOT NULL COMMENT 'Monto estimado de la oportunidad en USD (amt = amount/monto)',
  src ENUM('web','referral','event','outbound','partner') NOT NULL COMMENT 'Origen del lead (src = source/fuente): web, referido, evento, prospección saliente o socio',
  crt_dt DATE NOT NULL COMMENT 'Fecha de creación de la oportunidad (crt_dt = fecha de creación)',
  close_dt DATE NULL COMMENT 'Fecha real de cierre (ganada o perdida); NULL si la oportunidad sigue abierta',
  PRIMARY KEY (opp_id),
  FOREIGN KEY (acct_id) REFERENCES acct(acct_id),
  FOREIGN KEY (rep_id) REFERENCES rep(rep_id),
  FOREIGN KEY (stage_id) REFERENCES opp_stage(stage_id)
) COMMENT='Oportunidades de venta (opp = opportunity) del embudo comercial';

CREATE TABLE qte (
  qte_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la cotización (qte = quote/cotización)',
  opp_id INT NOT NULL COMMENT 'Oportunidad a la que corresponde la cotización',
  qte_dt DATE NOT NULL COMMENT 'Fecha de emisión de la cotización (dt = fecha)',
  exp_dt DATE NOT NULL COMMENT 'Fecha de vencimiento de la cotización (exp = expiración)',
  disc_pct DECIMAL(5,2) NOT NULL DEFAULT 0 COMMENT 'Descuento global ofrecido en porcentaje (disc = descuento, pct = porcentaje)',
  qte_amt DECIMAL(12,2) NOT NULL COMMENT 'Monto total cotizado en USD después del descuento (amt = monto)',
  sts ENUM('draft','sent','accepted','rejected') NOT NULL COMMENT 'Estado de la cotización (sts = status/estado): borrador, enviada, aceptada o rechazada',
  PRIMARY KEY (qte_id),
  FOREIGN KEY (opp_id) REFERENCES opp(opp_id)
) COMMENT='Cotizaciones (qte = quote) enviadas a los clientes para una oportunidad';

CREATE TABLE ord_hdr (
  ord_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del pedido (ord = order/pedido)',
  acct_id INT NOT NULL COMMENT 'Cuenta que realiza el pedido',
  rep_id INT NOT NULL COMMENT 'Representante que registró el pedido',
  qte_id INT NULL COMMENT 'Cotización que originó el pedido; NULL si fue un pedido directo sin cotización',
  ord_dt DATETIME NOT NULL COMMENT 'Fecha y hora en que se registró el pedido (dt = fecha)',
  ship_dt DATE NULL COMMENT 'Fecha de envío o entrega (ship = envío); NULL si aún no se envía',
  sts ENUM('open','shipped','invoiced','cancelled') NOT NULL COMMENT 'Estado del pedido (sts = estado): abierto, enviado, facturado o cancelado',
  pmt_terms ENUM('NET15','NET30','NET60','PREPAID') NOT NULL COMMENT 'Condiciones de pago (pmt = payment/pago): neto a 15, 30 o 60 días, o prepagado',
  PRIMARY KEY (ord_id),
  FOREIGN KEY (acct_id) REFERENCES acct(acct_id),
  FOREIGN KEY (rep_id) REFERENCES rep(rep_id),
  FOREIGN KEY (qte_id) REFERENCES qte(qte_id)
) COMMENT='Encabezado de pedidos (ord_hdr = order header/encabezado de pedido)';

CREATE TABLE ord_ln (
  ord_ln_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la línea de pedido (ln = line/línea)',
  ord_id INT NOT NULL COMMENT 'Pedido al que pertenece la línea',
  ln_no TINYINT NOT NULL COMMENT 'Número de línea dentro del pedido (no = número)',
  prod_cd VARCHAR(20) NOT NULL COMMENT 'Código del producto (prod = producto, cd = código)',
  prod_nm VARCHAR(80) NOT NULL COMMENT 'Nombre del producto vendido',
  prod_cat ENUM('software','hardware','services','support') NOT NULL COMMENT 'Categoría del producto (cat = categoría): software, hardware, servicios o soporte',
  qty INT NOT NULL COMMENT 'Cantidad de unidades (qty = quantity/cantidad)',
  unit_prc DECIMAL(10,2) NOT NULL COMMENT 'Precio unitario en USD antes de descuento (prc = price/precio)',
  disc_pct DECIMAL(5,2) NOT NULL DEFAULT 0 COMMENT 'Descuento aplicado a la línea en porcentaje (disc = descuento, pct = porcentaje)',
  PRIMARY KEY (ord_ln_id),
  FOREIGN KEY (ord_id) REFERENCES ord_hdr(ord_id)
) COMMENT='Líneas o renglones de cada pedido (ord_ln = order line/línea de pedido)';
