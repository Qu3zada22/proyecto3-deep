CREATE TABLE `citas` (
  `id_cita` int NOT NULL COMMENT 'Identificador de la cita',
  `id_paciente` int NOT NULL COMMENT 'Paciente que asiste a la cita (FK a pacientes)',
  `id_medico` int NOT NULL COMMENT 'Médico que atiende la cita (FK a medicos)',
  `fecha_hora` datetime NOT NULL COMMENT 'Fecha y hora programada de la cita',
  `motivo` varchar(150) NOT NULL COMMENT 'Motivo de la consulta',
  `estado` enum('programada','completada','cancelada','no_asistio') NOT NULL COMMENT 'Estado de la cita',
  `costo` decimal(10,2) NOT NULL COMMENT 'Costo de la consulta en quetzales',
  PRIMARY KEY (`id_cita`),
  KEY `id_paciente` (`id_paciente`),
  KEY `id_medico` (`id_medico`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`),
  CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`id_medico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Citas médicas de consulta externa';

CREATE TABLE `diagnosticos` (
  `id_diagnostico` int NOT NULL COMMENT 'Identificador del diagnóstico',
  `id_cita` int NOT NULL COMMENT 'Cita en la que se emitió el diagnóstico (FK a citas)',
  `codigo_cie` varchar(10) NOT NULL COMMENT 'Código de la enfermedad según la clasificación CIE-10',
  `descripcion` varchar(150) NOT NULL COMMENT 'Descripción del diagnóstico',
  `gravedad` enum('leve','moderada','grave') NOT NULL COMMENT 'Gravedad del diagnóstico',
  PRIMARY KEY (`id_diagnostico`),
  KEY `id_cita` (`id_cita`),
  CONSTRAINT `diagnosticos_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `citas` (`id_cita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Diagnósticos emitidos en las citas';

CREATE TABLE `especialidades` (
  `id_especialidad` int NOT NULL COMMENT 'Identificador de la especialidad médica',
  `nombre_especialidad` varchar(80) NOT NULL COMMENT 'Nombre de la especialidad, por ejemplo Cardiología',
  `piso` int NOT NULL COMMENT 'Piso del hospital donde se ubica la especialidad',
  PRIMARY KEY (`id_especialidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Especialidades médicas del hospital';

CREATE TABLE `habitaciones` (
  `id_habitacion` int NOT NULL COMMENT 'Identificador de la habitación',
  `numero` varchar(10) NOT NULL COMMENT 'Número visible de la habitación, por ejemplo 301',
  `tipo` enum('individual','doble','uci') NOT NULL COMMENT 'Tipo de habitación; uci = unidad de cuidados intensivos',
  `piso` int NOT NULL COMMENT 'Piso en que se ubica la habitación',
  `costo_diario` decimal(10,2) NOT NULL COMMENT 'Costo por día de estancia en quetzales',
  PRIMARY KEY (`id_habitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Habitaciones para hospitalización';

CREATE TABLE `ingresos` (
  `id_ingreso` int NOT NULL COMMENT 'Identificador del ingreso hospitalario',
  `id_paciente` int NOT NULL COMMENT 'Paciente hospitalizado (FK a pacientes)',
  `id_habitacion` int NOT NULL COMMENT 'Habitación asignada (FK a habitaciones)',
  `id_medico` int NOT NULL COMMENT 'Médico responsable del ingreso (FK a medicos)',
  `fecha_ingreso` datetime NOT NULL COMMENT 'Fecha y hora en que ingresó el paciente',
  `fecha_alta` datetime DEFAULT NULL COMMENT 'Fecha y hora del alta, NULL si el paciente sigue hospitalizado',
  `motivo_ingreso` varchar(150) NOT NULL COMMENT 'Motivo de la hospitalización',
  PRIMARY KEY (`id_ingreso`),
  KEY `id_paciente` (`id_paciente`),
  KEY `id_habitacion` (`id_habitacion`),
  KEY `id_medico` (`id_medico`),
  CONSTRAINT `ingresos_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`),
  CONSTRAINT `ingresos_ibfk_2` FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id_habitacion`),
  CONSTRAINT `ingresos_ibfk_3` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`id_medico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Ingresos (hospitalizaciones) de pacientes';

CREATE TABLE `medicamentos` (
  `id_medicamento` int NOT NULL COMMENT 'Identificador del medicamento',
  `nombre_comercial` varchar(80) NOT NULL COMMENT 'Nombre comercial del medicamento',
  `principio_activo` varchar(80) NOT NULL COMMENT 'Principio activo del medicamento',
  `presentacion` varchar(40) NOT NULL COMMENT 'Presentación: tabletas, jarabe, cápsulas, inyectable, etc.',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio por unidad o caja en quetzales',
  `requiere_receta` tinyint(1) NOT NULL COMMENT '1 si el medicamento requiere receta médica, 0 si es de venta libre',
  PRIMARY KEY (`id_medicamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Catálogo de medicamentos de la farmacia del hospital';

CREATE TABLE `medicos` (
  `id_medico` int NOT NULL COMMENT 'Identificador del médico',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre(s) del médico',
  `apellido` varchar(60) NOT NULL COMMENT 'Apellido(s) del médico',
  `id_especialidad` int NOT NULL COMMENT 'Especialidad del médico (FK a especialidades)',
  `correo` varchar(100) DEFAULT NULL COMMENT 'Correo electrónico del médico',
  `fecha_contratacion` date NOT NULL COMMENT 'Fecha en que el médico fue contratado',
  `salario_mensual` decimal(10,2) NOT NULL COMMENT 'Salario mensual del médico en quetzales',
  `activo` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 si el médico sigue laborando en el hospital, 0 si no',
  PRIMARY KEY (`id_medico`),
  KEY `id_especialidad` (`id_especialidad`),
  CONSTRAINT `medicos_ibfk_1` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidades` (`id_especialidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Médicos que trabajan en el hospital';

CREATE TABLE `pacientes` (
  `id_paciente` int NOT NULL COMMENT 'Identificador del paciente',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre(s) del paciente',
  `apellido` varchar(60) NOT NULL COMMENT 'Apellido(s) del paciente',
  `fecha_nacimiento` date NOT NULL COMMENT 'Fecha de nacimiento del paciente',
  `genero` enum('masculino','femenino') NOT NULL COMMENT 'Género del paciente',
  `telefono` varchar(20) DEFAULT NULL COMMENT 'Teléfono de contacto del paciente, NULL si no lo proporcionó',
  `ciudad` varchar(60) NOT NULL COMMENT 'Ciudad de residencia del paciente',
  `aseguradora` varchar(60) DEFAULT NULL COMMENT 'Nombre de la aseguradora médica, NULL si no tiene seguro',
  `fecha_registro` date NOT NULL COMMENT 'Fecha en que el paciente se registró en el hospital',
  PRIMARY KEY (`id_paciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Pacientes registrados en el hospital';

CREATE TABLE `recetas` (
  `id_receta` int NOT NULL COMMENT 'Identificador de la línea de receta',
  `id_cita` int NOT NULL COMMENT 'Cita en la que se emitió la receta (FK a citas)',
  `id_medicamento` int NOT NULL COMMENT 'Medicamento recetado (FK a medicamentos)',
  `dosis` varchar(60) NOT NULL COMMENT 'Dosis indicada, por ejemplo 1 tableta cada 8 horas',
  `duracion_dias` int NOT NULL COMMENT 'Duración del tratamiento en días',
  `cantidad` int NOT NULL COMMENT 'Cantidad de unidades o cajas recetadas',
  PRIMARY KEY (`id_receta`),
  KEY `id_cita` (`id_cita`),
  KEY `id_medicamento` (`id_medicamento`),
  CONSTRAINT `recetas_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `citas` (`id_cita`),
  CONSTRAINT `recetas_ibfk_2` FOREIGN KEY (`id_medicamento`) REFERENCES `medicamentos` (`id_medicamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Medicamentos recetados en cada cita';
