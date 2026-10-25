CREATE TABLE `cli` (
  `cli_id` int NOT NULL COMMENT 'Identificador del cliente (cli = cliente)',
  `nom_cli` varchar(60) NOT NULL COMMENT 'Nombre del cliente',
  `ape_cli` varchar(60) NOT NULL COMMENT 'Apellido del cliente (ape = apellido)',
  `dpi` varchar(15) NOT NULL COMMENT 'Documento Personal de Identificación del cliente',
  `fec_nac` date NOT NULL COMMENT 'Fecha de nacimiento del cliente (fec_nac = fecha de nacimiento)',
  `tel` varchar(15) DEFAULT NULL COMMENT 'Teléfono del cliente (tel = teléfono)',
  `email` varchar(100) DEFAULT NULL COMMENT 'Correo electrónico del cliente',
  `suc_id` int NOT NULL COMMENT 'Sucursal donde se afilió el cliente',
  `fec_alta` date NOT NULL COMMENT 'Fecha en que el cliente se dio de alta en el banco',
  `seg` enum('basico','oro','platino') NOT NULL COMMENT 'Segmento del cliente (seg = segmento)',
  PRIMARY KEY (`cli_id`),
  KEY `suc_id` (`suc_id`),
  CONSTRAINT `cli_ibfk_1` FOREIGN KEY (`suc_id`) REFERENCES `suc` (`suc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Clientes del banco (cli = cliente)';

CREATE TABLE `cta` (
  `cta_id` int NOT NULL COMMENT 'Identificador de la cuenta (cta = cuenta)',
  `num_cta` varchar(20) NOT NULL COMMENT 'Número de cuenta visible para el cliente (num = número)',
  `cli_id` int NOT NULL COMMENT 'Cliente titular de la cuenta',
  `suc_id` int NOT NULL COMMENT 'Sucursal donde se abrió la cuenta',
  `tipo_cta` enum('ahorro','monetaria','plazo_fijo') NOT NULL COMMENT 'Tipo de cuenta',
  `mon` enum('GTQ','USD') NOT NULL COMMENT 'Moneda de la cuenta (mon = moneda): GTQ quetzales, USD dólares',
  `sdo` decimal(12,2) NOT NULL COMMENT 'Saldo actual de la cuenta (sdo = saldo)',
  `fec_aper` date NOT NULL COMMENT 'Fecha de apertura de la cuenta (fec_aper = fecha de apertura)',
  `act` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 si la cuenta está activa, 0 si está cerrada (act = activa)',
  PRIMARY KEY (`cta_id`),
  KEY `cli_id` (`cli_id`),
  KEY `suc_id` (`suc_id`),
  CONSTRAINT `cta_ibfk_1` FOREIGN KEY (`cli_id`) REFERENCES `cli` (`cli_id`),
  CONSTRAINT `cta_ibfk_2` FOREIGN KEY (`suc_id`) REFERENCES `suc` (`suc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cuentas bancarias de los clientes (cta = cuenta)';

CREATE TABLE `emp` (
  `emp_id` int NOT NULL COMMENT 'Identificador del empleado (emp = empleado)',
  `nom_emp` varchar(60) NOT NULL COMMENT 'Nombre del empleado',
  `ape_emp` varchar(60) NOT NULL COMMENT 'Apellido del empleado (ape = apellido)',
  `cargo` enum('cajero','asesor','gerente','analista') NOT NULL COMMENT 'Puesto que ocupa el empleado',
  `suc_id` int NOT NULL COMMENT 'Sucursal donde trabaja el empleado',
  `sal` decimal(10,2) NOT NULL COMMENT 'Salario mensual en quetzales (sal = salario)',
  `fec_ing` date NOT NULL COMMENT 'Fecha de ingreso al banco (fec_ing = fecha de ingreso)',
  `jefe_id` int DEFAULT NULL COMMENT 'Empleado que es su jefe directo (NULL si no tiene)',
  PRIMARY KEY (`emp_id`),
  KEY `suc_id` (`suc_id`),
  KEY `jefe_id` (`jefe_id`),
  CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`suc_id`) REFERENCES `suc` (`suc_id`),
  CONSTRAINT `emp_ibfk_2` FOREIGN KEY (`jefe_id`) REFERENCES `emp` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Empleados del banco (emp = empleado)';

CREATE TABLE `pag_prest` (
  `pag_id` int NOT NULL COMMENT 'Identificador del pago (pag = pago)',
  `prest_id` int NOT NULL COMMENT 'Préstamo al que se abona',
  `fec_pag` date NOT NULL COMMENT 'Fecha del pago (fec_pag = fecha de pago)',
  `mto_pag` decimal(12,2) NOT NULL COMMENT 'Monto abonado en quetzales (mto_pag = monto pagado)',
  `mto_mora` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Recargo por mora cobrado en el pago (mto_mora = monto de mora)',
  PRIMARY KEY (`pag_id`),
  KEY `prest_id` (`prest_id`),
  CONSTRAINT `pag_prest_ibfk_1` FOREIGN KEY (`prest_id`) REFERENCES `prest` (`prest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Pagos (cuotas) realizados a los préstamos (pag_prest = pago de préstamo)';

CREATE TABLE `prest` (
  `prest_id` int NOT NULL COMMENT 'Identificador del préstamo (prest = préstamo)',
  `cli_id` int NOT NULL COMMENT 'Cliente que recibió el préstamo',
  `emp_id` int NOT NULL COMMENT 'Empleado asesor que gestionó el préstamo',
  `tipo_prest` enum('personal','hipotecario','vehicular','empresarial') NOT NULL COMMENT 'Tipo de préstamo',
  `mto_prest` decimal(12,2) NOT NULL COMMENT 'Monto prestado en quetzales (mto_prest = monto del préstamo)',
  `tasa` decimal(5,2) NOT NULL COMMENT 'Tasa de interés anual en porcentaje',
  `plazo_mes` int NOT NULL COMMENT 'Plazo del préstamo en meses',
  `fec_desemb` date NOT NULL COMMENT 'Fecha de desembolso del préstamo (fec_desemb = fecha de desembolso)',
  `est_prest` enum('vigente','pagado','moroso') NOT NULL COMMENT 'Estado del préstamo (est = estado)',
  PRIMARY KEY (`prest_id`),
  KEY `cli_id` (`cli_id`),
  KEY `emp_id` (`emp_id`),
  CONSTRAINT `prest_ibfk_1` FOREIGN KEY (`cli_id`) REFERENCES `cli` (`cli_id`),
  CONSTRAINT `prest_ibfk_2` FOREIGN KEY (`emp_id`) REFERENCES `emp` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Préstamos otorgados a clientes (prest = préstamo)';

CREATE TABLE `suc` (
  `suc_id` int NOT NULL COMMENT 'Identificador de la sucursal (suc = sucursal)',
  `nom_suc` varchar(80) NOT NULL COMMENT 'Nombre de la sucursal (nom = nombre)',
  `ciu` varchar(50) NOT NULL COMMENT 'Ciudad donde está la sucursal (ciu = ciudad)',
  `dir` varchar(120) DEFAULT NULL COMMENT 'Dirección física de la sucursal (dir = dirección)',
  `fec_apert` date NOT NULL COMMENT 'Fecha de apertura de la sucursal (fec_apert = fecha de apertura)',
  PRIMARY KEY (`suc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Sucursales del banco (suc = sucursal)';

CREATE TABLE `tarj` (
  `tarj_id` int NOT NULL COMMENT 'Identificador de la tarjeta (tarj = tarjeta)',
  `cta_id` int NOT NULL COMMENT 'Cuenta asociada a la tarjeta',
  `num_tarj` varchar(19) NOT NULL COMMENT 'Número de tarjeta enmascarado (num_tarj = número de tarjeta)',
  `tipo_tarj` enum('debito','credito') NOT NULL COMMENT 'Tipo de tarjeta: débito o crédito',
  `lim_cred` decimal(10,2) DEFAULT NULL COMMENT 'Límite de crédito (lim_cred = límite de crédito), NULL en tarjetas de débito',
  `fec_emi` date NOT NULL COMMENT 'Fecha de emisión de la tarjeta (fec_emi = fecha de emisión)',
  `fec_venc` date NOT NULL COMMENT 'Fecha de vencimiento de la tarjeta (fec_venc = fecha de vencimiento)',
  `bloq` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 si la tarjeta está bloqueada, 0 si no (bloq = bloqueada)',
  PRIMARY KEY (`tarj_id`),
  KEY `cta_id` (`cta_id`),
  CONSTRAINT `tarj_ibfk_1` FOREIGN KEY (`cta_id`) REFERENCES `cta` (`cta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tarjetas de débito y crédito emitidas (tarj = tarjeta)';

CREATE TABLE `trx` (
  `trx_id` int NOT NULL COMMENT 'Identificador de la transacción (trx = transacción)',
  `cta_id` int NOT NULL COMMENT 'Cuenta de origen de la transacción',
  `fec_trx` datetime NOT NULL COMMENT 'Fecha y hora de la transacción (fec_trx = fecha de transacción)',
  `tipo_trx` enum('dep','ret','trf','pago') NOT NULL COMMENT 'Tipo: dep = depósito, ret = retiro, trf = transferencia, pago = pago de servicio',
  `mto` decimal(12,2) NOT NULL COMMENT 'Monto de la transacción en la moneda de la cuenta (mto = monto)',
  `canal` enum('cajero','app','ventanilla','web') NOT NULL COMMENT 'Canal por el que se hizo la transacción',
  `cta_dest_id` int DEFAULT NULL COMMENT 'Cuenta destino si es transferencia interna (cta_dest = cuenta destino), NULL en otro caso',
  PRIMARY KEY (`trx_id`),
  KEY `cta_id` (`cta_id`),
  KEY `cta_dest_id` (`cta_dest_id`),
  CONSTRAINT `trx_ibfk_1` FOREIGN KEY (`cta_id`) REFERENCES `cta` (`cta_id`),
  CONSTRAINT `trx_ibfk_2` FOREIGN KEY (`cta_dest_id`) REFERENCES `cta` (`cta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Transacciones realizadas sobre las cuentas (trx = transacción)';
