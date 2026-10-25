CREATE TABLE `border_info` (
  `state_name` varchar(50) NOT NULL,
  `border` varchar(50) NOT NULL,
  PRIMARY KEY (`border`,`state_name`),
  KEY `state_name` (`state_name`),
  CONSTRAINT `border_info_ibfk_1` FOREIGN KEY (`border`) REFERENCES `state` (`state_name`),
  CONSTRAINT `border_info_ibfk_2` FOREIGN KEY (`state_name`) REFERENCES `state` (`state_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `city` (
  `city_name` varchar(50) NOT NULL,
  `population` int DEFAULT NULL,
  `country_name` varchar(3) DEFAULT NULL,
  `state_name` varchar(50) NOT NULL,
  PRIMARY KEY (`city_name`,`state_name`),
  KEY `state_name` (`state_name`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`state_name`) REFERENCES `state` (`state_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `highlow` (
  `state_name` varchar(50) NOT NULL,
  `highest_elevation` varchar(50) DEFAULT NULL,
  `lowest_point` varchar(50) DEFAULT NULL,
  `highest_point` varchar(50) DEFAULT NULL,
  `lowest_elevation` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`state_name`),
  CONSTRAINT `highlow_ibfk_1` FOREIGN KEY (`state_name`) REFERENCES `state` (`state_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `lake` (
  `lake_name` varchar(50) DEFAULT NULL,
  `area` double DEFAULT NULL,
  `country_name` varchar(3) DEFAULT NULL,
  `state_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mountain` (
  `mountain_name` varchar(50) NOT NULL,
  `mountain_altitude` int DEFAULT NULL,
  `country_name` varchar(3) DEFAULT NULL,
  `state_name` varchar(50) NOT NULL,
  PRIMARY KEY (`mountain_name`,`state_name`),
  KEY `state_name` (`state_name`),
  CONSTRAINT `mountain_ibfk_1` FOREIGN KEY (`state_name`) REFERENCES `state` (`state_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `river` (
  `river_name` varchar(50) NOT NULL,
  `length` int DEFAULT NULL,
  `country_name` varchar(3) DEFAULT NULL,
  `traverse` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`river_name`),
  KEY `traverse` (`traverse`),
  CONSTRAINT `river_ibfk_1` FOREIGN KEY (`traverse`) REFERENCES `state` (`state_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `state` (
  `state_name` varchar(50) NOT NULL,
  `population` int DEFAULT NULL,
  `area` double DEFAULT NULL,
  `country_name` varchar(3) DEFAULT NULL,
  `capital` varchar(50) DEFAULT NULL,
  `density` double DEFAULT NULL,
  PRIMARY KEY (`state_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
