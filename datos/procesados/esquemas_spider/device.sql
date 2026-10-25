CREATE TABLE `device` (
  `device_id` int NOT NULL,
  `device` varchar(50) DEFAULT NULL,
  `carrier` varchar(50) DEFAULT NULL,
  `package_version` varchar(50) DEFAULT NULL,
  `applications` varchar(50) DEFAULT NULL,
  `software_platform` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `shop` (
  `shop_id` int NOT NULL,
  `shop_name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `open_date` varchar(50) DEFAULT NULL,
  `open_year` int DEFAULT NULL,
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `stock` (
  `shop_id` int NOT NULL,
  `device_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`shop_id`,`device_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`),
  CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
