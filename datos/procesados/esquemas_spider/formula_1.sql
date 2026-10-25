CREATE TABLE `circuits` (
  `circuitid` int NOT NULL,
  `circuitref` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `alt` varchar(50) DEFAULT NULL,
  `url` varchar(71) DEFAULT NULL,
  PRIMARY KEY (`circuitid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `constructorresults` (
  `constructorresultsid` int NOT NULL,
  `raceid` int DEFAULT NULL,
  `constructorid` int DEFAULT NULL,
  `points` double DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`constructorresultsid`),
  KEY `raceid` (`raceid`),
  KEY `constructorid` (`constructorid`),
  CONSTRAINT `constructorresults_ibfk_1` FOREIGN KEY (`raceid`) REFERENCES `races` (`raceid`),
  CONSTRAINT `constructorresults_ibfk_2` FOREIGN KEY (`constructorid`) REFERENCES `constructors` (`constructorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `constructors` (
  `constructorid` int NOT NULL,
  `constructorref` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `url` varchar(73) DEFAULT NULL,
  PRIMARY KEY (`constructorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `constructorstandings` (
  `constructorstandingsid` int NOT NULL,
  `raceid` int DEFAULT NULL,
  `constructorid` int DEFAULT NULL,
  `points` double DEFAULT NULL,
  `position` int DEFAULT NULL,
  `positiontext` varchar(50) DEFAULT NULL,
  `wins` int DEFAULT NULL,
  PRIMARY KEY (`constructorstandingsid`),
  KEY `raceid` (`raceid`),
  KEY `constructorid` (`constructorid`),
  CONSTRAINT `constructorstandings_ibfk_1` FOREIGN KEY (`raceid`) REFERENCES `races` (`raceid`),
  CONSTRAINT `constructorstandings_ibfk_2` FOREIGN KEY (`constructorid`) REFERENCES `constructors` (`constructorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `drivers` (
  `driverid` int NOT NULL,
  `driverref` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `forename` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `dob` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `url` varchar(65) DEFAULT NULL,
  PRIMARY KEY (`driverid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `driverstandings` (
  `driverstandingsid` int NOT NULL,
  `raceid` int DEFAULT NULL,
  `driverid` int DEFAULT NULL,
  `points` double DEFAULT NULL,
  `position` int DEFAULT NULL,
  `positiontext` varchar(50) DEFAULT NULL,
  `wins` int DEFAULT NULL,
  PRIMARY KEY (`driverstandingsid`),
  KEY `driverid` (`driverid`),
  KEY `raceid` (`raceid`),
  CONSTRAINT `driverstandings_ibfk_1` FOREIGN KEY (`driverid`) REFERENCES `drivers` (`driverid`),
  CONSTRAINT `driverstandings_ibfk_2` FOREIGN KEY (`raceid`) REFERENCES `races` (`raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `laptimes` (
  `raceid` int NOT NULL,
  `driverid` int NOT NULL,
  `lap` int NOT NULL,
  `position` int DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `milliseconds` int DEFAULT NULL,
  PRIMARY KEY (`raceid`,`driverid`,`lap`),
  KEY `driverid` (`driverid`),
  CONSTRAINT `laptimes_ibfk_1` FOREIGN KEY (`driverid`) REFERENCES `drivers` (`driverid`),
  CONSTRAINT `laptimes_ibfk_2` FOREIGN KEY (`raceid`) REFERENCES `races` (`raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pitstops` (
  `raceid` int NOT NULL,
  `driverid` int NOT NULL,
  `stop` int NOT NULL,
  `lap` int DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `milliseconds` int DEFAULT NULL,
  PRIMARY KEY (`raceid`,`driverid`,`stop`),
  KEY `driverid` (`driverid`),
  CONSTRAINT `pitstops_ibfk_1` FOREIGN KEY (`driverid`) REFERENCES `drivers` (`driverid`),
  CONSTRAINT `pitstops_ibfk_2` FOREIGN KEY (`raceid`) REFERENCES `races` (`raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `qualifying` (
  `qualifyid` int NOT NULL,
  `raceid` int DEFAULT NULL,
  `driverid` int DEFAULT NULL,
  `constructorid` int DEFAULT NULL,
  `number` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  `q1` varchar(50) DEFAULT NULL,
  `q2` varchar(50) DEFAULT NULL,
  `q3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`qualifyid`),
  KEY `driverid` (`driverid`),
  KEY `raceid` (`raceid`),
  KEY `constructorid` (`constructorid`),
  CONSTRAINT `qualifying_ibfk_1` FOREIGN KEY (`driverid`) REFERENCES `drivers` (`driverid`),
  CONSTRAINT `qualifying_ibfk_2` FOREIGN KEY (`raceid`) REFERENCES `races` (`raceid`),
  CONSTRAINT `qualifying_ibfk_3` FOREIGN KEY (`constructorid`) REFERENCES `constructors` (`constructorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `races` (
  `raceid` int NOT NULL,
  `year` int DEFAULT NULL,
  `round` int DEFAULT NULL,
  `circuitid` int DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `url` varchar(63) DEFAULT NULL,
  PRIMARY KEY (`raceid`),
  KEY `circuitid` (`circuitid`),
  CONSTRAINT `races_ibfk_1` FOREIGN KEY (`circuitid`) REFERENCES `circuits` (`circuitid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `results` (
  `resultid` int NOT NULL,
  `raceid` int DEFAULT NULL,
  `driverid` int DEFAULT NULL,
  `constructorid` int DEFAULT NULL,
  `number` int DEFAULT NULL,
  `grid` int DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `positiontext` varchar(50) DEFAULT NULL,
  `positionorder` int DEFAULT NULL,
  `points` double DEFAULT NULL,
  `laps` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `milliseconds` varchar(50) DEFAULT NULL,
  `fastestlap` varchar(50) DEFAULT NULL,
  `rank` varchar(50) DEFAULT NULL,
  `fastestlaptime` varchar(50) DEFAULT NULL,
  `fastestlapspeed` varchar(50) DEFAULT NULL,
  `statusid` int DEFAULT NULL,
  PRIMARY KEY (`resultid`),
  KEY `driverid` (`driverid`),
  KEY `raceid` (`raceid`),
  KEY `constructorid` (`constructorid`),
  CONSTRAINT `results_ibfk_1` FOREIGN KEY (`driverid`) REFERENCES `drivers` (`driverid`),
  CONSTRAINT `results_ibfk_2` FOREIGN KEY (`raceid`) REFERENCES `races` (`raceid`),
  CONSTRAINT `results_ibfk_3` FOREIGN KEY (`constructorid`) REFERENCES `constructors` (`constructorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `seasons` (
  `year` int NOT NULL,
  `url` varchar(68) DEFAULT NULL,
  PRIMARY KEY (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `status` (
  `statusid` int NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`statusid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
