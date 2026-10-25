CREATE TABLE prod (
  prod_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del productor asociado',
  nom VARCHAR(60) NOT NULL COMMENT 'Nombre del productor',
  ape VARCHAR(60) NOT NULL COMMENT 'Apellido del productor',
  sexo CHAR(1) NOT NULL COMMENT 'Sexo del productor (F o M)',
  muni VARCHAR(60) NOT NULL COMMENT 'Municipio de residencia',
  fec_ing DATE NOT NULL COMMENT 'Fecha de ingreso a la cooperativa',
  activo TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Indica si el productor sigue activo (1 = sí, 0 = no)',
  PRIMARY KEY (prod_id)
) COMMENT='Productores de café asociados a la cooperativa';

CREATE TABLE fca (
  fca_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la finca',
  prod_id INT NOT NULL COMMENT 'Productor dueño de la finca',
  nom_fca VARCHAR(80) NOT NULL COMMENT 'Nombre de la finca',
  depto VARCHAR(40) NOT NULL COMMENT 'Departamento donde está la finca',
  alt_msnm SMALLINT NOT NULL COMMENT 'Altitud de la finca en metros sobre el nivel del mar',
  area_mz DECIMAL(6,2) NOT NULL COMMENT 'Área sembrada de café en manzanas',
  cert ENUM('ninguna','organica','comercio_justo','rainforest') NOT NULL DEFAULT 'ninguna' COMMENT 'Certificación de la finca',
  PRIMARY KEY (fca_id),
  FOREIGN KEY (prod_id) REFERENCES prod(prod_id)
) COMMENT='Fincas cafetaleras de los productores';

CREATE TABLE var (
  var_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la variedad',
  nom_var VARCHAR(40) NOT NULL COMMENT 'Nombre de la variedad de café (Bourbon, Caturra, etc.)',
  resist_roya TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica si la variedad es resistente a la roya (1 = sí, 0 = no)',
  PRIMARY KEY (var_id)
) COMMENT='Variedades de café cultivadas';

CREATE TABLE lot (
  lot_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del lote de cosecha',
  fca_id INT NOT NULL COMMENT 'Finca de donde proviene el lote',
  var_id INT NOT NULL COMMENT 'Variedad del lote',
  fec_cos DATE NOT NULL COMMENT 'Fecha de cosecha (entrega del café en cereza)',
  kg_cer DECIMAL(10,2) NOT NULL COMMENT 'Kilogramos de café en cereza recibidos',
  kg_perg DECIMAL(10,2) NULL COMMENT 'Kilogramos de café pergamino seco obtenidos; NULL si aún no se ha secado',
  proc ENUM('lavado','natural','honey') NOT NULL COMMENT 'Proceso de beneficio aplicado',
  PRIMARY KEY (lot_id),
  FOREIGN KEY (fca_id) REFERENCES fca(fca_id),
  FOREIGN KEY (var_id) REFERENCES var(var_id)
) COMMENT='Lotes de café cosechados y entregados a la cooperativa';

CREATE TABLE cat (
  cat_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la catación',
  lot_id INT NOT NULL COMMENT 'Lote catado',
  fec_cat DATE NOT NULL COMMENT 'Fecha de la catación',
  pts DECIMAL(5,2) NOT NULL COMMENT 'Puntaje SCA de la taza (0 a 100); 80 o más es café de especialidad',
  catador VARCHAR(80) NOT NULL COMMENT 'Nombre del catador',
  PRIMARY KEY (cat_id),
  FOREIGN KEY (lot_id) REFERENCES lot(lot_id)
) COMMENT='Catación (evaluación de calidad en taza) de los lotes; un lote puede catarse más de una vez';

CREATE TABLE cli (
  cli_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del cliente',
  nom_cli VARCHAR(100) NOT NULL COMMENT 'Nombre o razón social del cliente',
  pais VARCHAR(60) NOT NULL COMMENT 'País del cliente',
  tipo ENUM('importador','tostador','cafeteria') NOT NULL COMMENT 'Tipo de cliente',
  PRIMARY KEY (cli_id)
) COMMENT='Clientes compradores de café';

CREATE TABLE vta (
  vta_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la venta (contrato)',
  cli_id INT NOT NULL COMMENT 'Cliente comprador',
  fec_vta DATE NOT NULL COMMENT 'Fecha de la venta',
  estado ENUM('pendiente','enviada','pagada') NOT NULL COMMENT 'Estado de la venta',
  PRIMARY KEY (vta_id),
  FOREIGN KEY (cli_id) REFERENCES cli(cli_id)
) COMMENT='Ventas (contratos) de café a clientes';

CREATE TABLE vta_det (
  det_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la línea de venta',
  vta_id INT NOT NULL COMMENT 'Venta a la que pertenece la línea',
  lot_id INT NOT NULL COMMENT 'Lote vendido',
  qq DECIMAL(8,2) NOT NULL COMMENT 'Quintales de café oro vendidos',
  prec_qq DECIMAL(10,2) NOT NULL COMMENT 'Precio por quintal en dólares',
  PRIMARY KEY (det_id),
  FOREIGN KEY (vta_id) REFERENCES vta(vta_id),
  FOREIGN KEY (lot_id) REFERENCES lot(lot_id)
) COMMENT='Detalle de cada venta: qué lotes se vendieron, cuántos quintales y a qué precio';

CREATE TABLE antc (
  antc_id INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador del anticipo',
  prod_id INT NOT NULL COMMENT 'Productor que recibió el anticipo',
  fec_antc DATE NOT NULL COMMENT 'Fecha en que se entregó el anticipo',
  monto DECIMAL(10,2) NOT NULL COMMENT 'Monto del anticipo en quetzales',
  pagado TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica si el productor ya devolvió el anticipo (1 = sí, 0 = no)',
  PRIMARY KEY (antc_id),
  FOREIGN KEY (prod_id) REFERENCES prod(prod_id)
) COMMENT='Anticipos (préstamos a cuenta de cosecha) entregados a los productores';
