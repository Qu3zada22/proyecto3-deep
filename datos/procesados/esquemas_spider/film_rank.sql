CREATE TABLE `film` (
  `film_id` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `studio` varchar(50) DEFAULT NULL,
  `director` varchar(50) DEFAULT NULL,
  `gross_in_dollar` int DEFAULT NULL,
  PRIMARY KEY (`film_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `film_market_estimation` (
  `estimation_id` int NOT NULL,
  `low_estimate` double DEFAULT NULL,
  `high_estimate` double DEFAULT NULL,
  `film_id` int DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `market_id` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  PRIMARY KEY (`estimation_id`),
  KEY `market_id` (`market_id`),
  KEY `film_id` (`film_id`),
  CONSTRAINT `film_market_estimation_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`market_id`),
  CONSTRAINT `film_market_estimation_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `market` (
  `market_id` int NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `number_cities` int DEFAULT NULL,
  PRIMARY KEY (`market_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
