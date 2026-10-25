-- Esquema restaurante: cadena de restaurantes (nombres en espanol completos)
CREATE TABLE sucursales (
  id_sucursal INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la sucursal',
  nombre_sucursal VARCHAR(80) NOT NULL COMMENT 'Nombre comercial de la sucursal',
  ciudad VARCHAR(60) NOT NULL COMMENT 'Ciudad donde se ubica la sucursal',
  direccion VARCHAR(150) NOT NULL COMMENT 'Direccion fisica de la sucursal',
  fecha_apertura DATE NOT NULL COMMENT 'Fecha en que abrio la sucursal',
  capacidad_personas INT NOT NULL COMMENT 'Aforo maximo de comensales',
  activa TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Indica si la sucursal sigue operando: 1 si, 0 no',
  PRIMARY KEY (id_sucursal)
) COMMENT='Sucursales de la cadena de restaurantes';

CREATE TABLE meseros (
  id_mesero INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del mesero',
  nombre VARCHAR(60) NOT NULL COMMENT 'Nombre del mesero',
  apellido VARCHAR(60) NOT NULL COMMENT 'Apellido del mesero',
  id_sucursal INT NOT NULL COMMENT 'Sucursal donde trabaja el mesero',
  fecha_contratacion DATE NOT NULL COMMENT 'Fecha de contratacion del mesero',
  salario DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual base en quetzales',
  turno ENUM('matutino','vespertino','nocturno') NOT NULL COMMENT 'Turno de trabajo asignado',
  correo VARCHAR(100) NULL COMMENT 'Correo electronico del mesero; puede ser nulo',
  PRIMARY KEY (id_mesero),
  CONSTRAINT fk_meseros_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursales (id_sucursal)
) COMMENT='Meseros que atienden las mesas';

CREATE TABLE mesas (
  id_mesa INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador unico de la mesa',
  id_sucursal INT NOT NULL COMMENT 'Sucursal a la que pertenece la mesa',
  numero_mesa INT NOT NULL COMMENT 'Numero visible de la mesa dentro de la sucursal',
  capacidad INT NOT NULL COMMENT 'Cantidad maxima de personas que caben en la mesa',
  ubicacion ENUM('interior','terraza','barra') NOT NULL COMMENT 'Zona del restaurante donde esta la mesa',
  PRIMARY KEY (id_mesa),
  CONSTRAINT fk_mesas_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursales (id_sucursal)
) COMMENT='Mesas disponibles en cada sucursal';

CREATE TABLE categorias_menu (
  id_categoria INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la categoria',
  nombre_categoria VARCHAR(60) NOT NULL COMMENT 'Nombre de la categoria del menu',
  descripcion VARCHAR(200) NULL COMMENT 'Descripcion breve de la categoria',
  PRIMARY KEY (id_categoria)
) COMMENT='Categorias en que se agrupan los platillos del menu';

CREATE TABLE platillos (
  id_platillo INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del platillo',
  nombre_platillo VARCHAR(100) NOT NULL COMMENT 'Nombre del platillo como aparece en el menu',
  id_categoria INT NOT NULL COMMENT 'Categoria del menu a la que pertenece',
  precio DECIMAL(10,2) NOT NULL COMMENT 'Precio de venta vigente en quetzales',
  es_vegetariano TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica si el platillo es vegetariano: 1 si, 0 no',
  disponible TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Indica si el platillo esta disponible en el menu actual',
  calorias INT NULL COMMENT 'Calorias aproximadas por porcion; puede ser nulo',
  PRIMARY KEY (id_platillo),
  CONSTRAINT fk_platillos_categoria FOREIGN KEY (id_categoria) REFERENCES categorias_menu (id_categoria)
) COMMENT='Platillos y bebidas que ofrece el menu';

CREATE TABLE ingredientes (
  id_ingrediente INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del renglon de ingrediente',
  id_platillo INT NOT NULL COMMENT 'Platillo cuya receta incluye este ingrediente',
  nombre_ingrediente VARCHAR(80) NOT NULL COMMENT 'Nombre del ingrediente',
  cantidad DECIMAL(10,2) NOT NULL COMMENT 'Cantidad usada por porcion, en la unidad de medida indicada',
  unidad_medida ENUM('g','ml','unidad') NOT NULL COMMENT 'Unidad de medida de la cantidad',
  costo_unitario DECIMAL(10,2) NOT NULL COMMENT 'Costo en quetzales por unidad de medida (por gramo, mililitro o unidad)',
  es_alergeno TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica si el ingrediente es un alergeno comun: 1 si, 0 no',
  PRIMARY KEY (id_ingrediente),
  CONSTRAINT fk_ingredientes_platillo FOREIGN KEY (id_platillo) REFERENCES platillos (id_platillo)
) COMMENT='Ingredientes que componen la receta de cada platillo';

CREATE TABLE reservaciones (
  id_reservacion INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la reservacion',
  id_mesa INT NOT NULL COMMENT 'Mesa reservada',
  nombre_cliente VARCHAR(100) NOT NULL COMMENT 'Nombre de la persona que reserva',
  telefono_cliente VARCHAR(20) NULL COMMENT 'Telefono de contacto del cliente; puede ser nulo',
  fecha_hora DATETIME NOT NULL COMMENT 'Fecha y hora para la que se reservo',
  numero_personas INT NOT NULL COMMENT 'Cantidad de comensales de la reservacion',
  estado ENUM('confirmada','completada','cancelada','no_asistio') NOT NULL COMMENT 'Estado de la reservacion',
  fecha_registro DATETIME NOT NULL COMMENT 'Momento en que se hizo la reservacion',
  PRIMARY KEY (id_reservacion),
  CONSTRAINT fk_reservaciones_mesa FOREIGN KEY (id_mesa) REFERENCES mesas (id_mesa)
) COMMENT='Reservaciones de mesas hechas por los clientes';

CREATE TABLE ordenes (
  id_orden INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la orden',
  id_mesa INT NOT NULL COMMENT 'Mesa donde se tomo la orden',
  id_mesero INT NOT NULL COMMENT 'Mesero que atendio la orden',
  fecha_hora DATETIME NOT NULL COMMENT 'Fecha y hora en que se abrio la orden',
  estado ENUM('abierta','pagada','cancelada') NOT NULL COMMENT 'Estado actual de la orden',
  metodo_pago ENUM('efectivo','tarjeta','transferencia') NULL COMMENT 'Forma de pago; nulo si la orden no se ha pagado',
  propina DECIMAL(10,2) NULL COMMENT 'Propina dejada en quetzales; nula si no hubo',
  PRIMARY KEY (id_orden),
  CONSTRAINT fk_ordenes_mesa FOREIGN KEY (id_mesa) REFERENCES mesas (id_mesa),
  CONSTRAINT fk_ordenes_mesero FOREIGN KEY (id_mesero) REFERENCES meseros (id_mesero)
) COMMENT='Ordenes (cuentas) tomadas en las mesas';

CREATE TABLE detalle_orden (
  id_detalle INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del renglon de detalle',
  id_orden INT NOT NULL COMMENT 'Orden a la que pertenece el renglon',
  id_platillo INT NOT NULL COMMENT 'Platillo pedido',
  cantidad INT NOT NULL COMMENT 'Numero de porciones pedidas',
  precio_unitario DECIMAL(10,2) NOT NULL COMMENT 'Precio cobrado por porcion al momento de la orden',
  PRIMARY KEY (id_detalle),
  CONSTRAINT fk_detalle_orden FOREIGN KEY (id_orden) REFERENCES ordenes (id_orden),
  CONSTRAINT fk_detalle_platillo FOREIGN KEY (id_platillo) REFERENCES platillos (id_platillo)
) COMMENT='Platillos pedidos en cada orden';
