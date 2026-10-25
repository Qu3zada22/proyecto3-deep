CREATE TABLE `furniture` (
  `furniture_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `num_of_component` int DEFAULT NULL,
  `market_rate` double DEFAULT NULL,
  PRIMARY KEY (`furniture_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `furniture_manufacte` (
  `manufacturer_id` int NOT NULL,
  `furniture_id` int NOT NULL,
  `price_in_dollar` double DEFAULT NULL,
  PRIMARY KEY (`manufacturer_id`,`furniture_id`),
  KEY `furniture_id` (`furniture_id`),
  CONSTRAINT `furniture_manufacte_ibfk_1` FOREIGN KEY (`furniture_id`) REFERENCES `furniture` (`furniture_id`),
  CONSTRAINT `furniture_manufacte_ibfk_2` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`manufacturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `manufacturer` (
  `manufacturer_id` int NOT NULL,
  `open_year` double DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `num_of_factories` int DEFAULT NULL,
  `num_of_shops` int DEFAULT NULL,
  PRIMARY KEY (`manufacturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
