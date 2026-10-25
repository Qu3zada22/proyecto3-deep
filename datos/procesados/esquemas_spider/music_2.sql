CREATE TABLE `albums` (
  `aid` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `band` (
  `id` int NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `instruments` (
  `songid` int NOT NULL,
  `bandmateid` int NOT NULL,
  `instrument` varchar(50) NOT NULL,
  PRIMARY KEY (`songid`,`bandmateid`,`instrument`),
  KEY `bandmateid` (`bandmateid`),
  CONSTRAINT `instruments_ibfk_1` FOREIGN KEY (`bandmateid`) REFERENCES `band` (`id`),
  CONSTRAINT `instruments_ibfk_2` FOREIGN KEY (`songid`) REFERENCES `songs` (`songid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `performance` (
  `songid` int NOT NULL,
  `bandmate` int NOT NULL,
  `stageposition` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`songid`,`bandmate`),
  KEY `bandmate` (`bandmate`),
  CONSTRAINT `performance_ibfk_1` FOREIGN KEY (`bandmate`) REFERENCES `band` (`id`),
  CONSTRAINT `performance_ibfk_2` FOREIGN KEY (`songid`) REFERENCES `songs` (`songid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `songs` (
  `songid` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`songid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tracklists` (
  `albumid` int NOT NULL,
  `position` int NOT NULL,
  `songid` int DEFAULT NULL,
  PRIMARY KEY (`albumid`,`position`),
  KEY `songid` (`songid`),
  CONSTRAINT `tracklists_ibfk_1` FOREIGN KEY (`albumid`) REFERENCES `albums` (`aid`),
  CONSTRAINT `tracklists_ibfk_2` FOREIGN KEY (`songid`) REFERENCES `songs` (`songid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `vocals` (
  `songid` int NOT NULL,
  `bandmate` int NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`songid`,`bandmate`),
  KEY `bandmate` (`bandmate`),
  CONSTRAINT `vocals_ibfk_1` FOREIGN KEY (`bandmate`) REFERENCES `band` (`id`),
  CONSTRAINT `vocals_ibfk_2` FOREIGN KEY (`songid`) REFERENCES `songs` (`songid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
