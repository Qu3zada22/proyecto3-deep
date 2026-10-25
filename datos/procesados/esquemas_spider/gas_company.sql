CREATE TABLE `company` (
  `company_id` int NOT NULL,
  `rank` int DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `headquarters` varchar(50) DEFAULT NULL,
  `main_industry` varchar(50) DEFAULT NULL,
  `sales_billion` double DEFAULT NULL,
  `profits_billion` double DEFAULT NULL,
  `assets_billion` double DEFAULT NULL,
  `market_value` double DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `gas_station` (
  `station_id` int NOT NULL,
  `open_year` int DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `manager_name` varchar(50) DEFAULT NULL,
  `vice_manager_name` varchar(50) DEFAULT NULL,
  `representative_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `station_company` (
  `station_id` int NOT NULL,
  `company_id` int NOT NULL,
  `rank_of_the_year` int DEFAULT NULL,
  PRIMARY KEY (`station_id`,`company_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `station_company_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`),
  CONSTRAINT `station_company_ibfk_2` FOREIGN KEY (`station_id`) REFERENCES `gas_station` (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
