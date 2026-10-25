CREATE TABLE sedes (
  id_sede INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la sede',
  nombre VARCHAR(80) NOT NULL COMMENT 'Nombre de la sede del gimnasio',
  ciudad VARCHAR(60) NOT NULL COMMENT 'Ciudad donde está la sede',
  direccion VARCHAR(150) NOT NULL COMMENT 'Dirección de la sede',
  fecha_inauguracion DATE NOT NULL COMMENT 'Fecha en que abrió la sede',
  capacidad_maxima SMALLINT NOT NULL COMMENT 'Número máximo de personas permitidas al mismo tiempo',
  PRIMARY KEY (id_sede)
) COMMENT='Sedes (sucursales) de la cadena de gimnasios';

CREATE TABLE planes (
  id_plan INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del plan',
  nombre_plan VARCHAR(50) NOT NULL COMMENT 'Nombre comercial del plan (Básico, Plus, Premium, etc.)',
  duracion_meses TINYINT NOT NULL COMMENT 'Duración del plan en meses',
  precio_mensual DECIMAL(8,2) NOT NULL COMMENT 'Precio por mes en quetzales',
  incluye_clases TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica si el plan incluye clases grupales (1 = sí, 0 = no)',
  PRIMARY KEY (id_plan)
) COMMENT='Catálogo de planes de membresía';

CREATE TABLE socios (
  id_socio INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del socio',
  nombre VARCHAR(60) NOT NULL COMMENT 'Nombre del socio',
  apellido VARCHAR(60) NOT NULL COMMENT 'Apellido del socio',
  genero ENUM('F','M') NOT NULL COMMENT 'Género del socio (F = femenino, M = masculino)',
  fecha_nacimiento DATE NOT NULL COMMENT 'Fecha de nacimiento del socio',
  telefono VARCHAR(20) NULL COMMENT 'Teléfono del socio; NULL si no lo proporcionó',
  correo VARCHAR(120) NULL COMMENT 'Correo electrónico del socio; NULL si no lo proporcionó',
  id_sede_principal INT NOT NULL COMMENT 'Sede donde se inscribió el socio',
  fecha_alta DATE NOT NULL COMMENT 'Fecha en que el socio se registró en el gimnasio',
  PRIMARY KEY (id_socio),
  FOREIGN KEY (id_sede_principal) REFERENCES sedes(id_sede)
) COMMENT='Personas registradas como socias del gimnasio';

CREATE TABLE membresias (
  id_membresia INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la membresía',
  id_socio INT NOT NULL COMMENT 'Socio dueño de la membresía',
  id_plan INT NOT NULL COMMENT 'Plan contratado',
  fecha_inicio DATE NOT NULL COMMENT 'Fecha de inicio de la membresía',
  fecha_fin DATE NOT NULL COMMENT 'Fecha de vencimiento de la membresía',
  estado ENUM('activa','vencida','cancelada') NOT NULL COMMENT 'Estado de la membresía',
  PRIMARY KEY (id_membresia),
  FOREIGN KEY (id_socio) REFERENCES socios(id_socio),
  FOREIGN KEY (id_plan) REFERENCES planes(id_plan)
) COMMENT='Membresías contratadas por los socios; un socio puede tener varias a lo largo del tiempo';

CREATE TABLE entrenadores (
  id_entrenador INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del entrenador',
  nombre_completo VARCHAR(120) NOT NULL COMMENT 'Nombre y apellido del entrenador',
  especialidad VARCHAR(60) NOT NULL COMMENT 'Especialidad principal del entrenador',
  id_sede INT NOT NULL COMMENT 'Sede donde trabaja el entrenador',
  salario_mensual DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual en quetzales',
  fecha_contratacion DATE NOT NULL COMMENT 'Fecha de contratación',
  certificado TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica si tiene certificación internacional (1 = sí, 0 = no)',
  PRIMARY KEY (id_entrenador),
  FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
) COMMENT='Entrenadores que imparten clases en las sedes';

CREATE TABLE clases (
  id_clase INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la clase',
  nombre_clase VARCHAR(60) NOT NULL COMMENT 'Nombre de la clase (Spinning, Yoga, CrossFit, etc.)',
  tipo ENUM('cardio','fuerza','flexibilidad','combate','acuatica') NOT NULL COMMENT 'Tipo de actividad de la clase',
  id_entrenador INT NOT NULL COMMENT 'Entrenador que imparte la clase',
  id_sede INT NOT NULL COMMENT 'Sede donde se imparte la clase',
  dia_semana ENUM('lunes','martes','miercoles','jueves','viernes','sabado') NOT NULL COMMENT 'Día de la semana en que se imparte',
  hora_inicio TIME NOT NULL COMMENT 'Hora de inicio de la clase',
  duracion_min SMALLINT NOT NULL COMMENT 'Duración de la clase en minutos',
  cupo_maximo SMALLINT NOT NULL COMMENT 'Número máximo de socios inscritos',
  PRIMARY KEY (id_clase),
  FOREIGN KEY (id_entrenador) REFERENCES entrenadores(id_entrenador),
  FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
) COMMENT='Clases grupales semanales';

CREATE TABLE inscripciones (
  id_inscripcion INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la inscripción',
  id_socio INT NOT NULL COMMENT 'Socio inscrito',
  id_clase INT NOT NULL COMMENT 'Clase a la que se inscribió',
  fecha_inscripcion DATE NOT NULL COMMENT 'Fecha de inscripción a la clase',
  PRIMARY KEY (id_inscripcion),
  FOREIGN KEY (id_socio) REFERENCES socios(id_socio),
  FOREIGN KEY (id_clase) REFERENCES clases(id_clase)
) COMMENT='Inscripciones de socios a clases grupales';

CREATE TABLE asistencias (
  id_asistencia INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la visita',
  id_socio INT NOT NULL COMMENT 'Socio que visitó el gimnasio',
  id_sede INT NOT NULL COMMENT 'Sede visitada',
  entrada DATETIME NOT NULL COMMENT 'Fecha y hora de entrada',
  salida DATETIME NULL COMMENT 'Fecha y hora de salida; NULL si no marcó salida',
  PRIMARY KEY (id_asistencia),
  FOREIGN KEY (id_socio) REFERENCES socios(id_socio),
  FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
) COMMENT='Registro de entradas y salidas de los socios en las sedes';

CREATE TABLE pagos (
  id_pago INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del pago',
  id_membresia INT NOT NULL COMMENT 'Membresía a la que corresponde el pago',
  fecha_pago DATE NOT NULL COMMENT 'Fecha en que se realizó el pago',
  monto DECIMAL(10,2) NOT NULL COMMENT 'Monto pagado en quetzales',
  metodo ENUM('efectivo','tarjeta','transferencia') NOT NULL COMMENT 'Método de pago',
  PRIMARY KEY (id_pago),
  FOREIGN KEY (id_membresia) REFERENCES membresias(id_membresia)
) COMMENT='Pagos realizados por las membresías';
