CREATE TABLE `district` (
  `district_id` int NOT NULL,
  `district_name` varchar(50) DEFAULT NULL,
  `headquartered_city` varchar(50) DEFAULT NULL,
  `city_population` double DEFAULT NULL,
  `city_area` double DEFAULT NULL,
  PRIMARY KEY (`district_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product` (
  `product_id` int NOT NULL,
  `product` varchar(50) DEFAULT NULL,
  `dimensions` varchar(50) DEFAULT NULL,
  `dpi` double DEFAULT NULL,
  `pages_per_minute_color` double DEFAULT NULL,
  `max_page_size` varchar(50) DEFAULT NULL,
  `interface` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `store` (
  `store_id` int NOT NULL,
  `store_name` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `area_size` double DEFAULT NULL,
  `number_of_product_category` double DEFAULT NULL,
  `ranking` int DEFAULT NULL,
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `store_district` (
  `store_id` int NOT NULL,
  `district_id` int DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  KEY `district_id` (`district_id`),
  CONSTRAINT `store_district_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`),
  CONSTRAINT `store_district_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `store_product` (
  `store_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`store_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `store_product_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `store_product_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
