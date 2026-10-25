CREATE TABLE `attribute_definitions` (
  `attribute_id` int NOT NULL,
  `attribute_name` varchar(30) DEFAULT NULL,
  `attribute_data_type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `catalog_contents` (
  `catalog_entry_id` int NOT NULL,
  `catalog_level_number` int DEFAULT NULL,
  `parent_entry_id` int DEFAULT NULL,
  `previous_entry_id` int DEFAULT NULL,
  `next_entry_id` int DEFAULT NULL,
  `catalog_entry_name` varchar(80) DEFAULT NULL,
  `product_stock_number` varchar(50) DEFAULT NULL,
  `price_in_dollars` double DEFAULT NULL,
  `price_in_euros` double DEFAULT NULL,
  `price_in_pounds` double DEFAULT NULL,
  `capacity` varchar(20) DEFAULT NULL,
  `length` varchar(20) DEFAULT NULL,
  `height` varchar(20) DEFAULT NULL,
  `width` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`catalog_entry_id`),
  KEY `catalog_level_number` (`catalog_level_number`),
  CONSTRAINT `catalog_contents_ibfk_1` FOREIGN KEY (`catalog_level_number`) REFERENCES `catalog_structure` (`catalog_level_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `catalog_contents_additional_attributes` (
  `catalog_entry_id` int DEFAULT NULL,
  `catalog_level_number` int DEFAULT NULL,
  `attribute_id` int DEFAULT NULL,
  `attribute_value` varchar(255) DEFAULT NULL,
  KEY `catalog_level_number` (`catalog_level_number`),
  KEY `catalog_entry_id` (`catalog_entry_id`),
  CONSTRAINT `catalog_contents_additional_attributes_ibfk_1` FOREIGN KEY (`catalog_level_number`) REFERENCES `catalog_structure` (`catalog_level_number`),
  CONSTRAINT `catalog_contents_additional_attributes_ibfk_2` FOREIGN KEY (`catalog_entry_id`) REFERENCES `catalog_contents` (`catalog_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `catalog_structure` (
  `catalog_level_number` int NOT NULL,
  `catalog_id` int DEFAULT NULL,
  `catalog_level_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`catalog_level_number`),
  KEY `catalog_id` (`catalog_id`),
  CONSTRAINT `catalog_structure_ibfk_1` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`catalog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `catalogs` (
  `catalog_id` int NOT NULL,
  `catalog_name` varchar(50) DEFAULT NULL,
  `catalog_publisher` varchar(80) DEFAULT NULL,
  `date_of_publication` datetime DEFAULT NULL,
  `date_of_latest_revision` datetime DEFAULT NULL,
  PRIMARY KEY (`catalog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
