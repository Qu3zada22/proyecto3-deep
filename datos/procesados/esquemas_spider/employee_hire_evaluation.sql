CREATE TABLE `employee` (
  `employee_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `evaluation` (
  `employee_id` int NOT NULL,
  `year_awarded` varchar(50) NOT NULL,
  `bonus` double DEFAULT NULL,
  PRIMARY KEY (`employee_id`,`year_awarded`),
  CONSTRAINT `evaluation_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `hiring` (
  `shop_id` int DEFAULT NULL,
  `employee_id` int NOT NULL,
  `start_from` varchar(50) DEFAULT NULL,
  `is_full_time` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `shop_id` (`shop_id`),
  CONSTRAINT `hiring_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `hiring_ibfk_2` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `shop` (
  `shop_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `number_products` int DEFAULT NULL,
  `manager_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
