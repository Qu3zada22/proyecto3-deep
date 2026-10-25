-- Esquema logistica: empresa de entregas con flota propia (nombres abreviados)
CREATE TABLE suc (
  suc_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la sucursal o centro de distribucion',
  nom_suc VARCHAR(80) NOT NULL COMMENT 'Nombre de la sucursal (nom = nombre)',
  ciudad VARCHAR(60) NOT NULL COMMENT 'Ciudad donde opera la sucursal',
  cap_veh INT NOT NULL COMMENT 'Capacidad maxima de vehiculos en el patio (cap = capacidad, veh = vehiculos)',
  fec_aper DATE NOT NULL COMMENT 'Fecha de apertura de la sucursal (fec = fecha, aper = apertura)',
  PRIMARY KEY (suc_id)
) COMMENT='Sucursales (suc) o centros de distribucion de la empresa';

CREATE TABLE cond (
  cond_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del conductor',
  nom_cond VARCHAR(60) NOT NULL COMMENT 'Nombre del conductor',
  ape_cond VARCHAR(60) NOT NULL COMMENT 'Apellido del conductor (ape = apellido)',
  lic_tipo ENUM('A','B','C') NOT NULL COMMENT 'Tipo de licencia de conducir (lic = licencia): A liviana, B mediana, C pesada',
  fec_ing DATE NOT NULL COMMENT 'Fecha de ingreso a la empresa (fec = fecha, ing = ingreso)',
  sal_men DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual en quetzales (sal = salario, men = mensual)',
  tel VARCHAR(20) NULL COMMENT 'Telefono de contacto (tel = telefono); puede ser nulo',
  suc_id INT NOT NULL COMMENT 'Sucursal a la que esta asignado el conductor (FK a suc)',
  act TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Indica si el conductor esta activo (act = activo): 1 si, 0 no',
  PRIMARY KEY (cond_id),
  CONSTRAINT fk_cond_suc FOREIGN KEY (suc_id) REFERENCES suc (suc_id)
) COMMENT='Conductores (cond) de la flota';

CREATE TABLE veh (
  veh_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del vehiculo',
  placa VARCHAR(10) NOT NULL COMMENT 'Numero de placa del vehiculo',
  marca VARCHAR(40) NOT NULL COMMENT 'Marca del vehiculo',
  modelo VARCHAR(40) NOT NULL COMMENT 'Modelo del vehiculo',
  anio INT NOT NULL COMMENT 'Anio de fabricacion del vehiculo',
  tipo_veh ENUM('moto','camioneta','furgon','camion') NOT NULL COMMENT 'Tipo de vehiculo (veh = vehiculo)',
  cap_kg DECIMAL(10,2) NOT NULL COMMENT 'Capacidad de carga en kilogramos (cap = capacidad)',
  km_act INT NOT NULL COMMENT 'Kilometraje actual del odometro (km = kilometros, act = actual)',
  suc_id INT NOT NULL COMMENT 'Sucursal a la que pertenece el vehiculo (FK a suc)',
  PRIMARY KEY (veh_id),
  UNIQUE KEY uq_veh_placa (placa),
  CONSTRAINT fk_veh_suc FOREIGN KEY (suc_id) REFERENCES suc (suc_id)
) COMMENT='Vehiculos (veh) de la flota';

CREATE TABLE cli (
  cli_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del cliente',
  nom_cli VARCHAR(100) NOT NULL COMMENT 'Nombre o razon social del cliente (nom = nombre, cli = cliente)',
  tipo_cli ENUM('persona','empresa') NOT NULL COMMENT 'Tipo de cliente: persona individual o empresa',
  ciudad VARCHAR(60) NOT NULL COMMENT 'Ciudad del cliente',
  email VARCHAR(100) NULL COMMENT 'Correo electronico del cliente; puede ser nulo',
  fec_reg DATE NOT NULL COMMENT 'Fecha de registro del cliente (fec = fecha, reg = registro)',
  PRIMARY KEY (cli_id)
) COMMENT='Clientes (cli) que contratan entregas';

CREATE TABLE rta (
  rta_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la ruta',
  cod_rta VARCHAR(10) NOT NULL COMMENT 'Codigo corto de la ruta (cod = codigo, rta = ruta)',
  orig VARCHAR(60) NOT NULL COMMENT 'Ciudad de origen de la ruta (orig = origen)',
  dest VARCHAR(60) NOT NULL COMMENT 'Ciudad de destino de la ruta (dest = destino)',
  dist_km DECIMAL(10,2) NOT NULL COMMENT 'Distancia de la ruta en kilometros (dist = distancia)',
  tpo_est_min INT NOT NULL COMMENT 'Tiempo estimado del recorrido en minutos (tpo = tiempo, est = estimado, min = minutos)',
  PRIMARY KEY (rta_id),
  UNIQUE KEY uq_rta_cod (cod_rta)
) COMMENT='Rutas (rta) predefinidas entre ciudades';

CREATE TABLE vje (
  vje_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del viaje (vje = viaje)',
  veh_id INT NOT NULL COMMENT 'Vehiculo usado en el viaje (FK a veh)',
  cond_id INT NOT NULL COMMENT 'Conductor que realizo el viaje (FK a cond)',
  rta_id INT NOT NULL COMMENT 'Ruta recorrida (FK a rta)',
  fec_sal DATETIME NOT NULL COMMENT 'Fecha y hora de salida (fec = fecha, sal = salida)',
  fec_lleg DATETIME NULL COMMENT 'Fecha y hora de llegada (lleg = llegada); nula si el viaje sigue en curso',
  km_rec DECIMAL(10,2) NULL COMMENT 'Kilometros recorridos realmente (km = kilometros, rec = recorridos); nulo si no ha terminado',
  cost_comb DECIMAL(10,2) NULL COMMENT 'Costo de combustible del viaje en quetzales (cost = costo, comb = combustible)',
  PRIMARY KEY (vje_id),
  CONSTRAINT fk_vje_veh FOREIGN KEY (veh_id) REFERENCES veh (veh_id),
  CONSTRAINT fk_vje_cond FOREIGN KEY (cond_id) REFERENCES cond (cond_id),
  CONSTRAINT fk_vje_rta FOREIGN KEY (rta_id) REFERENCES rta (rta_id)
) COMMENT='Viajes (vje) realizados por un vehiculo y un conductor sobre una ruta';

CREATE TABLE ent (
  ent_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la entrega (ent = entrega)',
  vje_id INT NOT NULL COMMENT 'Viaje en el que se transporta la entrega (FK a vje)',
  cli_id INT NOT NULL COMMENT 'Cliente destinatario o que paga la entrega (FK a cli)',
  fec_prom DATE NOT NULL COMMENT 'Fecha prometida de entrega (fec = fecha, prom = prometida)',
  fec_ent DATE NULL COMMENT 'Fecha real de entrega (ent = entrega); nula si aun no se entrega',
  peso_kg DECIMAL(10,2) NOT NULL COMMENT 'Peso del paquete en kilogramos',
  monto DECIMAL(10,2) NOT NULL COMMENT 'Monto cobrado por la entrega en quetzales',
  est_ent ENUM('pendiente','en_transito','entregada','devuelta','cancelada') NOT NULL COMMENT 'Estado de la entrega (est = estado, ent = entrega)',
  PRIMARY KEY (ent_id),
  CONSTRAINT fk_ent_vje FOREIGN KEY (vje_id) REFERENCES vje (vje_id),
  CONSTRAINT fk_ent_cli FOREIGN KEY (cli_id) REFERENCES cli (cli_id)
) COMMENT='Entregas (ent) o paquetes transportados para los clientes';

CREATE TABLE mant (
  mant_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del mantenimiento (mant = mantenimiento)',
  veh_id INT NOT NULL COMMENT 'Vehiculo atendido (FK a veh)',
  fec_mant DATE NOT NULL COMMENT 'Fecha del mantenimiento (fec = fecha)',
  tipo_mant ENUM('preventivo','correctivo','llantas','frenos') NOT NULL COMMENT 'Tipo de mantenimiento realizado',
  costo DECIMAL(10,2) NOT NULL COMMENT 'Costo del mantenimiento en quetzales',
  km_mant INT NOT NULL COMMENT 'Kilometraje del vehiculo al momento del mantenimiento',
  taller VARCHAR(80) NOT NULL COMMENT 'Nombre del taller que hizo el servicio',
  obs VARCHAR(200) NULL COMMENT 'Observaciones del servicio (obs = observaciones); puede ser nulo',
  PRIMARY KEY (mant_id),
  CONSTRAINT fk_mant_veh FOREIGN KEY (veh_id) REFERENCES veh (veh_id)
) COMMENT='Mantenimientos (mant) aplicados a los vehiculos';
