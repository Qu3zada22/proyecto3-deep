CREATE TABLE fac (
  fac_id INT NOT NULL COMMENT 'Identificador de la facultad',
  nom_fac VARCHAR(80) NOT NULL COMMENT 'Nombre de la facultad',
  dec_fac VARCHAR(80) NULL COMMENT 'Nombre del decano o decana de la facultad (dec = decano)',
  anio_fund INT NOT NULL COMMENT 'Año de fundación de la facultad',
  PRIMARY KEY (fac_id)
) COMMENT='Facultades (fac) de la universidad';

CREATE TABLE carr (
  carr_id INT NOT NULL COMMENT 'Identificador de la carrera',
  nom_carr VARCHAR(80) NOT NULL COMMENT 'Nombre de la carrera',
  fac_id INT NOT NULL COMMENT 'Facultad a la que pertenece la carrera (FK a fac)',
  dur_sem INT NOT NULL COMMENT 'Duración de la carrera en semestres (dur = duración, sem = semestres)',
  cuota_sem DECIMAL(10,2) NOT NULL COMMENT 'Cuota de colegiatura por semestre en quetzales',
  PRIMARY KEY (carr_id),
  FOREIGN KEY (fac_id) REFERENCES fac (fac_id)
) COMMENT='Carreras (carr) que ofrece cada facultad';

CREATE TABLE prof (
  prof_id INT NOT NULL COMMENT 'Identificador del profesor',
  nom_prof VARCHAR(60) NOT NULL COMMENT 'Nombre(s) del profesor',
  ape_prof VARCHAR(60) NOT NULL COMMENT 'Apellido(s) del profesor (ape = apellido)',
  email_prof VARCHAR(100) NULL COMMENT 'Correo electrónico institucional del profesor',
  fac_id INT NOT NULL COMMENT 'Facultad a la que está adscrito el profesor (FK a fac)',
  grado ENUM('Lic','MSc','PhD') NOT NULL COMMENT 'Grado académico más alto: Lic = licenciatura, MSc = maestría, PhD = doctorado',
  fec_contr DATE NOT NULL COMMENT 'Fecha de contratación del profesor (fec = fecha, contr = contratación)',
  sal_men DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual del profesor en quetzales (sal = salario, men = mensual)',
  PRIMARY KEY (prof_id),
  FOREIGN KEY (fac_id) REFERENCES fac (fac_id)
) COMMENT='Profesores (prof) de la universidad';

CREATE TABLE est (
  est_id INT NOT NULL COMMENT 'Identificador (carné) del estudiante',
  nom_est VARCHAR(60) NOT NULL COMMENT 'Nombre(s) del estudiante',
  ape_est VARCHAR(60) NOT NULL COMMENT 'Apellido(s) del estudiante (ape = apellido)',
  email_est VARCHAR(100) NULL COMMENT 'Correo electrónico del estudiante',
  gen CHAR(1) NOT NULL COMMENT 'Género del estudiante: M = masculino, F = femenino',
  fec_nac DATE NOT NULL COMMENT 'Fecha de nacimiento del estudiante (fec = fecha, nac = nacimiento)',
  carr_id INT NOT NULL COMMENT 'Carrera en la que está inscrito el estudiante (FK a carr)',
  fec_ing DATE NOT NULL COMMENT 'Fecha de ingreso del estudiante a la universidad (ing = ingreso)',
  beca TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1 si el estudiante tiene beca, 0 si no',
  PRIMARY KEY (est_id),
  FOREIGN KEY (carr_id) REFERENCES carr (carr_id)
) COMMENT='Estudiantes (est) de la universidad';

CREATE TABLE cur (
  cod_cur VARCHAR(10) NOT NULL COMMENT 'Código del curso (cod = código, cur = curso), por ejemplo INF101',
  nom_cur VARCHAR(100) NOT NULL COMMENT 'Nombre del curso',
  cred INT NOT NULL COMMENT 'Número de créditos del curso (cred = créditos)',
  carr_id INT NOT NULL COMMENT 'Carrera a la que pertenece el curso (FK a carr)',
  prereq VARCHAR(10) NULL COMMENT 'Código del curso prerrequisito (prereq = prerrequisito), NULL si no tiene',
  PRIMARY KEY (cod_cur),
  FOREIGN KEY (carr_id) REFERENCES carr (carr_id),
  FOREIGN KEY (prereq) REFERENCES cur (cod_cur)
) COMMENT='Cursos (cur) del plan de estudios';

CREATE TABLE sec (
  sec_id INT NOT NULL COMMENT 'Identificador de la sección',
  cod_cur VARCHAR(10) NOT NULL COMMENT 'Curso que se imparte en la sección (FK a cur)',
  prof_id INT NOT NULL COMMENT 'Profesor que imparte la sección (FK a prof)',
  sem VARCHAR(6) NOT NULL COMMENT 'Semestre en formato AAAA-S, por ejemplo 2024-1 (sem = semestre)',
  anio INT NOT NULL COMMENT 'Año académico de la sección',
  cupo INT NOT NULL COMMENT 'Cupo máximo de estudiantes de la sección',
  aula VARCHAR(10) NULL COMMENT 'Aula asignada a la sección, NULL si es virtual',
  PRIMARY KEY (sec_id),
  FOREIGN KEY (cod_cur) REFERENCES cur (cod_cur),
  FOREIGN KEY (prof_id) REFERENCES prof (prof_id)
) COMMENT='Secciones (sec) de cursos abiertas en cada semestre';

CREATE TABLE insc (
  insc_id INT NOT NULL COMMENT 'Identificador de la inscripción (insc = inscripción)',
  est_id INT NOT NULL COMMENT 'Estudiante inscrito (FK a est)',
  sec_id INT NOT NULL COMMENT 'Sección en la que se inscribe (FK a sec)',
  fec_insc DATETIME NOT NULL COMMENT 'Fecha y hora de la inscripción (fec = fecha, insc = inscripción)',
  nota_fin DECIMAL(5,2) NULL COMMENT 'Nota final del curso sobre 100 (fin = final), NULL si aún no hay nota o se retiró',
  est_insc ENUM('activa','aprobada','reprobada','retirada') NOT NULL COMMENT 'Estado de la inscripción (est_insc = estado de la inscripción)',
  PRIMARY KEY (insc_id),
  FOREIGN KEY (est_id) REFERENCES est (est_id),
  FOREIGN KEY (sec_id) REFERENCES sec (sec_id)
) COMMENT='Inscripciones (insc) de estudiantes en secciones';

CREATE TABLE pag (
  pag_id INT NOT NULL COMMENT 'Identificador del pago (pag = pago)',
  est_id INT NOT NULL COMMENT 'Estudiante que realiza el pago (FK a est)',
  monto DECIMAL(10,2) NOT NULL COMMENT 'Monto pagado en quetzales',
  fec_pag DATE NOT NULL COMMENT 'Fecha del pago (fec = fecha, pag = pago)',
  met_pag ENUM('efectivo','tarjeta','transferencia') NOT NULL COMMENT 'Método de pago (met = método)',
  sem VARCHAR(6) NOT NULL COMMENT 'Semestre que cubre el pago, formato AAAA-S (sem = semestre)',
  PRIMARY KEY (pag_id),
  FOREIGN KEY (est_id) REFERENCES est (est_id)
) COMMENT='Pagos (pag) de colegiatura de los estudiantes';
