CREATE TABLE `city` (
  `city_id` int NOT NULL,
  `county_id` int DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `white` double DEFAULT NULL,
  `black` double DEFAULT NULL,
  `amerindian` double DEFAULT NULL,
  `asian` double DEFAULT NULL,
  `multiracial` double DEFAULT NULL,
  `hispanic` double DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  KEY `county_id` (`county_id`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`county_id`) REFERENCES `county_public_safety` (`county_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `county_public_safety` (
  `county_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `population` int DEFAULT NULL,
  `police_officers` int DEFAULT NULL,
  `residents_per_officer` int DEFAULT NULL,
  `case_burden` int DEFAULT NULL,
  `crime_rate` double DEFAULT NULL,
  `police_force` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`county_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
