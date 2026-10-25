CREATE TABLE `categorias_menu` (
  `id_categoria` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la categoria',
  `nombre_categoria` varchar(60) NOT NULL COMMENT 'Nombre de la categoria del menu',
  `descripcion` varchar(200) DEFAULT NULL COMMENT 'Descripcion breve de la categoria',
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Categorias en que se agrupan los platillos del menu';

CREATE TABLE `detalle_orden` (
  `id_detalle` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del renglon de detalle',
  `id_orden` int NOT NULL COMMENT 'Orden a la que pertenece el renglon',
  `id_platillo` int NOT NULL COMMENT 'Platillo pedido',
  `cantidad` int NOT NULL COMMENT 'Numero de porciones pedidas',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio cobrado por porcion al momento de la orden',
  PRIMARY KEY (`id_detalle`),
  KEY `fk_detalle_orden` (`id_orden`),
  KEY `fk_detalle_platillo` (`id_platillo`),
  CONSTRAINT `fk_detalle_orden` FOREIGN KEY (`id_orden`) REFERENCES `ordenes` (`id_orden`),
  CONSTRAINT `fk_detalle_platillo` FOREIGN KEY (`id_platillo`) REFERENCES `platillos` (`id_platillo`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Platillos pedidos en cada orden';

CREATE TABLE `ingredientes` (
  `id_ingrediente` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del renglon de ingrediente',
  `id_platillo` int NOT NULL COMMENT 'Platillo cuya receta incluye este ingrediente',
  `nombre_ingrediente` varchar(80) NOT NULL COMMENT 'Nombre del ingrediente',
  `cantidad` decimal(10,2) NOT NULL COMMENT 'Cantidad usada por porcion, en la unidad de medida indicada',
  `unidad_medida` enum('g','ml','unidad') NOT NULL COMMENT 'Unidad de medida de la cantidad',
  `costo_unitario` decimal(10,2) NOT NULL COMMENT 'Costo en quetzales por unidad de medida (por gramo, mililitro o unidad)',
  `es_alergeno` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indica si el ingrediente es un alergeno comun: 1 si, 0 no',
  PRIMARY KEY (`id_ingrediente`),
  KEY `fk_ingredientes_platillo` (`id_platillo`),
  CONSTRAINT `fk_ingredientes_platillo` FOREIGN KEY (`id_platillo`) REFERENCES `platillos` (`id_platillo`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Ingredientes que componen la receta de cada platillo';

CREATE TABLE `mesas` (
  `id_mesa` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador unico de la mesa',
  `id_sucursal` int NOT NULL COMMENT 'Sucursal a la que pertenece la mesa',
  `numero_mesa` int NOT NULL COMMENT 'Numero visible de la mesa dentro de la sucursal',
  `capacidad` int NOT NULL COMMENT 'Cantidad maxima de personas que caben en la mesa',
  `ubicacion` enum('interior','terraza','barra') NOT NULL COMMENT 'Zona del restaurante donde esta la mesa',
  PRIMARY KEY (`id_mesa`),
  KEY `fk_mesas_sucursal` (`id_sucursal`),
  CONSTRAINT `fk_mesas_sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mesas disponibles en cada sucursal';

CREATE TABLE `meseros` (
  `id_mesero` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del mesero',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre del mesero',
  `apellido` varchar(60) NOT NULL COMMENT 'Apellido del mesero',
  `id_sucursal` int NOT NULL COMMENT 'Sucursal donde trabaja el mesero',
  `fecha_contratacion` date NOT NULL COMMENT 'Fecha de contratacion del mesero',
  `salario` decimal(10,2) NOT NULL COMMENT 'Salario mensual base en quetzales',
  `turno` enum('matutino','vespertino','nocturno') NOT NULL COMMENT 'Turno de trabajo asignado',
  `correo` varchar(100) DEFAULT NULL COMMENT 'Correo electronico del mesero; puede ser nulo',
  PRIMARY KEY (`id_mesero`),
  KEY `fk_meseros_sucursal` (`id_sucursal`),
  CONSTRAINT `fk_meseros_sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Meseros que atienden las mesas';

CREATE TABLE `ordenes` (
  `id_orden` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la orden',
  `id_mesa` int NOT NULL COMMENT 'Mesa donde se tomo la orden',
  `id_mesero` int NOT NULL COMMENT 'Mesero que atendio la orden',
  `fecha_hora` datetime NOT NULL COMMENT 'Fecha y hora en que se abrio la orden',
  `estado` enum('abierta','pagada','cancelada') NOT NULL COMMENT 'Estado actual de la orden',
  `metodo_pago` enum('efectivo','tarjeta','transferencia') DEFAULT NULL COMMENT 'Forma de pago; nulo si la orden no se ha pagado',
  `propina` decimal(10,2) DEFAULT NULL COMMENT 'Propina dejada en quetzales; nula si no hubo',
  PRIMARY KEY (`id_orden`),
  KEY `fk_ordenes_mesa` (`id_mesa`),
  KEY `fk_ordenes_mesero` (`id_mesero`),
  CONSTRAINT `fk_ordenes_mesa` FOREIGN KEY (`id_mesa`) REFERENCES `mesas` (`id_mesa`),
  CONSTRAINT `fk_ordenes_mesero` FOREIGN KEY (`id_mesero`) REFERENCES `meseros` (`id_mesero`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Ordenes (cuentas) tomadas en las mesas';

CREATE TABLE `platillos` (
  `id_platillo` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del platillo',
  `nombre_platillo` varchar(100) NOT NULL COMMENT 'Nombre del platillo como aparece en el menu',
  `id_categoria` int NOT NULL COMMENT 'Categoria del menu a la que pertenece',
  `precio` decimal(10,2) NOT NULL COMMENT 'Precio de venta vigente en quetzales',
  `es_vegetariano` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indica si el platillo es vegetariano: 1 si, 0 no',
  `disponible` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indica si el platillo esta disponible en el menu actual',
  `calorias` int DEFAULT NULL COMMENT 'Calorias aproximadas por porcion; puede ser nulo',
  PRIMARY KEY (`id_platillo`),
  KEY `fk_platillos_categoria` (`id_categoria`),
  CONSTRAINT `fk_platillos_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias_menu` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Platillos y bebidas que ofrece el menu';

CREATE TABLE `reservaciones` (
  `id_reservacion` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la reservacion',
  `id_mesa` int NOT NULL COMMENT 'Mesa reservada',
  `nombre_cliente` varchar(100) NOT NULL COMMENT 'Nombre de la persona que reserva',
  `telefono_cliente` varchar(20) DEFAULT NULL COMMENT 'Telefono de contacto del cliente; puede ser nulo',
  `fecha_hora` datetime NOT NULL COMMENT 'Fecha y hora para la que se reservo',
  `numero_personas` int NOT NULL COMMENT 'Cantidad de comensales de la reservacion',
  `estado` enum('confirmada','completada','cancelada','no_asistio') NOT NULL COMMENT 'Estado de la reservacion',
  `fecha_registro` datetime NOT NULL COMMENT 'Momento en que se hizo la reservacion',
  PRIMARY KEY (`id_reservacion`),
  KEY `fk_reservaciones_mesa` (`id_mesa`),
  CONSTRAINT `fk_reservaciones_mesa` FOREIGN KEY (`id_mesa`) REFERENCES `mesas` (`id_mesa`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Reservaciones de mesas hechas por los clientes';

CREATE TABLE `sucursales` (
  `id_sucursal` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la sucursal',
  `nombre_sucursal` varchar(80) NOT NULL COMMENT 'Nombre comercial de la sucursal',
  `ciudad` varchar(60) NOT NULL COMMENT 'Ciudad donde se ubica la sucursal',
  `direccion` varchar(150) NOT NULL COMMENT 'Direccion fisica de la sucursal',
  `fecha_apertura` date NOT NULL COMMENT 'Fecha en que abrio la sucursal',
  `capacidad_personas` int NOT NULL COMMENT 'Aforo maximo de comensales',
  `activa` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indica si la sucursal sigue operando: 1 si, 0 no',
  PRIMARY KEY (`id_sucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Sucursales de la cadena de restaurantes';
