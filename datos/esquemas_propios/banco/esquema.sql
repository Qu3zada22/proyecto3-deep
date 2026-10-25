CREATE TABLE suc (
  suc_id INT NOT NULL COMMENT 'Identificador de la sucursal (suc = sucursal)',
  nom_suc VARCHAR(80) NOT NULL COMMENT 'Nombre de la sucursal (nom = nombre)',
  ciu VARCHAR(50) NOT NULL COMMENT 'Ciudad donde está la sucursal (ciu = ciudad)',
  dir VARCHAR(120) NULL COMMENT 'Dirección física de la sucursal (dir = dirección)',
  fec_apert DATE NOT NULL COMMENT 'Fecha de apertura de la sucursal (fec_apert = fecha de apertura)',
  PRIMARY KEY (suc_id)
) COMMENT='Sucursales del banco (suc = sucursal)';

CREATE TABLE emp (
  emp_id INT NOT NULL COMMENT 'Identificador del empleado (emp = empleado)',
  nom_emp VARCHAR(60) NOT NULL COMMENT 'Nombre del empleado',
  ape_emp VARCHAR(60) NOT NULL COMMENT 'Apellido del empleado (ape = apellido)',
  cargo ENUM('cajero','asesor','gerente','analista') NOT NULL COMMENT 'Puesto que ocupa el empleado',
  suc_id INT NOT NULL COMMENT 'Sucursal donde trabaja el empleado',
  sal DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual en quetzales (sal = salario)',
  fec_ing DATE NOT NULL COMMENT 'Fecha de ingreso al banco (fec_ing = fecha de ingreso)',
  jefe_id INT NULL COMMENT 'Empleado que es su jefe directo (NULL si no tiene)',
  PRIMARY KEY (emp_id),
  FOREIGN KEY (suc_id) REFERENCES suc (suc_id),
  FOREIGN KEY (jefe_id) REFERENCES emp (emp_id)
) COMMENT='Empleados del banco (emp = empleado)';

CREATE TABLE cli (
  cli_id INT NOT NULL COMMENT 'Identificador del cliente (cli = cliente)',
  nom_cli VARCHAR(60) NOT NULL COMMENT 'Nombre del cliente',
  ape_cli VARCHAR(60) NOT NULL COMMENT 'Apellido del cliente (ape = apellido)',
  dpi VARCHAR(15) NOT NULL COMMENT 'Documento Personal de Identificación del cliente',
  fec_nac DATE NOT NULL COMMENT 'Fecha de nacimiento del cliente (fec_nac = fecha de nacimiento)',
  tel VARCHAR(15) NULL COMMENT 'Teléfono del cliente (tel = teléfono)',
  email VARCHAR(100) NULL COMMENT 'Correo electrónico del cliente',
  suc_id INT NOT NULL COMMENT 'Sucursal donde se afilió el cliente',
  fec_alta DATE NOT NULL COMMENT 'Fecha en que el cliente se dio de alta en el banco',
  seg ENUM('basico','oro','platino') NOT NULL COMMENT 'Segmento del cliente (seg = segmento)',
  PRIMARY KEY (cli_id),
  FOREIGN KEY (suc_id) REFERENCES suc (suc_id)
) COMMENT='Clientes del banco (cli = cliente)';

CREATE TABLE cta (
  cta_id INT NOT NULL COMMENT 'Identificador de la cuenta (cta = cuenta)',
  num_cta VARCHAR(20) NOT NULL COMMENT 'Número de cuenta visible para el cliente (num = número)',
  cli_id INT NOT NULL COMMENT 'Cliente titular de la cuenta',
  suc_id INT NOT NULL COMMENT 'Sucursal donde se abrió la cuenta',
  tipo_cta ENUM('ahorro','monetaria','plazo_fijo') NOT NULL COMMENT 'Tipo de cuenta',
  mon ENUM('GTQ','USD') NOT NULL COMMENT 'Moneda de la cuenta (mon = moneda): GTQ quetzales, USD dólares',
  sdo DECIMAL(12,2) NOT NULL COMMENT 'Saldo actual de la cuenta (sdo = saldo)',
  fec_aper DATE NOT NULL COMMENT 'Fecha de apertura de la cuenta (fec_aper = fecha de apertura)',
  act TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 si la cuenta está activa, 0 si está cerrada (act = activa)',
  PRIMARY KEY (cta_id),
  FOREIGN KEY (cli_id) REFERENCES cli (cli_id),
  FOREIGN KEY (suc_id) REFERENCES suc (suc_id)
) COMMENT='Cuentas bancarias de los clientes (cta = cuenta)';

CREATE TABLE trx (
  trx_id INT NOT NULL COMMENT 'Identificador de la transacción (trx = transacción)',
  cta_id INT NOT NULL COMMENT 'Cuenta de origen de la transacción',
  fec_trx DATETIME NOT NULL COMMENT 'Fecha y hora de la transacción (fec_trx = fecha de transacción)',
  tipo_trx ENUM('dep','ret','trf','pago') NOT NULL COMMENT 'Tipo: dep = depósito, ret = retiro, trf = transferencia, pago = pago de servicio',
  mto DECIMAL(12,2) NOT NULL COMMENT 'Monto de la transacción en la moneda de la cuenta (mto = monto)',
  canal ENUM('cajero','app','ventanilla','web') NOT NULL COMMENT 'Canal por el que se hizo la transacción',
  cta_dest_id INT NULL COMMENT 'Cuenta destino si es transferencia interna (cta_dest = cuenta destino), NULL en otro caso',
  PRIMARY KEY (trx_id),
  FOREIGN KEY (cta_id) REFERENCES cta (cta_id),
  FOREIGN KEY (cta_dest_id) REFERENCES cta (cta_id)
) COMMENT='Transacciones realizadas sobre las cuentas (trx = transacción)';

CREATE TABLE tarj (
  tarj_id INT NOT NULL COMMENT 'Identificador de la tarjeta (tarj = tarjeta)',
  cta_id INT NOT NULL COMMENT 'Cuenta asociada a la tarjeta',
  num_tarj VARCHAR(19) NOT NULL COMMENT 'Número de tarjeta enmascarado (num_tarj = número de tarjeta)',
  tipo_tarj ENUM('debito','credito') NOT NULL COMMENT 'Tipo de tarjeta: débito o crédito',
  lim_cred DECIMAL(10,2) NULL COMMENT 'Límite de crédito (lim_cred = límite de crédito), NULL en tarjetas de débito',
  fec_emi DATE NOT NULL COMMENT 'Fecha de emisión de la tarjeta (fec_emi = fecha de emisión)',
  fec_venc DATE NOT NULL COMMENT 'Fecha de vencimiento de la tarjeta (fec_venc = fecha de vencimiento)',
  bloq TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1 si la tarjeta está bloqueada, 0 si no (bloq = bloqueada)',
  PRIMARY KEY (tarj_id),
  FOREIGN KEY (cta_id) REFERENCES cta (cta_id)
) COMMENT='Tarjetas de débito y crédito emitidas (tarj = tarjeta)';

CREATE TABLE prest (
  prest_id INT NOT NULL COMMENT 'Identificador del préstamo (prest = préstamo)',
  cli_id INT NOT NULL COMMENT 'Cliente que recibió el préstamo',
  emp_id INT NOT NULL COMMENT 'Empleado asesor que gestionó el préstamo',
  tipo_prest ENUM('personal','hipotecario','vehicular','empresarial') NOT NULL COMMENT 'Tipo de préstamo',
  mto_prest DECIMAL(12,2) NOT NULL COMMENT 'Monto prestado en quetzales (mto_prest = monto del préstamo)',
  tasa DECIMAL(5,2) NOT NULL COMMENT 'Tasa de interés anual en porcentaje',
  plazo_mes INT NOT NULL COMMENT 'Plazo del préstamo en meses',
  fec_desemb DATE NOT NULL COMMENT 'Fecha de desembolso del préstamo (fec_desemb = fecha de desembolso)',
  est_prest ENUM('vigente','pagado','moroso') NOT NULL COMMENT 'Estado del préstamo (est = estado)',
  PRIMARY KEY (prest_id),
  FOREIGN KEY (cli_id) REFERENCES cli (cli_id),
  FOREIGN KEY (emp_id) REFERENCES emp (emp_id)
) COMMENT='Préstamos otorgados a clientes (prest = préstamo)';

CREATE TABLE pag_prest (
  pag_id INT NOT NULL COMMENT 'Identificador del pago (pag = pago)',
  prest_id INT NOT NULL COMMENT 'Préstamo al que se abona',
  fec_pag DATE NOT NULL COMMENT 'Fecha del pago (fec_pag = fecha de pago)',
  mto_pag DECIMAL(12,2) NOT NULL COMMENT 'Monto abonado en quetzales (mto_pag = monto pagado)',
  mto_mora DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT 'Recargo por mora cobrado en el pago (mto_mora = monto de mora)',
  PRIMARY KEY (pag_id),
  FOREIGN KEY (prest_id) REFERENCES prest (prest_id)
) COMMENT='Pagos (cuotas) realizados a los préstamos (pag_prest = pago de préstamo)';
