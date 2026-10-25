-- Esquema de recursos humanos con nombres en inglés abreviados
CREATE TABLE loc (
  loc_id INT NOT NULL COMMENT 'Identificador de la ubicación (loc = location, sede física)',
  city_nm VARCHAR(60) NOT NULL COMMENT 'Nombre de la ciudad (city_nm = city name)',
  ctry_cd CHAR(2) NOT NULL COMMENT 'Código ISO de dos letras del país (ctry_cd = country code)',
  addr VARCHAR(120) NOT NULL COMMENT 'Dirección de la oficina (addr = address)',
  PRIMARY KEY (loc_id)
) COMMENT='Ubicaciones u oficinas de la empresa (loc = location)';

CREATE TABLE dept (
  dept_id INT NOT NULL COMMENT 'Identificador del departamento (dept = department)',
  dept_nm VARCHAR(60) NOT NULL COMMENT 'Nombre del departamento (dept_nm = department name)',
  loc_id INT NOT NULL COMMENT 'Ubicación donde opera el departamento, referencia a loc',
  bdgt_amt DECIMAL(12,2) NOT NULL COMMENT 'Presupuesto anual del departamento en USD (bdgt_amt = budget amount)',
  crt_dt DATE NOT NULL COMMENT 'Fecha de creación del departamento (crt_dt = creation date)',
  PRIMARY KEY (dept_id),
  FOREIGN KEY (loc_id) REFERENCES loc (loc_id)
) COMMENT='Departamentos de la empresa (dept = department)';

CREATE TABLE job (
  job_id INT NOT NULL COMMENT 'Identificador del puesto de trabajo',
  job_ttl VARCHAR(60) NOT NULL COMMENT 'Título del puesto (job_ttl = job title)',
  job_lvl ENUM('junior','mid','senior','lead','exec') NOT NULL COMMENT 'Nivel del puesto (job_lvl = job level)',
  min_sal DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual mínimo del puesto en USD (min_sal = minimum salary)',
  max_sal DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual máximo del puesto en USD (max_sal = maximum salary)',
  PRIMARY KEY (job_id)
) COMMENT='Catálogo de puestos de trabajo con su banda salarial';

CREATE TABLE emp (
  emp_id INT NOT NULL COMMENT 'Identificador del empleado (emp = employee)',
  fst_nm VARCHAR(40) NOT NULL COMMENT 'Nombre de pila del empleado (fst_nm = first name)',
  lst_nm VARCHAR(40) NOT NULL COMMENT 'Apellido del empleado (lst_nm = last name)',
  email VARCHAR(100) NOT NULL COMMENT 'Correo electrónico corporativo',
  gndr ENUM('M','F') NOT NULL COMMENT 'Género del empleado: M masculino, F femenino (gndr = gender)',
  hire_dt DATE NOT NULL COMMENT 'Fecha de contratación (hire_dt = hire date)',
  term_dt DATE NULL COMMENT 'Fecha de baja o terminación; NULL si sigue activo (term_dt = termination date)',
  job_id INT NOT NULL COMMENT 'Puesto actual del empleado, referencia a job',
  dept_id INT NOT NULL COMMENT 'Departamento actual del empleado, referencia a dept',
  mgr_id INT NULL COMMENT 'Jefe directo del empleado, referencia a emp.emp_id; NULL para el director general (mgr = manager)',
  sal_amt DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual actual en USD (sal_amt = salary amount)',
  is_rmt TINYINT(1) NOT NULL COMMENT 'Indica si trabaja en remoto: 1 sí, 0 no (is_rmt = is remote)',
  PRIMARY KEY (emp_id),
  FOREIGN KEY (job_id) REFERENCES job (job_id),
  FOREIGN KEY (dept_id) REFERENCES dept (dept_id),
  FOREIGN KEY (mgr_id) REFERENCES emp (emp_id)
) COMMENT='Empleados de la empresa con su jefe directo (emp = employee, mgr = manager)';

CREATE TABLE sal_hist (
  sal_hist_id INT NOT NULL COMMENT 'Identificador del registro de historial salarial (sal_hist = salary history)',
  emp_id INT NOT NULL COMMENT 'Empleado al que corresponde el cambio, referencia a emp',
  old_sal_amt DECIMAL(10,2) NULL COMMENT 'Salario mensual anterior en USD; NULL en el registro de contratación',
  new_sal_amt DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual nuevo en USD',
  chg_dt DATE NOT NULL COMMENT 'Fecha en que entró en vigor el cambio (chg_dt = change date)',
  chg_rsn ENUM('contratacion','merito','promocion','ajuste') NOT NULL COMMENT 'Motivo del cambio salarial (chg_rsn = change reason)',
  PRIMARY KEY (sal_hist_id),
  FOREIGN KEY (emp_id) REFERENCES emp (emp_id)
) COMMENT='Historial de cambios de salario de cada empleado (sal_hist = salary history)';

CREATE TABLE proj (
  proj_id INT NOT NULL COMMENT 'Identificador del proyecto (proj = project)',
  proj_nm VARCHAR(80) NOT NULL COMMENT 'Nombre del proyecto (proj_nm = project name)',
  dept_id INT NOT NULL COMMENT 'Departamento responsable del proyecto, referencia a dept',
  strt_dt DATE NOT NULL COMMENT 'Fecha de inicio del proyecto (strt_dt = start date)',
  end_dt DATE NULL COMMENT 'Fecha de finalización; NULL si no ha terminado (end_dt = end date)',
  bdgt_amt DECIMAL(12,2) NOT NULL COMMENT 'Presupuesto asignado al proyecto en USD (bdgt_amt = budget amount)',
  stat ENUM('activo','completado','pausado','cancelado') NOT NULL COMMENT 'Estado del proyecto (stat = status)',
  PRIMARY KEY (proj_id),
  FOREIGN KEY (dept_id) REFERENCES dept (dept_id)
) COMMENT='Proyectos internos de la empresa (proj = project)';

CREATE TABLE emp_proj (
  emp_id INT NOT NULL COMMENT 'Empleado asignado, referencia a emp',
  proj_id INT NOT NULL COMMENT 'Proyecto al que se asigna, referencia a proj',
  role_nm VARCHAR(40) NOT NULL COMMENT 'Rol del empleado dentro del proyecto (role_nm = role name)',
  asgn_dt DATE NOT NULL COMMENT 'Fecha de asignación al proyecto (asgn_dt = assignment date)',
  hrs_wk DECIMAL(5,2) NOT NULL COMMENT 'Horas semanales dedicadas al proyecto (hrs_wk = hours per week)',
  PRIMARY KEY (emp_id, proj_id),
  FOREIGN KEY (emp_id) REFERENCES emp (emp_id),
  FOREIGN KEY (proj_id) REFERENCES proj (proj_id)
) COMMENT='Asignación de empleados a proyectos (emp_proj = employee-project)';

CREATE TABLE lv_req (
  lv_req_id INT NOT NULL COMMENT 'Identificador de la solicitud de ausencia (lv_req = leave request)',
  emp_id INT NOT NULL COMMENT 'Empleado que solicita la ausencia, referencia a emp',
  lv_typ ENUM('vacaciones','enfermedad','personal','maternidad') NOT NULL COMMENT 'Tipo de ausencia (lv_typ = leave type)',
  strt_dt DATE NOT NULL COMMENT 'Primer día de la ausencia (strt_dt = start date)',
  end_dt DATE NOT NULL COMMENT 'Último día de la ausencia (end_dt = end date)',
  req_ts DATETIME NOT NULL COMMENT 'Fecha y hora en que se registró la solicitud (req_ts = request timestamp)',
  is_aprv TINYINT(1) NULL COMMENT 'Aprobada: 1 sí, 0 rechazada, NULL pendiente (is_aprv = is approved)',
  PRIMARY KEY (lv_req_id),
  FOREIGN KEY (emp_id) REFERENCES emp (emp_id)
) COMMENT='Solicitudes de ausencia o permisos de los empleados (lv_req = leave request)';
