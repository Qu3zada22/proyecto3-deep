CREATE TABLE `carr` (
  `carr_id` int NOT NULL COMMENT 'Identificador de la carrera',
  `nom_carr` varchar(80) NOT NULL COMMENT 'Nombre de la carrera',
  `fac_id` int NOT NULL COMMENT 'Facultad a la que pertenece la carrera (FK a fac)',
  `dur_sem` int NOT NULL COMMENT 'Duración de la carrera en semestres (dur = duración, sem = semestres)',
  `cuota_sem` decimal(10,2) NOT NULL COMMENT 'Cuota de colegiatura por semestre en quetzales',
  PRIMARY KEY (`carr_id`),
  KEY `fac_id` (`fac_id`),
  CONSTRAINT `carr_ibfk_1` FOREIGN KEY (`fac_id`) REFERENCES `fac` (`fac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Carreras (carr) que ofrece cada facultad';

CREATE TABLE `cur` (
  `cod_cur` varchar(10) NOT NULL COMMENT 'Código del curso (cod = código, cur = curso), por ejemplo INF101',
  `nom_cur` varchar(100) NOT NULL COMMENT 'Nombre del curso',
  `cred` int NOT NULL COMMENT 'Número de créditos del curso (cred = créditos)',
  `carr_id` int NOT NULL COMMENT 'Carrera a la que pertenece el curso (FK a carr)',
  `prereq` varchar(10) DEFAULT NULL COMMENT 'Código del curso prerrequisito (prereq = prerrequisito), NULL si no tiene',
  PRIMARY KEY (`cod_cur`),
  KEY `carr_id` (`carr_id`),
  KEY `prereq` (`prereq`),
  CONSTRAINT `cur_ibfk_1` FOREIGN KEY (`carr_id`) REFERENCES `carr` (`carr_id`),
  CONSTRAINT `cur_ibfk_2` FOREIGN KEY (`prereq`) REFERENCES `cur` (`cod_cur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cursos (cur) del plan de estudios';

CREATE TABLE `est` (
  `est_id` int NOT NULL COMMENT 'Identificador (carné) del estudiante',
  `nom_est` varchar(60) NOT NULL COMMENT 'Nombre(s) del estudiante',
  `ape_est` varchar(60) NOT NULL COMMENT 'Apellido(s) del estudiante (ape = apellido)',
  `email_est` varchar(100) DEFAULT NULL COMMENT 'Correo electrónico del estudiante',
  `gen` char(1) NOT NULL COMMENT 'Género del estudiante: M = masculino, F = femenino',
  `fec_nac` date NOT NULL COMMENT 'Fecha de nacimiento del estudiante (fec = fecha, nac = nacimiento)',
  `carr_id` int NOT NULL COMMENT 'Carrera en la que está inscrito el estudiante (FK a carr)',
  `fec_ing` date NOT NULL COMMENT 'Fecha de ingreso del estudiante a la universidad (ing = ingreso)',
  `beca` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 si el estudiante tiene beca, 0 si no',
  PRIMARY KEY (`est_id`),
  KEY `carr_id` (`carr_id`),
  CONSTRAINT `est_ibfk_1` FOREIGN KEY (`carr_id`) REFERENCES `carr` (`carr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Estudiantes (est) de la universidad';

CREATE TABLE `fac` (
  `fac_id` int NOT NULL COMMENT 'Identificador de la facultad',
  `nom_fac` varchar(80) NOT NULL COMMENT 'Nombre de la facultad',
  `dec_fac` varchar(80) DEFAULT NULL COMMENT 'Nombre del decano o decana de la facultad (dec = decano)',
  `anio_fund` int NOT NULL COMMENT 'Año de fundación de la facultad',
  PRIMARY KEY (`fac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Facultades (fac) de la universidad';

CREATE TABLE `insc` (
  `insc_id` int NOT NULL COMMENT 'Identificador de la inscripción (insc = inscripción)',
  `est_id` int NOT NULL COMMENT 'Estudiante inscrito (FK a est)',
  `sec_id` int NOT NULL COMMENT 'Sección en la que se inscribe (FK a sec)',
  `fec_insc` datetime NOT NULL COMMENT 'Fecha y hora de la inscripción (fec = fecha, insc = inscripción)',
  `nota_fin` decimal(5,2) DEFAULT NULL COMMENT 'Nota final del curso sobre 100 (fin = final), NULL si aún no hay nota o se retiró',
  `est_insc` enum('activa','aprobada','reprobada','retirada') NOT NULL COMMENT 'Estado de la inscripción (est_insc = estado de la inscripción)',
  PRIMARY KEY (`insc_id`),
  KEY `est_id` (`est_id`),
  KEY `sec_id` (`sec_id`),
  CONSTRAINT `insc_ibfk_1` FOREIGN KEY (`est_id`) REFERENCES `est` (`est_id`),
  CONSTRAINT `insc_ibfk_2` FOREIGN KEY (`sec_id`) REFERENCES `sec` (`sec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Inscripciones (insc) de estudiantes en secciones';

CREATE TABLE `pag` (
  `pag_id` int NOT NULL COMMENT 'Identificador del pago (pag = pago)',
  `est_id` int NOT NULL COMMENT 'Estudiante que realiza el pago (FK a est)',
  `monto` decimal(10,2) NOT NULL COMMENT 'Monto pagado en quetzales',
  `fec_pag` date NOT NULL COMMENT 'Fecha del pago (fec = fecha, pag = pago)',
  `met_pag` enum('efectivo','tarjeta','transferencia') NOT NULL COMMENT 'Método de pago (met = método)',
  `sem` varchar(6) NOT NULL COMMENT 'Semestre que cubre el pago, formato AAAA-S (sem = semestre)',
  PRIMARY KEY (`pag_id`),
  KEY `est_id` (`est_id`),
  CONSTRAINT `pag_ibfk_1` FOREIGN KEY (`est_id`) REFERENCES `est` (`est_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Pagos (pag) de colegiatura de los estudiantes';

CREATE TABLE `prof` (
  `prof_id` int NOT NULL COMMENT 'Identificador del profesor',
  `nom_prof` varchar(60) NOT NULL COMMENT 'Nombre(s) del profesor',
  `ape_prof` varchar(60) NOT NULL COMMENT 'Apellido(s) del profesor (ape = apellido)',
  `email_prof` varchar(100) DEFAULT NULL COMMENT 'Correo electrónico institucional del profesor',
  `fac_id` int NOT NULL COMMENT 'Facultad a la que está adscrito el profesor (FK a fac)',
  `grado` enum('Lic','MSc','PhD') NOT NULL COMMENT 'Grado académico más alto: Lic = licenciatura, MSc = maestría, PhD = doctorado',
  `fec_contr` date NOT NULL COMMENT 'Fecha de contratación del profesor (fec = fecha, contr = contratación)',
  `sal_men` decimal(10,2) NOT NULL COMMENT 'Salario mensual del profesor en quetzales (sal = salario, men = mensual)',
  PRIMARY KEY (`prof_id`),
  KEY `fac_id` (`fac_id`),
  CONSTRAINT `prof_ibfk_1` FOREIGN KEY (`fac_id`) REFERENCES `fac` (`fac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Profesores (prof) de la universidad';

CREATE TABLE `sec` (
  `sec_id` int NOT NULL COMMENT 'Identificador de la sección',
  `cod_cur` varchar(10) NOT NULL COMMENT 'Curso que se imparte en la sección (FK a cur)',
  `prof_id` int NOT NULL COMMENT 'Profesor que imparte la sección (FK a prof)',
  `sem` varchar(6) NOT NULL COMMENT 'Semestre en formato AAAA-S, por ejemplo 2024-1 (sem = semestre)',
  `anio` int NOT NULL COMMENT 'Año académico de la sección',
  `cupo` int NOT NULL COMMENT 'Cupo máximo de estudiantes de la sección',
  `aula` varchar(10) DEFAULT NULL COMMENT 'Aula asignada a la sección, NULL si es virtual',
  PRIMARY KEY (`sec_id`),
  KEY `cod_cur` (`cod_cur`),
  KEY `prof_id` (`prof_id`),
  CONSTRAINT `sec_ibfk_1` FOREIGN KEY (`cod_cur`) REFERENCES `cur` (`cod_cur`),
  CONSTRAINT `sec_ibfk_2` FOREIGN KEY (`prof_id`) REFERENCES `prof` (`prof_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Secciones (sec) de cursos abiertas en cada semestre';
