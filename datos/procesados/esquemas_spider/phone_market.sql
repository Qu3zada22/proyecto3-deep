CREATE TABLE `market` (
  `market_id` int NOT NULL,
  `district` varchar(50) DEFAULT NULL,
  `num_of_employees` int DEFAULT NULL,
  `num_of_shops` double DEFAULT NULL,
  `ranking` int DEFAULT NULL,
  PRIMARY KEY (`market_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `phone` (
  `name` varchar(50) DEFAULT NULL,
  `phone_id` int NOT NULL,
  `memory_in_g` int DEFAULT NULL,
  `carrier` varchar(50) DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`phone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `phone_market` (
  `market_id` int NOT NULL,
  `phone_id` int NOT NULL,
  `num_of_stock` int DEFAULT NULL,
  PRIMARY KEY (`market_id`,`phone_id`),
  KEY `phone_id` (`phone_id`),
  CONSTRAINT `phone_market_ibfk_1` FOREIGN KEY (`phone_id`) REFERENCES `phone` (`phone_id`),
  CONSTRAINT `phone_market_ibfk_2` FOREIGN KEY (`market_id`) REFERENCES `market` (`market_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
