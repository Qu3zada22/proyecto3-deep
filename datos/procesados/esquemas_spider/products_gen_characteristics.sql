CREATE TABLE `characteristics` (
  `characteristic_id` int NOT NULL,
  `characteristic_type_code` varchar(15) DEFAULT NULL,
  `characteristic_data_type` varchar(10) DEFAULT NULL,
  `characteristic_name` varchar(80) DEFAULT NULL,
  `other_characteristic_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`characteristic_id`),
  KEY `characteristic_type_code` (`characteristic_type_code`),
  CONSTRAINT `characteristics_ibfk_1` FOREIGN KEY (`characteristic_type_code`) REFERENCES `ref_characteristic_types` (`characteristic_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product_characteristics` (
  `product_id` int DEFAULT NULL,
  `characteristic_id` int DEFAULT NULL,
  `product_characteristic_value` varchar(50) DEFAULT NULL,
  KEY `product_id` (`product_id`),
  KEY `characteristic_id` (`characteristic_id`),
  CONSTRAINT `product_characteristics_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `product_characteristics_ibfk_2` FOREIGN KEY (`characteristic_id`) REFERENCES `characteristics` (`characteristic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `color_code` varchar(15) DEFAULT NULL,
  `product_category_code` varchar(15) DEFAULT NULL,
  `product_name` varchar(80) DEFAULT NULL,
  `typical_buying_price` varchar(20) DEFAULT NULL,
  `typical_selling_price` varchar(20) DEFAULT NULL,
  `product_description` varchar(255) DEFAULT NULL,
  `other_product_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `color_code` (`color_code`),
  KEY `product_category_code` (`product_category_code`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`color_code`) REFERENCES `ref_colors` (`color_code`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`product_category_code`) REFERENCES `ref_product_categories` (`product_category_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_characteristic_types` (
  `characteristic_type_code` varchar(15) NOT NULL,
  `characteristic_type_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`characteristic_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_colors` (
  `color_code` varchar(15) NOT NULL,
  `color_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`color_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_product_categories` (
  `product_category_code` varchar(15) NOT NULL,
  `product_category_description` varchar(80) DEFAULT NULL,
  `unit_of_measure` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_category_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
