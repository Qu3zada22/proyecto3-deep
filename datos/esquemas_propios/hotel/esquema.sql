CREATE TABLE hoteles (
  id_hotel INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del hotel',
  nombre VARCHAR(100) NOT NULL COMMENT 'Nombre comercial del hotel',
  ciudad VARCHAR(60) NOT NULL COMMENT 'Ciudad donde se ubica el hotel',
  pais VARCHAR(60) NOT NULL COMMENT 'País donde se ubica el hotel',
  estrellas TINYINT NOT NULL COMMENT 'Categoría del hotel en estrellas (1 a 5)',
  fecha_apertura DATE NOT NULL COMMENT 'Fecha en que el hotel abrió sus puertas',
  telefono VARCHAR(20) NULL COMMENT 'Teléfono de recepción; NULL si no está registrado',
  PRIMARY KEY (id_hotel)
) COMMENT='Hoteles que forman parte de la cadena hotelera';

CREATE TABLE tipos_habitacion (
  id_tipo INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del tipo de habitación',
  nombre_tipo VARCHAR(50) NOT NULL COMMENT 'Nombre del tipo de habitación (Sencilla, Doble, Suite, etc.)',
  capacidad TINYINT NOT NULL COMMENT 'Número máximo de personas que admite la habitación',
  precio_base DECIMAL(10,2) NOT NULL COMMENT 'Precio base por noche en dólares',
  PRIMARY KEY (id_tipo)
) COMMENT='Catálogo de tipos de habitación con su capacidad y precio base por noche';

CREATE TABLE habitaciones (
  id_habitacion INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la habitación',
  id_hotel INT NOT NULL COMMENT 'Hotel al que pertenece la habitación',
  id_tipo INT NOT NULL COMMENT 'Tipo de habitación',
  numero VARCHAR(10) NOT NULL COMMENT 'Número de habitación visible para el huésped',
  piso TINYINT NOT NULL COMMENT 'Piso en el que se encuentra la habitación',
  estado ENUM('disponible','mantenimiento','fuera_servicio') NOT NULL DEFAULT 'disponible' COMMENT 'Estado operativo actual de la habitación',
  PRIMARY KEY (id_habitacion),
  FOREIGN KEY (id_hotel) REFERENCES hoteles(id_hotel),
  FOREIGN KEY (id_tipo) REFERENCES tipos_habitacion(id_tipo)
) COMMENT='Habitaciones físicas de cada hotel';

CREATE TABLE huespedes (
  id_huesped INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del huésped',
  nombre VARCHAR(60) NOT NULL COMMENT 'Nombre del huésped',
  apellido VARCHAR(60) NOT NULL COMMENT 'Apellido del huésped',
  correo VARCHAR(120) NULL COMMENT 'Correo electrónico del huésped; NULL si no lo proporcionó',
  pais_origen VARCHAR(60) NOT NULL COMMENT 'País de residencia del huésped',
  fecha_nacimiento DATE NULL COMMENT 'Fecha de nacimiento del huésped',
  es_vip TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica si el huésped pertenece al programa VIP (1 = sí, 0 = no)',
  fecha_registro DATE NOT NULL COMMENT 'Fecha en que el huésped se registró en el sistema',
  PRIMARY KEY (id_huesped)
) COMMENT='Huéspedes registrados en la cadena hotelera';

CREATE TABLE empleados (
  id_empleado INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del empleado',
  id_hotel INT NOT NULL COMMENT 'Hotel donde trabaja el empleado',
  nombre_completo VARCHAR(120) NOT NULL COMMENT 'Nombre y apellido del empleado',
  puesto ENUM('gerente','recepcionista','camarista','chef','mesero','mantenimiento','concierge') NOT NULL COMMENT 'Puesto que ocupa el empleado',
  salario_mensual DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual en dólares',
  fecha_contratacion DATE NOT NULL COMMENT 'Fecha de contratación del empleado',
  id_supervisor INT NULL COMMENT 'Empleado que supervisa a este empleado; NULL si no tiene supervisor',
  PRIMARY KEY (id_empleado),
  FOREIGN KEY (id_hotel) REFERENCES hoteles(id_hotel),
  FOREIGN KEY (id_supervisor) REFERENCES empleados(id_empleado)
) COMMENT='Personal que trabaja en los hoteles de la cadena';

CREATE TABLE reservas (
  id_reserva INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la reserva',
  id_huesped INT NOT NULL COMMENT 'Huésped titular de la reserva',
  id_habitacion INT NOT NULL COMMENT 'Habitación reservada',
  fecha_reserva DATETIME NOT NULL COMMENT 'Fecha y hora en que se hizo la reserva',
  fecha_entrada DATE NOT NULL COMMENT 'Fecha de llegada (check-in)',
  fecha_salida DATE NOT NULL COMMENT 'Fecha de salida (check-out)',
  num_personas TINYINT NOT NULL COMMENT 'Número de personas que se hospedan',
  tarifa_noche DECIMAL(10,2) NOT NULL COMMENT 'Tarifa acordada por noche en dólares',
  canal ENUM('web','telefono','agencia','mostrador') NOT NULL COMMENT 'Canal por el que se realizó la reserva',
  estado ENUM('confirmada','completada','cancelada','no_show') NOT NULL COMMENT 'Estado de la reserva',
  PRIMARY KEY (id_reserva),
  FOREIGN KEY (id_huesped) REFERENCES huespedes(id_huesped),
  FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion)
) COMMENT='Reservas de habitaciones hechas por los huéspedes';

CREATE TABLE servicios (
  id_servicio INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del servicio',
  nombre_servicio VARCHAR(80) NOT NULL COMMENT 'Nombre del servicio adicional',
  categoria ENUM('restaurante','spa','lavanderia','minibar','transporte') NOT NULL COMMENT 'Categoría del servicio',
  precio_unitario DECIMAL(10,2) NOT NULL COMMENT 'Precio por unidad del servicio en dólares',
  PRIMARY KEY (id_servicio)
) COMMENT='Catálogo de servicios adicionales que se cobran durante la estancia';

CREATE TABLE consumos (
  id_consumo INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del consumo',
  id_reserva INT NOT NULL COMMENT 'Reserva a la que se carga el consumo',
  id_servicio INT NOT NULL COMMENT 'Servicio consumido',
  fecha_consumo DATETIME NOT NULL COMMENT 'Fecha y hora del consumo',
  cantidad INT NOT NULL COMMENT 'Unidades consumidas del servicio',
  monto DECIMAL(10,2) NOT NULL COMMENT 'Importe total del consumo (cantidad por precio unitario)',
  PRIMARY KEY (id_consumo),
  FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
  FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
) COMMENT='Servicios consumidos por los huéspedes y cargados a su reserva';

CREATE TABLE facturas (
  id_factura INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la factura',
  id_reserva INT NOT NULL COMMENT 'Reserva facturada',
  fecha_emision DATE NOT NULL COMMENT 'Fecha de emisión de la factura',
  subtotal DECIMAL(10,2) NOT NULL COMMENT 'Importe antes de impuestos (hospedaje más consumos)',
  impuesto DECIMAL(10,2) NOT NULL COMMENT 'Impuesto aplicado (12% del subtotal)',
  total DECIMAL(10,2) NOT NULL COMMENT 'Importe total a pagar (subtotal más impuesto)',
  metodo_pago ENUM('efectivo','tarjeta','transferencia') NULL COMMENT 'Método de pago; NULL si aún no se ha pagado',
  pagada TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica si la factura ya fue pagada (1 = sí, 0 = no)',
  PRIMARY KEY (id_factura),
  FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva)
) COMMENT='Facturas emitidas al cierre de las estancias';
