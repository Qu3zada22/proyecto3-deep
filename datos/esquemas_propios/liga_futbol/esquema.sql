CREATE TABLE estadios (
  id_estadio INT NOT NULL COMMENT 'Identificador único del estadio',
  nombre_estadio VARCHAR(100) NOT NULL COMMENT 'Nombre oficial del estadio',
  ciudad VARCHAR(60) NOT NULL COMMENT 'Ciudad donde se ubica el estadio',
  capacidad INT NOT NULL COMMENT 'Número máximo de espectadores sentados',
  anio_inauguracion INT NULL COMMENT 'Año en que se inauguró el estadio',
  tiene_techo TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1 si el estadio tiene techo cubierto, 0 si no',
  PRIMARY KEY (id_estadio)
) COMMENT='Estadios donde se disputan los partidos de la liga';

CREATE TABLE equipos (
  id_equipo INT NOT NULL COMMENT 'Identificador único del equipo',
  nombre_equipo VARCHAR(100) NOT NULL COMMENT 'Nombre del club de fútbol',
  ciudad VARCHAR(60) NOT NULL COMMENT 'Ciudad de origen del equipo',
  fecha_fundacion DATE NULL COMMENT 'Fecha de fundación del club',
  id_estadio INT NOT NULL COMMENT 'Estadio donde el equipo juega como local',
  presupuesto_anual DECIMAL(12,2) NOT NULL COMMENT 'Presupuesto anual del club en dólares',
  entrenador VARCHAR(100) NULL COMMENT 'Nombre completo del entrenador actual',
  PRIMARY KEY (id_equipo),
  FOREIGN KEY (id_estadio) REFERENCES estadios(id_estadio)
) COMMENT='Equipos (clubes) que participan en la liga';

CREATE TABLE temporadas (
  id_temporada INT NOT NULL COMMENT 'Identificador único de la temporada',
  nombre_temporada VARCHAR(20) NOT NULL COMMENT 'Nombre de la temporada, por ejemplo 2023-2024',
  fecha_inicio DATE NOT NULL COMMENT 'Fecha de inicio de la temporada',
  fecha_fin DATE NOT NULL COMMENT 'Fecha de finalización de la temporada',
  id_equipo_campeon INT NULL COMMENT 'Equipo campeón de la temporada; NULL si aún no termina',
  PRIMARY KEY (id_temporada),
  FOREIGN KEY (id_equipo_campeon) REFERENCES equipos(id_equipo)
) COMMENT='Temporadas o torneos anuales de la liga';

CREATE TABLE jugadores (
  id_jugador INT NOT NULL COMMENT 'Identificador único del jugador',
  nombre VARCHAR(60) NOT NULL COMMENT 'Nombre de pila del jugador',
  apellido VARCHAR(60) NOT NULL COMMENT 'Apellido del jugador',
  fecha_nacimiento DATE NOT NULL COMMENT 'Fecha de nacimiento del jugador',
  nacionalidad VARCHAR(40) NOT NULL COMMENT 'País de nacionalidad del jugador',
  posicion ENUM('portero','defensa','centrocampista','delantero') NOT NULL COMMENT 'Posición en la que juega',
  dorsal INT NULL COMMENT 'Número de camiseta del jugador',
  id_equipo INT NULL COMMENT 'Equipo actual del jugador; NULL si es agente libre',
  salario_mensual DECIMAL(10,2) NOT NULL COMMENT 'Salario mensual del jugador en dólares',
  fecha_fichaje DATE NULL COMMENT 'Fecha en que el jugador fichó por su equipo actual',
  PRIMARY KEY (id_jugador),
  FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo)
) COMMENT='Jugadores registrados en la liga';

CREATE TABLE arbitros (
  id_arbitro INT NOT NULL COMMENT 'Identificador único del árbitro',
  nombre_arbitro VARCHAR(60) NOT NULL COMMENT 'Nombre del árbitro',
  apellido_arbitro VARCHAR(60) NOT NULL COMMENT 'Apellido del árbitro',
  fecha_nacimiento DATE NOT NULL COMMENT 'Fecha de nacimiento del árbitro',
  categoria ENUM('internacional','nacional','regional') NOT NULL COMMENT 'Categoría o nivel del árbitro',
  anios_experiencia INT NOT NULL COMMENT 'Años de experiencia arbitrando',
  PRIMARY KEY (id_arbitro)
) COMMENT='Árbitros que dirigen los partidos de la liga';

CREATE TABLE partidos (
  id_partido INT NOT NULL COMMENT 'Identificador único del partido',
  id_temporada INT NOT NULL COMMENT 'Temporada a la que pertenece el partido',
  jornada INT NOT NULL COMMENT 'Número de jornada dentro de la temporada',
  fecha_hora DATETIME NOT NULL COMMENT 'Fecha y hora de inicio del partido',
  id_equipo_local INT NOT NULL COMMENT 'Equipo que juega como local',
  id_equipo_visitante INT NOT NULL COMMENT 'Equipo que juega como visitante',
  id_estadio INT NOT NULL COMMENT 'Estadio donde se juega el partido',
  id_arbitro INT NOT NULL COMMENT 'Árbitro principal del partido',
  goles_local INT NULL COMMENT 'Goles anotados por el equipo local; NULL si no se ha jugado',
  goles_visitante INT NULL COMMENT 'Goles anotados por el equipo visitante; NULL si no se ha jugado',
  asistencia INT NULL COMMENT 'Número de espectadores que asistieron; NULL si no se registró',
  estado ENUM('jugado','suspendido','programado') NOT NULL COMMENT 'Estado del partido',
  PRIMARY KEY (id_partido),
  FOREIGN KEY (id_temporada) REFERENCES temporadas(id_temporada),
  FOREIGN KEY (id_equipo_local) REFERENCES equipos(id_equipo),
  FOREIGN KEY (id_equipo_visitante) REFERENCES equipos(id_equipo),
  FOREIGN KEY (id_estadio) REFERENCES estadios(id_estadio),
  FOREIGN KEY (id_arbitro) REFERENCES arbitros(id_arbitro)
) COMMENT='Partidos disputados o programados en la liga';

CREATE TABLE goles (
  id_gol INT NOT NULL COMMENT 'Identificador único del gol',
  id_partido INT NOT NULL COMMENT 'Partido en el que se anotó el gol',
  id_jugador INT NOT NULL COMMENT 'Jugador que anotó el gol',
  id_equipo INT NOT NULL COMMENT 'Equipo al que se le contabiliza el gol',
  minuto INT NOT NULL COMMENT 'Minuto del partido en que se anotó el gol',
  tipo_gol ENUM('jugada','penal','cabeza','tiro_libre','autogol') NOT NULL COMMENT 'Forma en que se anotó el gol',
  id_jugador_asistencia INT NULL COMMENT 'Jugador que dio la asistencia; NULL si no hubo',
  PRIMARY KEY (id_gol),
  FOREIGN KEY (id_partido) REFERENCES partidos(id_partido),
  FOREIGN KEY (id_jugador) REFERENCES jugadores(id_jugador),
  FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo),
  FOREIGN KEY (id_jugador_asistencia) REFERENCES jugadores(id_jugador)
) COMMENT='Goles anotados en cada partido';

CREATE TABLE tarjetas (
  id_tarjeta INT NOT NULL COMMENT 'Identificador único de la tarjeta',
  id_partido INT NOT NULL COMMENT 'Partido en el que se mostró la tarjeta',
  id_jugador INT NOT NULL COMMENT 'Jugador amonestado o expulsado',
  minuto INT NOT NULL COMMENT 'Minuto del partido en que se mostró la tarjeta',
  color ENUM('amarilla','roja') NOT NULL COMMENT 'Color de la tarjeta mostrada',
  motivo VARCHAR(100) NULL COMMENT 'Motivo de la sanción; NULL si no se registró',
  PRIMARY KEY (id_tarjeta),
  FOREIGN KEY (id_partido) REFERENCES partidos(id_partido),
  FOREIGN KEY (id_jugador) REFERENCES jugadores(id_jugador)
) COMMENT='Tarjetas amarillas y rojas mostradas en los partidos';
