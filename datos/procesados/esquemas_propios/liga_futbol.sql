CREATE TABLE `arbitros` (
  `id_arbitro` int NOT NULL COMMENT 'Identificador único del árbitro',
  `nombre_arbitro` varchar(60) NOT NULL COMMENT 'Nombre del árbitro',
  `apellido_arbitro` varchar(60) NOT NULL COMMENT 'Apellido del árbitro',
  `fecha_nacimiento` date NOT NULL COMMENT 'Fecha de nacimiento del árbitro',
  `categoria` enum('internacional','nacional','regional') NOT NULL COMMENT 'Categoría o nivel del árbitro',
  `anios_experiencia` int NOT NULL COMMENT 'Años de experiencia arbitrando',
  PRIMARY KEY (`id_arbitro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Árbitros que dirigen los partidos de la liga';

CREATE TABLE `equipos` (
  `id_equipo` int NOT NULL COMMENT 'Identificador único del equipo',
  `nombre_equipo` varchar(100) NOT NULL COMMENT 'Nombre del club de fútbol',
  `ciudad` varchar(60) NOT NULL COMMENT 'Ciudad de origen del equipo',
  `fecha_fundacion` date DEFAULT NULL COMMENT 'Fecha de fundación del club',
  `id_estadio` int NOT NULL COMMENT 'Estadio donde el equipo juega como local',
  `presupuesto_anual` decimal(12,2) NOT NULL COMMENT 'Presupuesto anual del club en dólares',
  `entrenador` varchar(100) DEFAULT NULL COMMENT 'Nombre completo del entrenador actual',
  PRIMARY KEY (`id_equipo`),
  KEY `id_estadio` (`id_estadio`),
  CONSTRAINT `equipos_ibfk_1` FOREIGN KEY (`id_estadio`) REFERENCES `estadios` (`id_estadio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Equipos (clubes) que participan en la liga';

CREATE TABLE `estadios` (
  `id_estadio` int NOT NULL COMMENT 'Identificador único del estadio',
  `nombre_estadio` varchar(100) NOT NULL COMMENT 'Nombre oficial del estadio',
  `ciudad` varchar(60) NOT NULL COMMENT 'Ciudad donde se ubica el estadio',
  `capacidad` int NOT NULL COMMENT 'Número máximo de espectadores sentados',
  `anio_inauguracion` int DEFAULT NULL COMMENT 'Año en que se inauguró el estadio',
  `tiene_techo` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 si el estadio tiene techo cubierto, 0 si no',
  PRIMARY KEY (`id_estadio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Estadios donde se disputan los partidos de la liga';

CREATE TABLE `goles` (
  `id_gol` int NOT NULL COMMENT 'Identificador único del gol',
  `id_partido` int NOT NULL COMMENT 'Partido en el que se anotó el gol',
  `id_jugador` int NOT NULL COMMENT 'Jugador que anotó el gol',
  `id_equipo` int NOT NULL COMMENT 'Equipo al que se le contabiliza el gol',
  `minuto` int NOT NULL COMMENT 'Minuto del partido en que se anotó el gol',
  `tipo_gol` enum('jugada','penal','cabeza','tiro_libre','autogol') NOT NULL COMMENT 'Forma en que se anotó el gol',
  `id_jugador_asistencia` int DEFAULT NULL COMMENT 'Jugador que dio la asistencia; NULL si no hubo',
  PRIMARY KEY (`id_gol`),
  KEY `id_partido` (`id_partido`),
  KEY `id_jugador` (`id_jugador`),
  KEY `id_equipo` (`id_equipo`),
  KEY `id_jugador_asistencia` (`id_jugador_asistencia`),
  CONSTRAINT `goles_ibfk_1` FOREIGN KEY (`id_partido`) REFERENCES `partidos` (`id_partido`),
  CONSTRAINT `goles_ibfk_2` FOREIGN KEY (`id_jugador`) REFERENCES `jugadores` (`id_jugador`),
  CONSTRAINT `goles_ibfk_3` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`),
  CONSTRAINT `goles_ibfk_4` FOREIGN KEY (`id_jugador_asistencia`) REFERENCES `jugadores` (`id_jugador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Goles anotados en cada partido';

CREATE TABLE `jugadores` (
  `id_jugador` int NOT NULL COMMENT 'Identificador único del jugador',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre de pila del jugador',
  `apellido` varchar(60) NOT NULL COMMENT 'Apellido del jugador',
  `fecha_nacimiento` date NOT NULL COMMENT 'Fecha de nacimiento del jugador',
  `nacionalidad` varchar(40) NOT NULL COMMENT 'País de nacionalidad del jugador',
  `posicion` enum('portero','defensa','centrocampista','delantero') NOT NULL COMMENT 'Posición en la que juega',
  `dorsal` int DEFAULT NULL COMMENT 'Número de camiseta del jugador',
  `id_equipo` int DEFAULT NULL COMMENT 'Equipo actual del jugador; NULL si es agente libre',
  `salario_mensual` decimal(10,2) NOT NULL COMMENT 'Salario mensual del jugador en dólares',
  `fecha_fichaje` date DEFAULT NULL COMMENT 'Fecha en que el jugador fichó por su equipo actual',
  PRIMARY KEY (`id_jugador`),
  KEY `id_equipo` (`id_equipo`),
  CONSTRAINT `jugadores_ibfk_1` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Jugadores registrados en la liga';

CREATE TABLE `partidos` (
  `id_partido` int NOT NULL COMMENT 'Identificador único del partido',
  `id_temporada` int NOT NULL COMMENT 'Temporada a la que pertenece el partido',
  `jornada` int NOT NULL COMMENT 'Número de jornada dentro de la temporada',
  `fecha_hora` datetime NOT NULL COMMENT 'Fecha y hora de inicio del partido',
  `id_equipo_local` int NOT NULL COMMENT 'Equipo que juega como local',
  `id_equipo_visitante` int NOT NULL COMMENT 'Equipo que juega como visitante',
  `id_estadio` int NOT NULL COMMENT 'Estadio donde se juega el partido',
  `id_arbitro` int NOT NULL COMMENT 'Árbitro principal del partido',
  `goles_local` int DEFAULT NULL COMMENT 'Goles anotados por el equipo local; NULL si no se ha jugado',
  `goles_visitante` int DEFAULT NULL COMMENT 'Goles anotados por el equipo visitante; NULL si no se ha jugado',
  `asistencia` int DEFAULT NULL COMMENT 'Número de espectadores que asistieron; NULL si no se registró',
  `estado` enum('jugado','suspendido','programado') NOT NULL COMMENT 'Estado del partido',
  PRIMARY KEY (`id_partido`),
  KEY `id_temporada` (`id_temporada`),
  KEY `id_equipo_local` (`id_equipo_local`),
  KEY `id_equipo_visitante` (`id_equipo_visitante`),
  KEY `id_estadio` (`id_estadio`),
  KEY `id_arbitro` (`id_arbitro`),
  CONSTRAINT `partidos_ibfk_1` FOREIGN KEY (`id_temporada`) REFERENCES `temporadas` (`id_temporada`),
  CONSTRAINT `partidos_ibfk_2` FOREIGN KEY (`id_equipo_local`) REFERENCES `equipos` (`id_equipo`),
  CONSTRAINT `partidos_ibfk_3` FOREIGN KEY (`id_equipo_visitante`) REFERENCES `equipos` (`id_equipo`),
  CONSTRAINT `partidos_ibfk_4` FOREIGN KEY (`id_estadio`) REFERENCES `estadios` (`id_estadio`),
  CONSTRAINT `partidos_ibfk_5` FOREIGN KEY (`id_arbitro`) REFERENCES `arbitros` (`id_arbitro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Partidos disputados o programados en la liga';

CREATE TABLE `tarjetas` (
  `id_tarjeta` int NOT NULL COMMENT 'Identificador único de la tarjeta',
  `id_partido` int NOT NULL COMMENT 'Partido en el que se mostró la tarjeta',
  `id_jugador` int NOT NULL COMMENT 'Jugador amonestado o expulsado',
  `minuto` int NOT NULL COMMENT 'Minuto del partido en que se mostró la tarjeta',
  `color` enum('amarilla','roja') NOT NULL COMMENT 'Color de la tarjeta mostrada',
  `motivo` varchar(100) DEFAULT NULL COMMENT 'Motivo de la sanción; NULL si no se registró',
  PRIMARY KEY (`id_tarjeta`),
  KEY `id_partido` (`id_partido`),
  KEY `id_jugador` (`id_jugador`),
  CONSTRAINT `tarjetas_ibfk_1` FOREIGN KEY (`id_partido`) REFERENCES `partidos` (`id_partido`),
  CONSTRAINT `tarjetas_ibfk_2` FOREIGN KEY (`id_jugador`) REFERENCES `jugadores` (`id_jugador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tarjetas amarillas y rojas mostradas en los partidos';

CREATE TABLE `temporadas` (
  `id_temporada` int NOT NULL COMMENT 'Identificador único de la temporada',
  `nombre_temporada` varchar(20) NOT NULL COMMENT 'Nombre de la temporada, por ejemplo 2023-2024',
  `fecha_inicio` date NOT NULL COMMENT 'Fecha de inicio de la temporada',
  `fecha_fin` date NOT NULL COMMENT 'Fecha de finalización de la temporada',
  `id_equipo_campeon` int DEFAULT NULL COMMENT 'Equipo campeón de la temporada; NULL si aún no termina',
  PRIMARY KEY (`id_temporada`),
  KEY `id_equipo_campeon` (`id_equipo_campeon`),
  CONSTRAINT `temporadas_ibfk_1` FOREIGN KEY (`id_equipo_campeon`) REFERENCES `equipos` (`id_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Temporadas o torneos anuales de la liga';
