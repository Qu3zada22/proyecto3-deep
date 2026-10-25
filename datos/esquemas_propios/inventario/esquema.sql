CREATE TABLE cat_art (
  id_cat INT NOT NULL COMMENT 'Identificador de la categoría de artículo (cat = categoría, art = artículo)',
  nom_cat VARCHAR(60) NOT NULL COMMENT 'Nombre de la categoría (nom = nombre)',
  desc_cat VARCHAR(200) NULL COMMENT 'Descripción de la categoría (desc = descripción)',
  PRIMARY KEY (id_cat)
) COMMENT='Categorías de artículos (cat_art = categoría de artículo)';

CREATE TABLE prov (
  id_prov INT NOT NULL COMMENT 'Identificador del proveedor (prov = proveedor)',
  nom_prov VARCHAR(100) NOT NULL COMMENT 'Nombre o razón social del proveedor',
  nit_prov VARCHAR(15) NOT NULL COMMENT 'NIT (número de identificación tributaria) del proveedor',
  tel_prov VARCHAR(20) NULL COMMENT 'Teléfono del proveedor (tel = teléfono)',
  eml_prov VARCHAR(100) NULL COMMENT 'Correo electrónico del proveedor (eml = email)',
  ciu_prov VARCHAR(60) NOT NULL COMMENT 'Ciudad del proveedor (ciu = ciudad)',
  fec_alta DATE NOT NULL COMMENT 'Fecha de alta o registro del proveedor (fec = fecha)',
  act TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Proveedor activo: 1 = sí, 0 = no (act = activo)',
  PRIMARY KEY (id_prov)
) COMMENT='Proveedores de mercadería (prov = proveedor)';

CREATE TABLE alm (
  id_alm INT NOT NULL COMMENT 'Identificador del almacén (alm = almacén)',
  nom_alm VARCHAR(60) NOT NULL COMMENT 'Nombre del almacén',
  ciu_alm VARCHAR(60) NOT NULL COMMENT 'Ciudad donde está el almacén (ciu = ciudad)',
  cap_m3 DECIMAL(10,2) NOT NULL COMMENT 'Capacidad del almacén en metros cúbicos (cap = capacidad)',
  resp_alm VARCHAR(100) NULL COMMENT 'Nombre del responsable del almacén (resp = responsable); NULL si no hay asignado',
  PRIMARY KEY (id_alm)
) COMMENT='Almacenes o bodegas de la empresa (alm = almacén)';

CREATE TABLE emp (
  id_emp INT NOT NULL COMMENT 'Identificador del empleado (emp = empleado)',
  nom_emp VARCHAR(60) NOT NULL COMMENT 'Nombre del empleado',
  ape_emp VARCHAR(60) NOT NULL COMMENT 'Apellido del empleado (ape = apellido)',
  crg_emp ENUM('BOD','COMP','SUP','GER') NOT NULL COMMENT 'Cargo (crg): BOD = bodeguero, COMP = comprador, SUP = supervisor, GER = gerente',
  id_alm INT NOT NULL COMMENT 'Almacén donde trabaja el empleado',
  fec_ing DATE NOT NULL COMMENT 'Fecha de ingreso a la empresa (fec = fecha, ing = ingreso)',
  sal_emp DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual del empleado en quetzales (sal = salario)',
  PRIMARY KEY (id_emp),
  FOREIGN KEY (id_alm) REFERENCES alm(id_alm)
) COMMENT='Empleados del área de almacén y compras (emp = empleado)';

CREATE TABLE art (
  id_art INT NOT NULL COMMENT 'Identificador del artículo (art = artículo)',
  cod_art VARCHAR(20) NOT NULL COMMENT 'Código interno o SKU del artículo (cod = código)',
  nom_art VARCHAR(100) NOT NULL COMMENT 'Nombre o descripción corta del artículo',
  id_cat INT NOT NULL COMMENT 'Categoría del artículo (referencia a cat_art)',
  id_prov INT NOT NULL COMMENT 'Proveedor principal del artículo (referencia a prov)',
  um ENUM('UND','KG','LT','CJ','MT') NOT NULL COMMENT 'Unidad de medida (um): UND = unidad, KG = kilogramo, LT = litro, CJ = caja, MT = metro',
  pu DECIMAL(10,2) NOT NULL COMMENT 'Precio unitario de costo en quetzales (pu = precio unitario)',
  pv DECIMAL(10,2) NOT NULL COMMENT 'Precio de venta unitario en quetzales (pv = precio de venta)',
  stk_min INT NOT NULL COMMENT 'Stock mínimo antes de reordenar (stk = stock, min = mínimo)',
  act TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Artículo activo: 1 = sí, 0 = descontinuado (act = activo)',
  PRIMARY KEY (id_art),
  FOREIGN KEY (id_cat) REFERENCES cat_art(id_cat),
  FOREIGN KEY (id_prov) REFERENCES prov(id_prov)
) COMMENT='Catálogo de artículos (art = artículo)';

CREATE TABLE oc (
  id_oc INT NOT NULL COMMENT 'Identificador de la orden de compra (oc = orden de compra)',
  num_oc VARCHAR(15) NOT NULL COMMENT 'Número correlativo visible de la orden de compra',
  id_prov INT NOT NULL COMMENT 'Proveedor al que se le compra',
  id_emp INT NOT NULL COMMENT 'Empleado que emitió la orden de compra',
  id_alm INT NOT NULL COMMENT 'Almacén de destino de la mercadería',
  fec_oc DATE NOT NULL COMMENT 'Fecha de emisión de la orden de compra',
  fec_ent_est DATE NOT NULL COMMENT 'Fecha de entrega estimada (ent = entrega, est = estimada)',
  fec_ent_real DATE NULL COMMENT 'Fecha de entrega real; NULL si aún no se recibe',
  est_oc ENUM('PEND','APROB','RECIB','CANC') NOT NULL COMMENT 'Estado (est): PEND = pendiente, APROB = aprobada, RECIB = recibida, CANC = cancelada',
  obs_oc VARCHAR(200) NULL COMMENT 'Observaciones de la orden de compra (obs = observaciones)',
  PRIMARY KEY (id_oc),
  FOREIGN KEY (id_prov) REFERENCES prov(id_prov),
  FOREIGN KEY (id_emp) REFERENCES emp(id_emp),
  FOREIGN KEY (id_alm) REFERENCES alm(id_alm)
) COMMENT='Órdenes de compra a proveedores (oc = orden de compra)';

CREATE TABLE oc_det (
  id_det INT NOT NULL COMMENT 'Identificador de la línea de detalle (det = detalle)',
  id_oc INT NOT NULL COMMENT 'Orden de compra a la que pertenece la línea',
  id_art INT NOT NULL COMMENT 'Artículo comprado',
  cant INT NOT NULL COMMENT 'Cantidad pedida (cant = cantidad)',
  pu DECIMAL(10,2) NOT NULL COMMENT 'Precio unitario pactado en la compra (pu = precio unitario)',
  dsc_pct DECIMAL(5,2) NOT NULL DEFAULT 0 COMMENT 'Porcentaje de descuento aplicado a la línea (dsc = descuento, pct = porcentaje)',
  PRIMARY KEY (id_det),
  FOREIGN KEY (id_oc) REFERENCES oc(id_oc),
  FOREIGN KEY (id_art) REFERENCES art(id_art)
) COMMENT='Detalle o líneas de las órdenes de compra (oc_det = detalle de orden de compra)';

CREATE TABLE mov_inv (
  id_mov INT NOT NULL COMMENT 'Identificador del movimiento (mov = movimiento)',
  id_art INT NOT NULL COMMENT 'Artículo movido',
  id_alm INT NOT NULL COMMENT 'Almacén donde ocurre el movimiento',
  tp_mov ENUM('ENT','SAL','AJU') NOT NULL COMMENT 'Tipo de movimiento (tp = tipo): ENT = entrada, SAL = salida, AJU = ajuste',
  cant INT NOT NULL COMMENT 'Cantidad movida (cant = cantidad); en ajustes puede ser negativa',
  fec_mov DATETIME NOT NULL COMMENT 'Fecha y hora del movimiento',
  id_oc INT NULL COMMENT 'Orden de compra que originó la entrada; NULL si no aplica',
  id_emp INT NOT NULL COMMENT 'Empleado que registró el movimiento',
  ref_mov VARCHAR(100) NULL COMMENT 'Referencia o comentario del movimiento (ref = referencia)',
  PRIMARY KEY (id_mov),
  FOREIGN KEY (id_art) REFERENCES art(id_art),
  FOREIGN KEY (id_alm) REFERENCES alm(id_alm),
  FOREIGN KEY (id_oc) REFERENCES oc(id_oc),
  FOREIGN KEY (id_emp) REFERENCES emp(id_emp)
) COMMENT='Movimientos de inventario (mov_inv = movimiento de inventario)';

CREATE TABLE stk (
  id_art INT NOT NULL COMMENT 'Artículo (referencia a art)',
  id_alm INT NOT NULL COMMENT 'Almacén (referencia a alm)',
  cant_act INT NOT NULL COMMENT 'Cantidad actual en existencia (cant = cantidad, act = actual)',
  fec_ult_cnt DATE NULL COMMENT 'Fecha del último conteo físico (ult = último, cnt = conteo); NULL si nunca se ha contado',
  PRIMARY KEY (id_art, id_alm),
  FOREIGN KEY (id_art) REFERENCES art(id_art),
  FOREIGN KEY (id_alm) REFERENCES alm(id_alm)
) COMMENT='Existencias actuales por artículo y almacén (stk = stock)';
