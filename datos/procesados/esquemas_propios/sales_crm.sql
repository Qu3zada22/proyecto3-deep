CREATE TABLE `acct` (
  `acct_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la cuenta cliente (acct = account/cuenta)',
  `acct_nm` varchar(100) NOT NULL COMMENT 'Razón social de la cuenta (nm = nombre)',
  `ind` varchar(40) NOT NULL COMMENT 'Industria o sector de la empresa (ind = industria)',
  `terr_id` int NOT NULL COMMENT 'Territorio al que pertenece la cuenta',
  `ownr_rep_id` int NOT NULL COMMENT 'Representante dueño de la cuenta (ownr = owner/propietario)',
  `emp_cnt` int DEFAULT NULL COMMENT 'Número de empleados de la empresa cliente (emp = empleados, cnt = conteo); NULL si se desconoce',
  `ann_rev_amt` decimal(14,2) DEFAULT NULL COMMENT 'Ingresos anuales estimados de la empresa en USD (ann = anual, rev = revenue/ingresos, amt = monto)',
  `tier` enum('A','B','C') NOT NULL COMMENT 'Nivel de prioridad de la cuenta: A alta, B media, C baja',
  `crt_dt` date NOT NULL COMMENT 'Fecha de alta de la cuenta en el CRM (crt = creación, dt = fecha)',
  PRIMARY KEY (`acct_id`),
  KEY `terr_id` (`terr_id`),
  KEY `ownr_rep_id` (`ownr_rep_id`),
  CONSTRAINT `acct_ibfk_1` FOREIGN KEY (`terr_id`) REFERENCES `terr` (`terr_id`),
  CONSTRAINT `acct_ibfk_2` FOREIGN KEY (`ownr_rep_id`) REFERENCES `rep` (`rep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cuentas (acct = account): empresas clientes o prospectos B2B';

CREATE TABLE `cntct` (
  `cntct_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del contacto (cntct = contacto)',
  `acct_id` int NOT NULL COMMENT 'Cuenta a la que pertenece el contacto',
  `first_nm` varchar(50) NOT NULL COMMENT 'Nombre de pila del contacto',
  `last_nm` varchar(50) NOT NULL COMMENT 'Apellido del contacto',
  `job_ttl` varchar(80) DEFAULT NULL COMMENT 'Cargo del contacto en su empresa (job_ttl = job title/puesto); NULL si se desconoce',
  `email` varchar(120) DEFAULT NULL COMMENT 'Correo electrónico del contacto; NULL si no se tiene',
  `phn` varchar(25) DEFAULT NULL COMMENT 'Teléfono del contacto (phn = phone/teléfono); NULL si no se tiene',
  `is_prim` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indica si es el contacto principal de la cuenta (prim = primario; 1 = sí, 0 = no)',
  PRIMARY KEY (`cntct_id`),
  KEY `acct_id` (`acct_id`),
  CONSTRAINT `cntct_ibfk_1` FOREIGN KEY (`acct_id`) REFERENCES `acct` (`acct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Contactos (cntct = contacto): personas de las empresas cliente';

CREATE TABLE `opp` (
  `opp_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la oportunidad de venta (opp = opportunity/oportunidad)',
  `acct_id` int NOT NULL COMMENT 'Cuenta a la que se le quiere vender',
  `rep_id` int NOT NULL COMMENT 'Representante responsable de la oportunidad',
  `stage_id` int NOT NULL COMMENT 'Etapa actual de la oportunidad',
  `opp_nm` varchar(120) NOT NULL COMMENT 'Nombre descriptivo de la oportunidad',
  `amt` decimal(12,2) NOT NULL COMMENT 'Monto estimado de la oportunidad en USD (amt = amount/monto)',
  `src` enum('web','referral','event','outbound','partner') NOT NULL COMMENT 'Origen del lead (src = source/fuente): web, referido, evento, prospección saliente o socio',
  `crt_dt` date NOT NULL COMMENT 'Fecha de creación de la oportunidad (crt_dt = fecha de creación)',
  `close_dt` date DEFAULT NULL COMMENT 'Fecha real de cierre (ganada o perdida); NULL si la oportunidad sigue abierta',
  PRIMARY KEY (`opp_id`),
  KEY `acct_id` (`acct_id`),
  KEY `rep_id` (`rep_id`),
  KEY `stage_id` (`stage_id`),
  CONSTRAINT `opp_ibfk_1` FOREIGN KEY (`acct_id`) REFERENCES `acct` (`acct_id`),
  CONSTRAINT `opp_ibfk_2` FOREIGN KEY (`rep_id`) REFERENCES `rep` (`rep_id`),
  CONSTRAINT `opp_ibfk_3` FOREIGN KEY (`stage_id`) REFERENCES `opp_stage` (`stage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Oportunidades de venta (opp = opportunity) del embudo comercial';

CREATE TABLE `opp_stage` (
  `stage_id` int NOT NULL COMMENT 'Identificador de la etapa del embudo de ventas',
  `stage_nm` varchar(40) NOT NULL COMMENT 'Nombre de la etapa (nm = nombre)',
  `seq_no` tinyint NOT NULL COMMENT 'Orden de la etapa dentro del embudo (seq_no = número de secuencia)',
  `win_prob_pct` tinyint NOT NULL COMMENT 'Probabilidad de ganar la oportunidad en esta etapa, en porcentaje (prob = probabilidad, pct = porcentaje)',
  `is_clsd` tinyint(1) NOT NULL COMMENT 'Indica si la etapa es de cierre (clsd = closed/cerrada; 1 = sí, 0 = no)',
  `is_won` tinyint(1) NOT NULL COMMENT 'Indica si la etapa corresponde a una venta ganada (1 = ganada, 0 = no)',
  PRIMARY KEY (`stage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Etapas de las oportunidades (opp = opportunity/oportunidad) en el embudo de ventas';

CREATE TABLE `ord_hdr` (
  `ord_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del pedido (ord = order/pedido)',
  `acct_id` int NOT NULL COMMENT 'Cuenta que realiza el pedido',
  `rep_id` int NOT NULL COMMENT 'Representante que registró el pedido',
  `qte_id` int DEFAULT NULL COMMENT 'Cotización que originó el pedido; NULL si fue un pedido directo sin cotización',
  `ord_dt` datetime NOT NULL COMMENT 'Fecha y hora en que se registró el pedido (dt = fecha)',
  `ship_dt` date DEFAULT NULL COMMENT 'Fecha de envío o entrega (ship = envío); NULL si aún no se envía',
  `sts` enum('open','shipped','invoiced','cancelled') NOT NULL COMMENT 'Estado del pedido (sts = estado): abierto, enviado, facturado o cancelado',
  `pmt_terms` enum('NET15','NET30','NET60','PREPAID') NOT NULL COMMENT 'Condiciones de pago (pmt = payment/pago): neto a 15, 30 o 60 días, o prepagado',
  PRIMARY KEY (`ord_id`),
  KEY `acct_id` (`acct_id`),
  KEY `rep_id` (`rep_id`),
  KEY `qte_id` (`qte_id`),
  CONSTRAINT `ord_hdr_ibfk_1` FOREIGN KEY (`acct_id`) REFERENCES `acct` (`acct_id`),
  CONSTRAINT `ord_hdr_ibfk_2` FOREIGN KEY (`rep_id`) REFERENCES `rep` (`rep_id`),
  CONSTRAINT `ord_hdr_ibfk_3` FOREIGN KEY (`qte_id`) REFERENCES `qte` (`qte_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Encabezado de pedidos (ord_hdr = order header/encabezado de pedido)';

CREATE TABLE `ord_ln` (
  `ord_ln_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la línea de pedido (ln = line/línea)',
  `ord_id` int NOT NULL COMMENT 'Pedido al que pertenece la línea',
  `ln_no` tinyint NOT NULL COMMENT 'Número de línea dentro del pedido (no = número)',
  `prod_cd` varchar(20) NOT NULL COMMENT 'Código del producto (prod = producto, cd = código)',
  `prod_nm` varchar(80) NOT NULL COMMENT 'Nombre del producto vendido',
  `prod_cat` enum('software','hardware','services','support') NOT NULL COMMENT 'Categoría del producto (cat = categoría): software, hardware, servicios o soporte',
  `qty` int NOT NULL COMMENT 'Cantidad de unidades (qty = quantity/cantidad)',
  `unit_prc` decimal(10,2) NOT NULL COMMENT 'Precio unitario en USD antes de descuento (prc = price/precio)',
  `disc_pct` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Descuento aplicado a la línea en porcentaje (disc = descuento, pct = porcentaje)',
  PRIMARY KEY (`ord_ln_id`),
  KEY `ord_id` (`ord_id`),
  CONSTRAINT `ord_ln_ibfk_1` FOREIGN KEY (`ord_id`) REFERENCES `ord_hdr` (`ord_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Líneas o renglones de cada pedido (ord_ln = order line/línea de pedido)';

CREATE TABLE `qte` (
  `qte_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la cotización (qte = quote/cotización)',
  `opp_id` int NOT NULL COMMENT 'Oportunidad a la que corresponde la cotización',
  `qte_dt` date NOT NULL COMMENT 'Fecha de emisión de la cotización (dt = fecha)',
  `exp_dt` date NOT NULL COMMENT 'Fecha de vencimiento de la cotización (exp = expiración)',
  `disc_pct` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Descuento global ofrecido en porcentaje (disc = descuento, pct = porcentaje)',
  `qte_amt` decimal(12,2) NOT NULL COMMENT 'Monto total cotizado en USD después del descuento (amt = monto)',
  `sts` enum('draft','sent','accepted','rejected') NOT NULL COMMENT 'Estado de la cotización (sts = status/estado): borrador, enviada, aceptada o rechazada',
  PRIMARY KEY (`qte_id`),
  KEY `opp_id` (`opp_id`),
  CONSTRAINT `qte_ibfk_1` FOREIGN KEY (`opp_id`) REFERENCES `opp` (`opp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cotizaciones (qte = quote) enviadas a los clientes para una oportunidad';

CREATE TABLE `rep` (
  `rep_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del representante de ventas (rep = representante)',
  `terr_id` int NOT NULL COMMENT 'Territorio asignado al representante',
  `first_nm` varchar(50) NOT NULL COMMENT 'Nombre de pila del representante (first_nm = primer nombre)',
  `last_nm` varchar(50) NOT NULL COMMENT 'Apellido del representante (last_nm = apellido)',
  `email` varchar(120) NOT NULL COMMENT 'Correo corporativo del representante',
  `hire_dt` date NOT NULL COMMENT 'Fecha de contratación (hire_dt = fecha de contratación)',
  `mgr_id` int DEFAULT NULL COMMENT 'Representante que es su jefe directo (mgr = manager/gerente); NULL si no tiene jefe',
  `is_actv` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indica si el representante sigue activo (actv = activo; 1 = sí, 0 = no)',
  PRIMARY KEY (`rep_id`),
  KEY `terr_id` (`terr_id`),
  KEY `mgr_id` (`mgr_id`),
  CONSTRAINT `rep_ibfk_1` FOREIGN KEY (`terr_id`) REFERENCES `terr` (`terr_id`),
  CONSTRAINT `rep_ibfk_2` FOREIGN KEY (`mgr_id`) REFERENCES `rep` (`rep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Representantes de ventas (rep = representante) del equipo comercial';

CREATE TABLE `terr` (
  `terr_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del territorio de ventas (terr = territorio)',
  `terr_nm` varchar(60) NOT NULL COMMENT 'Nombre del territorio (nm = nombre)',
  `rgn` enum('NA','LATAM','EMEA','APAC') NOT NULL COMMENT 'Región comercial (rgn = región): NA Norteamérica, LATAM Latinoamérica, EMEA Europa/Medio Oriente/África, APAC Asia-Pacífico',
  `ann_quota_amt` decimal(12,2) NOT NULL COMMENT 'Cuota anual de ventas del territorio en USD (ann = anual, amt = monto)',
  PRIMARY KEY (`terr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Territorios de ventas (terr = territorio) en los que se divide la fuerza comercial';
