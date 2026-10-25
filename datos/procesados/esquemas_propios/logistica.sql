CREATE TABLE `cli` (
  `cli_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del cliente',
  `nom_cli` varchar(100) NOT NULL COMMENT 'Nombre o razon social del cliente (nom = nombre, cli = cliente)',
  `tipo_cli` enum('persona','empresa') NOT NULL COMMENT 'Tipo de cliente: persona individual o empresa',
  `ciudad` varchar(60) NOT NULL COMMENT 'Ciudad del cliente',
  `email` varchar(100) DEFAULT NULL COMMENT 'Correo electronico del cliente; puede ser nulo',
  `fec_reg` date NOT NULL COMMENT 'Fecha de registro del cliente (fec = fecha, reg = registro)',
  PRIMARY KEY (`cli_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Clientes (cli) que contratan entregas';

CREATE TABLE `cond` (
  `cond_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del conductor',
  `nom_cond` varchar(60) NOT NULL COMMENT 'Nombre del conductor',
  `ape_cond` varchar(60) NOT NULL COMMENT 'Apellido del conductor (ape = apellido)',
  `lic_tipo` enum('A','B','C') NOT NULL COMMENT 'Tipo de licencia de conducir (lic = licencia): A liviana, B mediana, C pesada',
  `fec_ing` date NOT NULL COMMENT 'Fecha de ingreso a la empresa (fec = fecha, ing = ingreso)',
  `sal_men` decimal(10,2) NOT NULL COMMENT 'Salario mensual en quetzales (sal = salario, men = mensual)',
  `tel` varchar(20) DEFAULT NULL COMMENT 'Telefono de contacto (tel = telefono); puede ser nulo',
  `suc_id` int NOT NULL COMMENT 'Sucursal a la que esta asignado el conductor (FK a suc)',
  `act` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indica si el conductor esta activo (act = activo): 1 si, 0 no',
  PRIMARY KEY (`cond_id`),
  KEY `fk_cond_suc` (`suc_id`),
  CONSTRAINT `fk_cond_suc` FOREIGN KEY (`suc_id`) REFERENCES `suc` (`suc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Conductores (cond) de la flota';

CREATE TABLE `ent` (
  `ent_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la entrega (ent = entrega)',
  `vje_id` int NOT NULL COMMENT 'Viaje en el que se transporta la entrega (FK a vje)',
  `cli_id` int NOT NULL COMMENT 'Cliente destinatario o que paga la entrega (FK a cli)',
  `fec_prom` date NOT NULL COMMENT 'Fecha prometida de entrega (fec = fecha, prom = prometida)',
  `fec_ent` date DEFAULT NULL COMMENT 'Fecha real de entrega (ent = entrega); nula si aun no se entrega',
  `peso_kg` decimal(10,2) NOT NULL COMMENT 'Peso del paquete en kilogramos',
  `monto` decimal(10,2) NOT NULL COMMENT 'Monto cobrado por la entrega en quetzales',
  `est_ent` enum('pendiente','en_transito','entregada','devuelta','cancelada') NOT NULL COMMENT 'Estado de la entrega (est = estado, ent = entrega)',
  PRIMARY KEY (`ent_id`),
  KEY `fk_ent_vje` (`vje_id`),
  KEY `fk_ent_cli` (`cli_id`),
  CONSTRAINT `fk_ent_cli` FOREIGN KEY (`cli_id`) REFERENCES `cli` (`cli_id`),
  CONSTRAINT `fk_ent_vje` FOREIGN KEY (`vje_id`) REFERENCES `vje` (`vje_id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Entregas (ent) o paquetes transportados para los clientes';

CREATE TABLE `mant` (
  `mant_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del mantenimiento (mant = mantenimiento)',
  `veh_id` int NOT NULL COMMENT 'Vehiculo atendido (FK a veh)',
  `fec_mant` date NOT NULL COMMENT 'Fecha del mantenimiento (fec = fecha)',
  `tipo_mant` enum('preventivo','correctivo','llantas','frenos') NOT NULL COMMENT 'Tipo de mantenimiento realizado',
  `costo` decimal(10,2) NOT NULL COMMENT 'Costo del mantenimiento en quetzales',
  `km_mant` int NOT NULL COMMENT 'Kilometraje del vehiculo al momento del mantenimiento',
  `taller` varchar(80) NOT NULL COMMENT 'Nombre del taller que hizo el servicio',
  `obs` varchar(200) DEFAULT NULL COMMENT 'Observaciones del servicio (obs = observaciones); puede ser nulo',
  PRIMARY KEY (`mant_id`),
  KEY `fk_mant_veh` (`veh_id`),
  CONSTRAINT `fk_mant_veh` FOREIGN KEY (`veh_id`) REFERENCES `veh` (`veh_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mantenimientos (mant) aplicados a los vehiculos';

CREATE TABLE `rta` (
  `rta_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la ruta',
  `cod_rta` varchar(10) NOT NULL COMMENT 'Codigo corto de la ruta (cod = codigo, rta = ruta)',
  `orig` varchar(60) NOT NULL COMMENT 'Ciudad de origen de la ruta (orig = origen)',
  `dest` varchar(60) NOT NULL COMMENT 'Ciudad de destino de la ruta (dest = destino)',
  `dist_km` decimal(10,2) NOT NULL COMMENT 'Distancia de la ruta en kilometros (dist = distancia)',
  `tpo_est_min` int NOT NULL COMMENT 'Tiempo estimado del recorrido en minutos (tpo = tiempo, est = estimado, min = minutos)',
  PRIMARY KEY (`rta_id`),
  UNIQUE KEY `uq_rta_cod` (`cod_rta`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Rutas (rta) predefinidas entre ciudades';

CREATE TABLE `suc` (
  `suc_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la sucursal o centro de distribucion',
  `nom_suc` varchar(80) NOT NULL COMMENT 'Nombre de la sucursal (nom = nombre)',
  `ciudad` varchar(60) NOT NULL COMMENT 'Ciudad donde opera la sucursal',
  `cap_veh` int NOT NULL COMMENT 'Capacidad maxima de vehiculos en el patio (cap = capacidad, veh = vehiculos)',
  `fec_aper` date NOT NULL COMMENT 'Fecha de apertura de la sucursal (fec = fecha, aper = apertura)',
  PRIMARY KEY (`suc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Sucursales (suc) o centros de distribucion de la empresa';

CREATE TABLE `veh` (
  `veh_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del vehiculo',
  `placa` varchar(10) NOT NULL COMMENT 'Numero de placa del vehiculo',
  `marca` varchar(40) NOT NULL COMMENT 'Marca del vehiculo',
  `modelo` varchar(40) NOT NULL COMMENT 'Modelo del vehiculo',
  `anio` int NOT NULL COMMENT 'Anio de fabricacion del vehiculo',
  `tipo_veh` enum('moto','camioneta','furgon','camion') NOT NULL COMMENT 'Tipo de vehiculo (veh = vehiculo)',
  `cap_kg` decimal(10,2) NOT NULL COMMENT 'Capacidad de carga en kilogramos (cap = capacidad)',
  `km_act` int NOT NULL COMMENT 'Kilometraje actual del odometro (km = kilometros, act = actual)',
  `suc_id` int NOT NULL COMMENT 'Sucursal a la que pertenece el vehiculo (FK a suc)',
  PRIMARY KEY (`veh_id`),
  UNIQUE KEY `uq_veh_placa` (`placa`),
  KEY `fk_veh_suc` (`suc_id`),
  CONSTRAINT `fk_veh_suc` FOREIGN KEY (`suc_id`) REFERENCES `suc` (`suc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Vehiculos (veh) de la flota';

CREATE TABLE `vje` (
  `vje_id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del viaje (vje = viaje)',
  `veh_id` int NOT NULL COMMENT 'Vehiculo usado en el viaje (FK a veh)',
  `cond_id` int NOT NULL COMMENT 'Conductor que realizo el viaje (FK a cond)',
  `rta_id` int NOT NULL COMMENT 'Ruta recorrida (FK a rta)',
  `fec_sal` datetime NOT NULL COMMENT 'Fecha y hora de salida (fec = fecha, sal = salida)',
  `fec_lleg` datetime DEFAULT NULL COMMENT 'Fecha y hora de llegada (lleg = llegada); nula si el viaje sigue en curso',
  `km_rec` decimal(10,2) DEFAULT NULL COMMENT 'Kilometros recorridos realmente (km = kilometros, rec = recorridos); nulo si no ha terminado',
  `cost_comb` decimal(10,2) DEFAULT NULL COMMENT 'Costo de combustible del viaje en quetzales (cost = costo, comb = combustible)',
  PRIMARY KEY (`vje_id`),
  KEY `fk_vje_veh` (`veh_id`),
  KEY `fk_vje_cond` (`cond_id`),
  KEY `fk_vje_rta` (`rta_id`),
  CONSTRAINT `fk_vje_cond` FOREIGN KEY (`cond_id`) REFERENCES `cond` (`cond_id`),
  CONSTRAINT `fk_vje_rta` FOREIGN KEY (`rta_id`) REFERENCES `rta` (`rta_id`),
  CONSTRAINT `fk_vje_veh` FOREIGN KEY (`veh_id`) REFERENCES `veh` (`veh_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Viajes (vje) realizados por un vehiculo y un conductor sobre una ruta';
