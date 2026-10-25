CREATE TABLE `city` (
  `city_id` int NOT NULL,
  `official_name` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `area_km_2` double DEFAULT NULL,
  `population` double DEFAULT NULL,
  `census_ranking` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `competition_record` (
  `competition_id` int NOT NULL,
  `farm_id` int NOT NULL,
  `rank` int DEFAULT NULL,
  PRIMARY KEY (`competition_id`,`farm_id`),
  KEY `farm_id` (`farm_id`),
  CONSTRAINT `competition_record_ibfk_1` FOREIGN KEY (`farm_id`) REFERENCES `farm` (`farm_id`),
  CONSTRAINT `competition_record_ibfk_2` FOREIGN KEY (`competition_id`) REFERENCES `farm_competition` (`competition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `farm` (
  `farm_id` int NOT NULL,
  `year` int DEFAULT NULL,
  `total_horses` double DEFAULT NULL,
  `working_horses` double DEFAULT NULL,
  `total_cattle` double DEFAULT NULL,
  `oxen` double DEFAULT NULL,
  `bulls` double DEFAULT NULL,
  `cows` double DEFAULT NULL,
  `pigs` double DEFAULT NULL,
  `sheep_and_goats` double DEFAULT NULL,
  PRIMARY KEY (`farm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `farm_competition` (
  `competition_id` int NOT NULL,
  `year` int DEFAULT NULL,
  `theme` varchar(50) DEFAULT NULL,
  `host_city_id` int DEFAULT NULL,
  `hosts` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`competition_id`),
  KEY `host_city_id` (`host_city_id`),
  CONSTRAINT `farm_competition_ibfk_1` FOREIGN KEY (`host_city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
