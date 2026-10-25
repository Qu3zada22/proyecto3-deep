CREATE TABLE `consumos` (
  `id_consumo` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del consumo',
  `id_reserva` int NOT NULL COMMENT 'Reserva a la que se carga el consumo',
  `id_servicio` int NOT NULL COMMENT 'Servicio consumido',
  `fecha_consumo` datetime NOT NULL COMMENT 'Fecha y hora del consumo',
  `cantidad` int NOT NULL COMMENT 'Unidades consumidas del servicio',
  `monto` decimal(10,2) NOT NULL COMMENT 'Importe total del consumo (cantidad por precio unitario)',
  PRIMARY KEY (`id_consumo`),
  KEY `id_reserva` (`id_reserva`),
  KEY `id_servicio` (`id_servicio`),
  CONSTRAINT `consumos_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`),
  CONSTRAINT `consumos_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Servicios consumidos por los huéspedes y cargados a su reserva';

CREATE TABLE `empleados` (
  `id_empleado` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del empleado',
  `id_hotel` int NOT NULL COMMENT 'Hotel donde trabaja el empleado',
  `nombre_completo` varchar(120) NOT NULL COMMENT 'Nombre y apellido del empleado',
  `puesto` enum('gerente','recepcionista','camarista','chef','mesero','mantenimiento','concierge') NOT NULL COMMENT 'Puesto que ocupa el empleado',
  `salario_mensual` decimal(10,2) NOT NULL COMMENT 'Salario mensual en dólares',
  `fecha_contratacion` date NOT NULL COMMENT 'Fecha de contratación del empleado',
  `id_supervisor` int DEFAULT NULL COMMENT 'Empleado que supervisa a este empleado; NULL si no tiene supervisor',
  PRIMARY KEY (`id_empleado`),
  KEY `id_hotel` (`id_hotel`),
  KEY `id_supervisor` (`id_supervisor`),
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`id_hotel`) REFERENCES `hoteles` (`id_hotel`),
  CONSTRAINT `empleados_ibfk_2` FOREIGN KEY (`id_supervisor`) REFERENCES `empleados` (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Personal que trabaja en los hoteles de la cadena';

CREATE TABLE `facturas` (
  `id_factura` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la factura',
  `id_reserva` int NOT NULL COMMENT 'Reserva facturada',
  `fecha_emision` date NOT NULL COMMENT 'Fecha de emisión de la factura',
  `subtotal` decimal(10,2) NOT NULL COMMENT 'Importe antes de impuestos (hospedaje más consumos)',
  `impuesto` decimal(10,2) NOT NULL COMMENT 'Impuesto aplicado (12% del subtotal)',
  `total` decimal(10,2) NOT NULL COMMENT 'Importe total a pagar (subtotal más impuesto)',
  `metodo_pago` enum('efectivo','tarjeta','transferencia') DEFAULT NULL COMMENT 'Método de pago; NULL si aún no se ha pagado',
  `pagada` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indica si la factura ya fue pagada (1 = sí, 0 = no)',
  PRIMARY KEY (`id_factura`),
  KEY `id_reserva` (`id_reserva`),
  CONSTRAINT `facturas_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Facturas emitidas al cierre de las estancias';

CREATE TABLE `habitaciones` (
  `id_habitacion` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la habitación',
  `id_hotel` int NOT NULL COMMENT 'Hotel al que pertenece la habitación',
  `id_tipo` int NOT NULL COMMENT 'Tipo de habitación',
  `numero` varchar(10) NOT NULL COMMENT 'Número de habitación visible para el huésped',
  `piso` tinyint NOT NULL COMMENT 'Piso en el que se encuentra la habitación',
  `estado` enum('disponible','mantenimiento','fuera_servicio') NOT NULL DEFAULT 'disponible' COMMENT 'Estado operativo actual de la habitación',
  PRIMARY KEY (`id_habitacion`),
  KEY `id_hotel` (`id_hotel`),
  KEY `id_tipo` (`id_tipo`),
  CONSTRAINT `habitaciones_ibfk_1` FOREIGN KEY (`id_hotel`) REFERENCES `hoteles` (`id_hotel`),
  CONSTRAINT `habitaciones_ibfk_2` FOREIGN KEY (`id_tipo`) REFERENCES `tipos_habitacion` (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Habitaciones físicas de cada hotel';

CREATE TABLE `hoteles` (
  `id_hotel` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del hotel',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre comercial del hotel',
  `ciudad` varchar(60) NOT NULL COMMENT 'Ciudad donde se ubica el hotel',
  `pais` varchar(60) NOT NULL COMMENT 'País donde se ubica el hotel',
  `estrellas` tinyint NOT NULL COMMENT 'Categoría del hotel en estrellas (1 a 5)',
  `fecha_apertura` date NOT NULL COMMENT 'Fecha en que el hotel abrió sus puertas',
  `telefono` varchar(20) DEFAULT NULL COMMENT 'Teléfono de recepción; NULL si no está registrado',
  PRIMARY KEY (`id_hotel`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Hoteles que forman parte de la cadena hotelera';

CREATE TABLE `huespedes` (
  `id_huesped` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del huésped',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre del huésped',
  `apellido` varchar(60) NOT NULL COMMENT 'Apellido del huésped',
  `correo` varchar(120) DEFAULT NULL COMMENT 'Correo electrónico del huésped; NULL si no lo proporcionó',
  `pais_origen` varchar(60) NOT NULL COMMENT 'País de residencia del huésped',
  `fecha_nacimiento` date DEFAULT NULL COMMENT 'Fecha de nacimiento del huésped',
  `es_vip` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indica si el huésped pertenece al programa VIP (1 = sí, 0 = no)',
  `fecha_registro` date NOT NULL COMMENT 'Fecha en que el huésped se registró en el sistema',
  PRIMARY KEY (`id_huesped`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Huéspedes registrados en la cadena hotelera';

CREATE TABLE `reservas` (
  `id_reserva` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la reserva',
  `id_huesped` int NOT NULL COMMENT 'Huésped titular de la reserva',
  `id_habitacion` int NOT NULL COMMENT 'Habitación reservada',
  `fecha_reserva` datetime NOT NULL COMMENT 'Fecha y hora en que se hizo la reserva',
  `fecha_entrada` date NOT NULL COMMENT 'Fecha de llegada (check-in)',
  `fecha_salida` date NOT NULL COMMENT 'Fecha de salida (check-out)',
  `num_personas` tinyint NOT NULL COMMENT 'Número de personas que se hospedan',
  `tarifa_noche` decimal(10,2) NOT NULL COMMENT 'Tarifa acordada por noche en dólares',
  `canal` enum('web','telefono','agencia','mostrador') NOT NULL COMMENT 'Canal por el que se realizó la reserva',
  `estado` enum('confirmada','completada','cancelada','no_show') NOT NULL COMMENT 'Estado de la reserva',
  PRIMARY KEY (`id_reserva`),
  KEY `id_huesped` (`id_huesped`),
  KEY `id_habitacion` (`id_habitacion`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_huesped`) REFERENCES `huespedes` (`id_huesped`),
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id_habitacion`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Reservas de habitaciones hechas por los huéspedes';

CREATE TABLE `servicios` (
  `id_servicio` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del servicio',
  `nombre_servicio` varchar(80) NOT NULL COMMENT 'Nombre del servicio adicional',
  `categoria` enum('restaurante','spa','lavanderia','minibar','transporte') NOT NULL COMMENT 'Categoría del servicio',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio por unidad del servicio en dólares',
  PRIMARY KEY (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Catálogo de servicios adicionales que se cobran durante la estancia';

CREATE TABLE `tipos_habitacion` (
  `id_tipo` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del tipo de habitación',
  `nombre_tipo` varchar(50) NOT NULL COMMENT 'Nombre del tipo de habitación (Sencilla, Doble, Suite, etc.)',
  `capacidad` tinyint NOT NULL COMMENT 'Número máximo de personas que admite la habitación',
  `precio_base` decimal(10,2) NOT NULL COMMENT 'Precio base por noche en dólares',
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Catálogo de tipos de habitación con su capacidad y precio base por noche';
