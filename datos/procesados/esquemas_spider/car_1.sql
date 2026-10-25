CREATE TABLE `car_makers` (
  `id` int NOT NULL,
  `maker` varchar(50) DEFAULT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  `country` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country` (`country`),
  CONSTRAINT `car_makers_ibfk_1` FOREIGN KEY (`country`) REFERENCES `countries` (`countryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `car_names` (
  `makeid` int NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `make` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`makeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cars_data` (
  `id` int NOT NULL,
  `mpg` varchar(50) DEFAULT NULL,
  `cylinders` int DEFAULT NULL,
  `edispl` double DEFAULT NULL,
  `horsepower` varchar(50) DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `accelerate` double DEFAULT NULL,
  `year` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `cars_data_ibfk_1` FOREIGN KEY (`id`) REFERENCES `car_names` (`makeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `continents` (
  `contid` int NOT NULL,
  `continent` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`contid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `countries` (
  `countryid` int NOT NULL,
  `countryname` varchar(50) DEFAULT NULL,
  `continent` int DEFAULT NULL,
  PRIMARY KEY (`countryid`),
  KEY `continent` (`continent`),
  CONSTRAINT `countries_ibfk_1` FOREIGN KEY (`continent`) REFERENCES `continents` (`contid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `model_list` (
  `modelid` int NOT NULL,
  `maker` int DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`modelid`),
  KEY `maker` (`maker`),
  CONSTRAINT `model_list_ibfk_1` FOREIGN KEY (`maker`) REFERENCES `car_makers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
