CREATE TABLE `aircraft` (
  `aid` decimal(9,0) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `distance` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `certificate` (
  `eid` decimal(9,0) NOT NULL,
  `aid` decimal(9,0) NOT NULL,
  PRIMARY KEY (`eid`,`aid`),
  KEY `aid` (`aid`),
  CONSTRAINT `certificate_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `aircraft` (`aid`),
  CONSTRAINT `certificate_ibfk_2` FOREIGN KEY (`eid`) REFERENCES `employee` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employee` (
  `eid` decimal(9,0) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `flight` (
  `flno` decimal(4,0) NOT NULL,
  `origin` varchar(20) DEFAULT NULL,
  `destination` varchar(20) DEFAULT NULL,
  `distance` decimal(6,0) DEFAULT NULL,
  `departure_date` varchar(50) DEFAULT NULL,
  `arrival_date` varchar(50) DEFAULT NULL,
  `price` decimal(7,2) DEFAULT NULL,
  `aid` decimal(9,0) DEFAULT NULL,
  PRIMARY KEY (`flno`),
  KEY `aid` (`aid`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `aircraft` (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
