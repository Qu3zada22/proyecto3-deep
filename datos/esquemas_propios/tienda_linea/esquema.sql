CREATE TABLE clientes (
  cliente_id INT NOT NULL COMMENT 'Identificador único del cliente',
  nombre VARCHAR(60) NOT NULL COMMENT 'Nombre de pila del cliente',
  apellido VARCHAR(60) NOT NULL COMMENT 'Apellido del cliente',
  correo VARCHAR(100) NOT NULL COMMENT 'Correo electrónico del cliente',
  telefono VARCHAR(20) NULL COMMENT 'Teléfono de contacto (puede faltar)',
  ciudad VARCHAR(50) NOT NULL COMMENT 'Ciudad de residencia del cliente',
  pais VARCHAR(40) NOT NULL COMMENT 'País de residencia del cliente',
  fecha_registro DATE NOT NULL COMMENT 'Fecha en que el cliente creó su cuenta',
  es_premium TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1 si el cliente tiene membresía premium, 0 si no',
  PRIMARY KEY (cliente_id)
) COMMENT='Clientes registrados en la tienda en línea';

CREATE TABLE categorias (
  categoria_id INT NOT NULL COMMENT 'Identificador único de la categoría',
  nombre_categoria VARCHAR(60) NOT NULL COMMENT 'Nombre de la categoría de productos',
  descripcion VARCHAR(200) NULL COMMENT 'Descripción breve de la categoría',
  categoria_padre_id INT NULL COMMENT 'Categoría padre (NULL si es una categoría principal)',
  PRIMARY KEY (categoria_id),
  FOREIGN KEY (categoria_padre_id) REFERENCES categorias (categoria_id)
) COMMENT='Categorías y subcategorías del catálogo';

CREATE TABLE productos (
  producto_id INT NOT NULL COMMENT 'Identificador único del producto',
  nombre_producto VARCHAR(100) NOT NULL COMMENT 'Nombre comercial del producto',
  categoria_id INT NOT NULL COMMENT 'Categoría a la que pertenece el producto',
  marca VARCHAR(50) NULL COMMENT 'Marca del producto (NULL si es genérico)',
  precio DECIMAL(10,2) NOT NULL COMMENT 'Precio de venta actual en dólares',
  costo DECIMAL(10,2) NOT NULL COMMENT 'Costo de adquisición del producto en dólares',
  existencias INT NOT NULL COMMENT 'Unidades disponibles en inventario',
  fecha_alta DATE NOT NULL COMMENT 'Fecha en que el producto se agregó al catálogo',
  activo TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 si el producto está a la venta, 0 si fue descontinuado',
  PRIMARY KEY (producto_id),
  FOREIGN KEY (categoria_id) REFERENCES categorias (categoria_id)
) COMMENT='Productos del catálogo de la tienda';

CREATE TABLE pedidos (
  pedido_id INT NOT NULL COMMENT 'Identificador único del pedido',
  cliente_id INT NOT NULL COMMENT 'Cliente que realizó el pedido',
  fecha_pedido DATETIME NOT NULL COMMENT 'Fecha y hora en que se realizó el pedido',
  estado ENUM('pendiente','pagado','enviado','entregado','cancelado') NOT NULL COMMENT 'Estado actual del pedido',
  total DECIMAL(10,2) NOT NULL COMMENT 'Importe total del pedido en dólares (suma de sus líneas)',
  codigo_cupon VARCHAR(20) NULL COMMENT 'Código de cupón de descuento aplicado (NULL si no se usó)',
  PRIMARY KEY (pedido_id),
  FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id)
) COMMENT='Pedidos de compra realizados por los clientes';

CREATE TABLE detalle_pedido (
  detalle_id INT NOT NULL COMMENT 'Identificador único de la línea del pedido',
  pedido_id INT NOT NULL COMMENT 'Pedido al que pertenece la línea',
  producto_id INT NOT NULL COMMENT 'Producto comprado en esta línea',
  cantidad INT NOT NULL COMMENT 'Unidades compradas del producto',
  precio_unitario DECIMAL(10,2) NOT NULL COMMENT 'Precio por unidad al momento de la compra',
  descuento DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT 'Descuento total aplicado a la línea en dólares',
  PRIMARY KEY (detalle_id),
  FOREIGN KEY (pedido_id) REFERENCES pedidos (pedido_id),
  FOREIGN KEY (producto_id) REFERENCES productos (producto_id)
) COMMENT='Líneas de detalle (productos) de cada pedido';

CREATE TABLE pagos (
  pago_id INT NOT NULL COMMENT 'Identificador único del pago',
  pedido_id INT NOT NULL COMMENT 'Pedido que se paga',
  fecha_pago DATETIME NOT NULL COMMENT 'Fecha y hora del pago',
  monto DECIMAL(10,2) NOT NULL COMMENT 'Monto pagado en dólares',
  metodo_pago ENUM('tarjeta','transferencia','paypal','efectivo') NOT NULL COMMENT 'Medio de pago utilizado',
  aprobado TINYINT(1) NOT NULL COMMENT '1 si el pago fue aprobado, 0 si fue rechazado',
  PRIMARY KEY (pago_id),
  FOREIGN KEY (pedido_id) REFERENCES pedidos (pedido_id)
) COMMENT='Pagos (intentos aprobados o rechazados) asociados a pedidos';

CREATE TABLE envios (
  envio_id INT NOT NULL COMMENT 'Identificador único del envío',
  pedido_id INT NOT NULL COMMENT 'Pedido enviado',
  transportista VARCHAR(50) NOT NULL COMMENT 'Empresa de paquetería que realiza el envío',
  fecha_envio DATE NOT NULL COMMENT 'Fecha en que el paquete salió del almacén',
  fecha_entrega DATE NULL COMMENT 'Fecha en que se entregó (NULL si aún no se entrega)',
  costo_envio DECIMAL(10,2) NOT NULL COMMENT 'Costo del envío en dólares',
  ciudad_destino VARCHAR(50) NOT NULL COMMENT 'Ciudad a la que se envía el paquete',
  PRIMARY KEY (envio_id),
  FOREIGN KEY (pedido_id) REFERENCES pedidos (pedido_id)
) COMMENT='Envíos de los pedidos a los clientes';

CREATE TABLE resenas (
  resena_id INT NOT NULL COMMENT 'Identificador único de la reseña',
  producto_id INT NOT NULL COMMENT 'Producto reseñado',
  cliente_id INT NOT NULL COMMENT 'Cliente que escribió la reseña',
  calificacion TINYINT NOT NULL COMMENT 'Calificación de 1 a 5 estrellas',
  comentario VARCHAR(255) NULL COMMENT 'Texto de la reseña (NULL si solo dejó estrellas)',
  fecha_resena DATE NOT NULL COMMENT 'Fecha en que se publicó la reseña',
  PRIMARY KEY (resena_id),
  FOREIGN KEY (producto_id) REFERENCES productos (producto_id),
  FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id)
) COMMENT='Reseñas y calificaciones de productos escritas por clientes';
