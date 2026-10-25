CREATE TABLE `company` (
  `company_id` double NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `headquarters` varchar(50) DEFAULT NULL,
  `industry` varchar(50) DEFAULT NULL,
  `sales_in_billion` double DEFAULT NULL,
  `profits_in_billion` double DEFAULT NULL,
  `assets_in_billion` double DEFAULT NULL,
  `market_value_in_billion` double DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employment` (
  `company_id` double NOT NULL,
  `people_id` int NOT NULL,
  `year_working` int DEFAULT NULL,
  PRIMARY KEY (`company_id`,`people_id`),
  KEY `people_id` (`people_id`),
  CONSTRAINT `employment_ibfk_1` FOREIGN KEY (`people_id`) REFERENCES `people` (`people_id`),
  CONSTRAINT `employment_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `people` (
  `people_id` int NOT NULL,
  `age` int DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `graduation_college` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
