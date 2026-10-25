CREATE TABLE especialidades (
  id_especialidad INT NOT NULL COMMENT 'Identificador de la especialidad médica',
  nombre_especialidad VARCHAR(80) NOT NULL COMMENT 'Nombre de la especialidad, por ejemplo Cardiología',
  piso INT NOT NULL COMMENT 'Piso del hospital donde se ubica la especialidad',
  PRIMARY KEY (id_especialidad)
) COMMENT='Especialidades médicas del hospital';

CREATE TABLE medicos (
  id_medico INT NOT NULL COMMENT 'Identificador del médico',
  nombre VARCHAR(60) NOT NULL COMMENT 'Nombre(s) del médico',
  apellido VARCHAR(60) NOT NULL COMMENT 'Apellido(s) del médico',
  id_especialidad INT NOT NULL COMMENT 'Especialidad del médico (FK a especialidades)',
  correo VARCHAR(100) NULL COMMENT 'Correo electrónico del médico',
  fecha_contratacion DATE NOT NULL COMMENT 'Fecha en que el médico fue contratado',
  salario_mensual DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual del médico en quetzales',
  activo TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 si el médico sigue laborando en el hospital, 0 si no',
  PRIMARY KEY (id_medico),
  FOREIGN KEY (id_especialidad) REFERENCES especialidades (id_especialidad)
) COMMENT='Médicos que trabajan en el hospital';

CREATE TABLE pacientes (
  id_paciente INT NOT NULL COMMENT 'Identificador del paciente',
  nombre VARCHAR(60) NOT NULL COMMENT 'Nombre(s) del paciente',
  apellido VARCHAR(60) NOT NULL COMMENT 'Apellido(s) del paciente',
  fecha_nacimiento DATE NOT NULL COMMENT 'Fecha de nacimiento del paciente',
  genero ENUM('masculino','femenino') NOT NULL COMMENT 'Género del paciente',
  telefono VARCHAR(20) NULL COMMENT 'Teléfono de contacto del paciente, NULL si no lo proporcionó',
  ciudad VARCHAR(60) NOT NULL COMMENT 'Ciudad de residencia del paciente',
  aseguradora VARCHAR(60) NULL COMMENT 'Nombre de la aseguradora médica, NULL si no tiene seguro',
  fecha_registro DATE NOT NULL COMMENT 'Fecha en que el paciente se registró en el hospital',
  PRIMARY KEY (id_paciente)
) COMMENT='Pacientes registrados en el hospital';

CREATE TABLE citas (
  id_cita INT NOT NULL COMMENT 'Identificador de la cita',
  id_paciente INT NOT NULL COMMENT 'Paciente que asiste a la cita (FK a pacientes)',
  id_medico INT NOT NULL COMMENT 'Médico que atiende la cita (FK a medicos)',
  fecha_hora DATETIME NOT NULL COMMENT 'Fecha y hora programada de la cita',
  motivo VARCHAR(150) NOT NULL COMMENT 'Motivo de la consulta',
  estado ENUM('programada','completada','cancelada','no_asistio') NOT NULL COMMENT 'Estado de la cita',
  costo DECIMAL(10,2) NOT NULL COMMENT 'Costo de la consulta en quetzales',
  PRIMARY KEY (id_cita),
  FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
  FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
) COMMENT='Citas médicas de consulta externa';

CREATE TABLE diagnosticos (
  id_diagnostico INT NOT NULL COMMENT 'Identificador del diagnóstico',
  id_cita INT NOT NULL COMMENT 'Cita en la que se emitió el diagnóstico (FK a citas)',
  codigo_cie VARCHAR(10) NOT NULL COMMENT 'Código de la enfermedad según la clasificación CIE-10',
  descripcion VARCHAR(150) NOT NULL COMMENT 'Descripción del diagnóstico',
  gravedad ENUM('leve','moderada','grave') NOT NULL COMMENT 'Gravedad del diagnóstico',
  PRIMARY KEY (id_diagnostico),
  FOREIGN KEY (id_cita) REFERENCES citas (id_cita)
) COMMENT='Diagnósticos emitidos en las citas';

CREATE TABLE medicamentos (
  id_medicamento INT NOT NULL COMMENT 'Identificador del medicamento',
  nombre_comercial VARCHAR(80) NOT NULL COMMENT 'Nombre comercial del medicamento',
  principio_activo VARCHAR(80) NOT NULL COMMENT 'Principio activo del medicamento',
  presentacion VARCHAR(40) NOT NULL COMMENT 'Presentación: tabletas, jarabe, cápsulas, inyectable, etc.',
  precio_unitario DECIMAL(10,2) NOT NULL COMMENT 'Precio por unidad o caja en quetzales',
  requiere_receta TINYINT(1) NOT NULL COMMENT '1 si el medicamento requiere receta médica, 0 si es de venta libre',
  PRIMARY KEY (id_medicamento)
) COMMENT='Catálogo de medicamentos de la farmacia del hospital';

CREATE TABLE recetas (
  id_receta INT NOT NULL COMMENT 'Identificador de la línea de receta',
  id_cita INT NOT NULL COMMENT 'Cita en la que se emitió la receta (FK a citas)',
  id_medicamento INT NOT NULL COMMENT 'Medicamento recetado (FK a medicamentos)',
  dosis VARCHAR(60) NOT NULL COMMENT 'Dosis indicada, por ejemplo 1 tableta cada 8 horas',
  duracion_dias INT NOT NULL COMMENT 'Duración del tratamiento en días',
  cantidad INT NOT NULL COMMENT 'Cantidad de unidades o cajas recetadas',
  PRIMARY KEY (id_receta),
  FOREIGN KEY (id_cita) REFERENCES citas (id_cita),
  FOREIGN KEY (id_medicamento) REFERENCES medicamentos (id_medicamento)
) COMMENT='Medicamentos recetados en cada cita';

CREATE TABLE habitaciones (
  id_habitacion INT NOT NULL COMMENT 'Identificador de la habitación',
  numero VARCHAR(10) NOT NULL COMMENT 'Número visible de la habitación, por ejemplo 301',
  tipo ENUM('individual','doble','uci') NOT NULL COMMENT 'Tipo de habitación; uci = unidad de cuidados intensivos',
  piso INT NOT NULL COMMENT 'Piso en que se ubica la habitación',
  costo_diario DECIMAL(10,2) NOT NULL COMMENT 'Costo por día de estancia en quetzales',
  PRIMARY KEY (id_habitacion)
) COMMENT='Habitaciones para hospitalización';

CREATE TABLE ingresos (
  id_ingreso INT NOT NULL COMMENT 'Identificador del ingreso hospitalario',
  id_paciente INT NOT NULL COMMENT 'Paciente hospitalizado (FK a pacientes)',
  id_habitacion INT NOT NULL COMMENT 'Habitación asignada (FK a habitaciones)',
  id_medico INT NOT NULL COMMENT 'Médico responsable del ingreso (FK a medicos)',
  fecha_ingreso DATETIME NOT NULL COMMENT 'Fecha y hora en que ingresó el paciente',
  fecha_alta DATETIME NULL COMMENT 'Fecha y hora del alta, NULL si el paciente sigue hospitalizado',
  motivo_ingreso VARCHAR(150) NOT NULL COMMENT 'Motivo de la hospitalización',
  PRIMARY KEY (id_ingreso),
  FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
  FOREIGN KEY (id_habitacion) REFERENCES habitaciones (id_habitacion),
  FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
) COMMENT='Ingresos (hospitalizaciones) de pacientes';
