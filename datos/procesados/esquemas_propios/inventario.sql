CREATE TABLE `alm` (
  `id_alm` int NOT NULL COMMENT 'Identificador del almacén (alm = almacén)',
  `nom_alm` varchar(60) NOT NULL COMMENT 'Nombre del almacén',
  `ciu_alm` varchar(60) NOT NULL COMMENT 'Ciudad donde está el almacén (ciu = ciudad)',
  `cap_m3` decimal(10,2) NOT NULL COMMENT 'Capacidad del almacén en metros cúbicos (cap = capacidad)',
  `resp_alm` varchar(100) DEFAULT NULL COMMENT 'Nombre del responsable del almacén (resp = responsable); NULL si no hay asignado',
  PRIMARY KEY (`id_alm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Almacenes o bodegas de la empresa (alm = almacén)';

CREATE TABLE `art` (
  `id_art` int NOT NULL COMMENT 'Identificador del artículo (art = artículo)',
  `cod_art` varchar(20) NOT NULL COMMENT 'Código interno o SKU del artículo (cod = código)',
  `nom_art` varchar(100) NOT NULL COMMENT 'Nombre o descripción corta del artículo',
  `id_cat` int NOT NULL COMMENT 'Categoría del artículo (referencia a cat_art)',
  `id_prov` int NOT NULL COMMENT 'Proveedor principal del artículo (referencia a prov)',
  `um` enum('UND','KG','LT','CJ','MT') NOT NULL COMMENT 'Unidad de medida (um): UND = unidad, KG = kilogramo, LT = litro, CJ = caja, MT = metro',
  `pu` decimal(10,2) NOT NULL COMMENT 'Precio unitario de costo en quetzales (pu = precio unitario)',
  `pv` decimal(10,2) NOT NULL COMMENT 'Precio de venta unitario en quetzales (pv = precio de venta)',
  `stk_min` int NOT NULL COMMENT 'Stock mínimo antes de reordenar (stk = stock, min = mínimo)',
  `act` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Artículo activo: 1 = sí, 0 = descontinuado (act = activo)',
  PRIMARY KEY (`id_art`),
  KEY `id_cat` (`id_cat`),
  KEY `id_prov` (`id_prov`),
  CONSTRAINT `art_ibfk_1` FOREIGN KEY (`id_cat`) REFERENCES `cat_art` (`id_cat`),
  CONSTRAINT `art_ibfk_2` FOREIGN KEY (`id_prov`) REFERENCES `prov` (`id_prov`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Catálogo de artículos (art = artículo)';

CREATE TABLE `cat_art` (
  `id_cat` int NOT NULL COMMENT 'Identificador de la categoría de artículo (cat = categoría, art = artículo)',
  `nom_cat` varchar(60) NOT NULL COMMENT 'Nombre de la categoría (nom = nombre)',
  `desc_cat` varchar(200) DEFAULT NULL COMMENT 'Descripción de la categoría (desc = descripción)',
  PRIMARY KEY (`id_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Categorías de artículos (cat_art = categoría de artículo)';

CREATE TABLE `emp` (
  `id_emp` int NOT NULL COMMENT 'Identificador del empleado (emp = empleado)',
  `nom_emp` varchar(60) NOT NULL COMMENT 'Nombre del empleado',
  `ape_emp` varchar(60) NOT NULL COMMENT 'Apellido del empleado (ape = apellido)',
  `crg_emp` enum('BOD','COMP','SUP','GER') NOT NULL COMMENT 'Cargo (crg): BOD = bodeguero, COMP = comprador, SUP = supervisor, GER = gerente',
  `id_alm` int NOT NULL COMMENT 'Almacén donde trabaja el empleado',
  `fec_ing` date NOT NULL COMMENT 'Fecha de ingreso a la empresa (fec = fecha, ing = ingreso)',
  `sal_emp` decimal(10,2) NOT NULL COMMENT 'Salario mensual del empleado en quetzales (sal = salario)',
  PRIMARY KEY (`id_emp`),
  KEY `id_alm` (`id_alm`),
  CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`id_alm`) REFERENCES `alm` (`id_alm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Empleados del área de almacén y compras (emp = empleado)';

CREATE TABLE `mov_inv` (
  `id_mov` int NOT NULL COMMENT 'Identificador del movimiento (mov = movimiento)',
  `id_art` int NOT NULL COMMENT 'Artículo movido',
  `id_alm` int NOT NULL COMMENT 'Almacén donde ocurre el movimiento',
  `tp_mov` enum('ENT','SAL','AJU') NOT NULL COMMENT 'Tipo de movimiento (tp = tipo): ENT = entrada, SAL = salida, AJU = ajuste',
  `cant` int NOT NULL COMMENT 'Cantidad movida (cant = cantidad); en ajustes puede ser negativa',
  `fec_mov` datetime NOT NULL COMMENT 'Fecha y hora del movimiento',
  `id_oc` int DEFAULT NULL COMMENT 'Orden de compra que originó la entrada; NULL si no aplica',
  `id_emp` int NOT NULL COMMENT 'Empleado que registró el movimiento',
  `ref_mov` varchar(100) DEFAULT NULL COMMENT 'Referencia o comentario del movimiento (ref = referencia)',
  PRIMARY KEY (`id_mov`),
  KEY `id_art` (`id_art`),
  KEY `id_alm` (`id_alm`),
  KEY `id_oc` (`id_oc`),
  KEY `id_emp` (`id_emp`),
  CONSTRAINT `mov_inv_ibfk_1` FOREIGN KEY (`id_art`) REFERENCES `art` (`id_art`),
  CONSTRAINT `mov_inv_ibfk_2` FOREIGN KEY (`id_alm`) REFERENCES `alm` (`id_alm`),
  CONSTRAINT `mov_inv_ibfk_3` FOREIGN KEY (`id_oc`) REFERENCES `oc` (`id_oc`),
  CONSTRAINT `mov_inv_ibfk_4` FOREIGN KEY (`id_emp`) REFERENCES `emp` (`id_emp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Movimientos de inventario (mov_inv = movimiento de inventario)';

CREATE TABLE `oc` (
  `id_oc` int NOT NULL COMMENT 'Identificador de la orden de compra (oc = orden de compra)',
  `num_oc` varchar(15) NOT NULL COMMENT 'Número correlativo visible de la orden de compra',
  `id_prov` int NOT NULL COMMENT 'Proveedor al que se le compra',
  `id_emp` int NOT NULL COMMENT 'Empleado que emitió la orden de compra',
  `id_alm` int NOT NULL COMMENT 'Almacén de destino de la mercadería',
  `fec_oc` date NOT NULL COMMENT 'Fecha de emisión de la orden de compra',
  `fec_ent_est` date NOT NULL COMMENT 'Fecha de entrega estimada (ent = entrega, est = estimada)',
  `fec_ent_real` date DEFAULT NULL COMMENT 'Fecha de entrega real; NULL si aún no se recibe',
  `est_oc` enum('PEND','APROB','RECIB','CANC') NOT NULL COMMENT 'Estado (est): PEND = pendiente, APROB = aprobada, RECIB = recibida, CANC = cancelada',
  `obs_oc` varchar(200) DEFAULT NULL COMMENT 'Observaciones de la orden de compra (obs = observaciones)',
  PRIMARY KEY (`id_oc`),
  KEY `id_prov` (`id_prov`),
  KEY `id_emp` (`id_emp`),
  KEY `id_alm` (`id_alm`),
  CONSTRAINT `oc_ibfk_1` FOREIGN KEY (`id_prov`) REFERENCES `prov` (`id_prov`),
  CONSTRAINT `oc_ibfk_2` FOREIGN KEY (`id_emp`) REFERENCES `emp` (`id_emp`),
  CONSTRAINT `oc_ibfk_3` FOREIGN KEY (`id_alm`) REFERENCES `alm` (`id_alm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Órdenes de compra a proveedores (oc = orden de compra)';

CREATE TABLE `oc_det` (
  `id_det` int NOT NULL COMMENT 'Identificador de la línea de detalle (det = detalle)',
  `id_oc` int NOT NULL COMMENT 'Orden de compra a la que pertenece la línea',
  `id_art` int NOT NULL COMMENT 'Artículo comprado',
  `cant` int NOT NULL COMMENT 'Cantidad pedida (cant = cantidad)',
  `pu` decimal(10,2) NOT NULL COMMENT 'Precio unitario pactado en la compra (pu = precio unitario)',
  `dsc_pct` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Porcentaje de descuento aplicado a la línea (dsc = descuento, pct = porcentaje)',
  PRIMARY KEY (`id_det`),
  KEY `id_oc` (`id_oc`),
  KEY `id_art` (`id_art`),
  CONSTRAINT `oc_det_ibfk_1` FOREIGN KEY (`id_oc`) REFERENCES `oc` (`id_oc`),
  CONSTRAINT `oc_det_ibfk_2` FOREIGN KEY (`id_art`) REFERENCES `art` (`id_art`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Detalle o líneas de las órdenes de compra (oc_det = detalle de orden de compra)';

CREATE TABLE `prov` (
  `id_prov` int NOT NULL COMMENT 'Identificador del proveedor (prov = proveedor)',
  `nom_prov` varchar(100) NOT NULL COMMENT 'Nombre o razón social del proveedor',
  `nit_prov` varchar(15) NOT NULL COMMENT 'NIT (número de identificación tributaria) del proveedor',
  `tel_prov` varchar(20) DEFAULT NULL COMMENT 'Teléfono del proveedor (tel = teléfono)',
  `eml_prov` varchar(100) DEFAULT NULL COMMENT 'Correo electrónico del proveedor (eml = email)',
  `ciu_prov` varchar(60) NOT NULL COMMENT 'Ciudad del proveedor (ciu = ciudad)',
  `fec_alta` date NOT NULL COMMENT 'Fecha de alta o registro del proveedor (fec = fecha)',
  `act` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Proveedor activo: 1 = sí, 0 = no (act = activo)',
  PRIMARY KEY (`id_prov`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Proveedores de mercadería (prov = proveedor)';

CREATE TABLE `stk` (
  `id_art` int NOT NULL COMMENT 'Artículo (referencia a art)',
  `id_alm` int NOT NULL COMMENT 'Almacén (referencia a alm)',
  `cant_act` int NOT NULL COMMENT 'Cantidad actual en existencia (cant = cantidad, act = actual)',
  `fec_ult_cnt` date DEFAULT NULL COMMENT 'Fecha del último conteo físico (ult = último, cnt = conteo); NULL si nunca se ha contado',
  PRIMARY KEY (`id_art`,`id_alm`),
  KEY `id_alm` (`id_alm`),
  CONSTRAINT `stk_ibfk_1` FOREIGN KEY (`id_art`) REFERENCES `art` (`id_art`),
  CONSTRAINT `stk_ibfk_2` FOREIGN KEY (`id_alm`) REFERENCES `alm` (`id_alm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Existencias actuales por artículo y almacén (stk = stock)';
