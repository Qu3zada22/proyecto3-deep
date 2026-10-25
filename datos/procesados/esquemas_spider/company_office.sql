CREATE TABLE `buildings` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `height` int DEFAULT NULL,
  `stories` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `companies` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `headquarters` varchar(50) DEFAULT NULL,
  `industry` varchar(50) DEFAULT NULL,
  `sales_billion` double DEFAULT NULL,
  `profits_billion` double DEFAULT NULL,
  `assets_billion` double DEFAULT NULL,
  `market_value_billion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `office_locations` (
  `building_id` int NOT NULL,
  `company_id` int NOT NULL,
  `move_in_year` int DEFAULT NULL,
  PRIMARY KEY (`building_id`,`company_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `office_locations_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `office_locations_ibfk_2` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
