CREATE TABLE `categorias` (
  `categoria_id` int NOT NULL COMMENT 'Identificador único de la categoría',
  `nombre_categoria` varchar(60) NOT NULL COMMENT 'Nombre de la categoría de productos',
  `descripcion` varchar(200) DEFAULT NULL COMMENT 'Descripción breve de la categoría',
  `categoria_padre_id` int DEFAULT NULL COMMENT 'Categoría padre (NULL si es una categoría principal)',
  PRIMARY KEY (`categoria_id`),
  KEY `categoria_padre_id` (`categoria_padre_id`),
  CONSTRAINT `categorias_ibfk_1` FOREIGN KEY (`categoria_padre_id`) REFERENCES `categorias` (`categoria_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Categorías y subcategorías del catálogo';

CREATE TABLE `clientes` (
  `cliente_id` int NOT NULL COMMENT 'Identificador único del cliente',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre de pila del cliente',
  `apellido` varchar(60) NOT NULL COMMENT 'Apellido del cliente',
  `correo` varchar(100) NOT NULL COMMENT 'Correo electrónico del cliente',
  `telefono` varchar(20) DEFAULT NULL COMMENT 'Teléfono de contacto (puede faltar)',
  `ciudad` varchar(50) NOT NULL COMMENT 'Ciudad de residencia del cliente',
  `pais` varchar(40) NOT NULL COMMENT 'País de residencia del cliente',
  `fecha_registro` date NOT NULL COMMENT 'Fecha en que el cliente creó su cuenta',
  `es_premium` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 si el cliente tiene membresía premium, 0 si no',
  PRIMARY KEY (`cliente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Clientes registrados en la tienda en línea';

CREATE TABLE `detalle_pedido` (
  `detalle_id` int NOT NULL COMMENT 'Identificador único de la línea del pedido',
  `pedido_id` int NOT NULL COMMENT 'Pedido al que pertenece la línea',
  `producto_id` int NOT NULL COMMENT 'Producto comprado en esta línea',
  `cantidad` int NOT NULL COMMENT 'Unidades compradas del producto',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio por unidad al momento de la compra',
  `descuento` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Descuento total aplicado a la línea en dólares',
  PRIMARY KEY (`detalle_id`),
  KEY `pedido_id` (`pedido_id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`pedido_id`),
  CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Líneas de detalle (productos) de cada pedido';

CREATE TABLE `envios` (
  `envio_id` int NOT NULL COMMENT 'Identificador único del envío',
  `pedido_id` int NOT NULL COMMENT 'Pedido enviado',
  `transportista` varchar(50) NOT NULL COMMENT 'Empresa de paquetería que realiza el envío',
  `fecha_envio` date NOT NULL COMMENT 'Fecha en que el paquete salió del almacén',
  `fecha_entrega` date DEFAULT NULL COMMENT 'Fecha en que se entregó (NULL si aún no se entrega)',
  `costo_envio` decimal(10,2) NOT NULL COMMENT 'Costo del envío en dólares',
  `ciudad_destino` varchar(50) NOT NULL COMMENT 'Ciudad a la que se envía el paquete',
  PRIMARY KEY (`envio_id`),
  KEY `pedido_id` (`pedido_id`),
  CONSTRAINT `envios_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`pedido_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Envíos de los pedidos a los clientes';

CREATE TABLE `pagos` (
  `pago_id` int NOT NULL COMMENT 'Identificador único del pago',
  `pedido_id` int NOT NULL COMMENT 'Pedido que se paga',
  `fecha_pago` datetime NOT NULL COMMENT 'Fecha y hora del pago',
  `monto` decimal(10,2) NOT NULL COMMENT 'Monto pagado en dólares',
  `metodo_pago` enum('tarjeta','transferencia','paypal','efectivo') NOT NULL COMMENT 'Medio de pago utilizado',
  `aprobado` tinyint(1) NOT NULL COMMENT '1 si el pago fue aprobado, 0 si fue rechazado',
  PRIMARY KEY (`pago_id`),
  KEY `pedido_id` (`pedido_id`),
  CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`pedido_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Pagos (intentos aprobados o rechazados) asociados a pedidos';

CREATE TABLE `pedidos` (
  `pedido_id` int NOT NULL COMMENT 'Identificador único del pedido',
  `cliente_id` int NOT NULL COMMENT 'Cliente que realizó el pedido',
  `fecha_pedido` datetime NOT NULL COMMENT 'Fecha y hora en que se realizó el pedido',
  `estado` enum('pendiente','pagado','enviado','entregado','cancelado') NOT NULL COMMENT 'Estado actual del pedido',
  `total` decimal(10,2) NOT NULL COMMENT 'Importe total del pedido en dólares (suma de sus líneas)',
  `codigo_cupon` varchar(20) DEFAULT NULL COMMENT 'Código de cupón de descuento aplicado (NULL si no se usó)',
  PRIMARY KEY (`pedido_id`),
  KEY `cliente_id` (`cliente_id`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Pedidos de compra realizados por los clientes';

CREATE TABLE `productos` (
  `producto_id` int NOT NULL COMMENT 'Identificador único del producto',
  `nombre_producto` varchar(100) NOT NULL COMMENT 'Nombre comercial del producto',
  `categoria_id` int NOT NULL COMMENT 'Categoría a la que pertenece el producto',
  `marca` varchar(50) DEFAULT NULL COMMENT 'Marca del producto (NULL si es genérico)',
  `precio` decimal(10,2) NOT NULL COMMENT 'Precio de venta actual en dólares',
  `costo` decimal(10,2) NOT NULL COMMENT 'Costo de adquisición del producto en dólares',
  `existencias` int NOT NULL COMMENT 'Unidades disponibles en inventario',
  `fecha_alta` date NOT NULL COMMENT 'Fecha en que el producto se agregó al catálogo',
  `activo` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 si el producto está a la venta, 0 si fue descontinuado',
  PRIMARY KEY (`producto_id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`categoria_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Productos del catálogo de la tienda';

CREATE TABLE `resenas` (
  `resena_id` int NOT NULL COMMENT 'Identificador único de la reseña',
  `producto_id` int NOT NULL COMMENT 'Producto reseñado',
  `cliente_id` int NOT NULL COMMENT 'Cliente que escribió la reseña',
  `calificacion` tinyint NOT NULL COMMENT 'Calificación de 1 a 5 estrellas',
  `comentario` varchar(255) DEFAULT NULL COMMENT 'Texto de la reseña (NULL si solo dejó estrellas)',
  `fecha_resena` date NOT NULL COMMENT 'Fecha en que se publicó la reseña',
  PRIMARY KEY (`resena_id`),
  KEY `producto_id` (`producto_id`),
  KEY `cliente_id` (`cliente_id`),
  CONSTRAINT `resenas_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`),
  CONSTRAINT `resenas_ibfk_2` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Reseñas y calificaciones de productos escritas por clientes';
