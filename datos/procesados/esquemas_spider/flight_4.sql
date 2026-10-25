CREATE TABLE `airlines` (
  `alid` int NOT NULL,
  `name` varchar(81) DEFAULT NULL,
  `iata` varchar(3) DEFAULT NULL,
  `icao` varchar(5) DEFAULT NULL,
  `callsign` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `active` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`alid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `airports` (
  `apid` int NOT NULL,
  `name` varchar(65) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `elevation` int DEFAULT NULL,
  `iata` varchar(4) DEFAULT NULL,
  `icao` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`apid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `routes` (
  `rid` int NOT NULL,
  `dst_apid` int DEFAULT NULL,
  `dst_ap` varchar(4) DEFAULT NULL,
  `src_apid` int DEFAULT NULL,
  `src_ap` varchar(4) DEFAULT NULL,
  `alid` int DEFAULT NULL,
  `airline` varchar(4) DEFAULT NULL,
  `codeshare` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rid`),
  KEY `alid` (`alid`),
  KEY `src_apid` (`src_apid`),
  KEY `dst_apid` (`dst_apid`),
  CONSTRAINT `routes_ibfk_1` FOREIGN KEY (`alid`) REFERENCES `airlines` (`alid`),
  CONSTRAINT `routes_ibfk_2` FOREIGN KEY (`src_apid`) REFERENCES `airports` (`apid`),
  CONSTRAINT `routes_ibfk_3` FOREIGN KEY (`dst_apid`) REFERENCES `airports` (`apid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
