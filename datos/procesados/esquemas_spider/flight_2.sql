CREATE TABLE `airlines` (
  `uid` int NOT NULL,
  `airline` varchar(50) DEFAULT NULL,
  `abbreviation` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `airports` (
  `city` varchar(50) DEFAULT NULL,
  `airportcode` varchar(50) NOT NULL,
  `airportname` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `countryabbrev` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`airportcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `flights` (
  `airline` int NOT NULL,
  `flightno` int NOT NULL,
  `sourceairport` varchar(50) DEFAULT NULL,
  `destairport` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`airline`,`flightno`),
  KEY `destairport` (`destairport`),
  KEY `sourceairport` (`sourceairport`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`destairport`) REFERENCES `airports` (`airportcode`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`sourceairport`) REFERENCES `airports` (`airportcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
