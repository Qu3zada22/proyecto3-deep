CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `line_1_number_building` varchar(80) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `zip_postcode` varchar(20) DEFAULT NULL,
  `state_province_county` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `contacts` (
  `contact_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `contact_phone` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_address_history` (
  `customer_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  KEY `address_id` (`address_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_address_history_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  CONSTRAINT `customer_address_history_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_orders` (
  `order_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `order_status_code` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `payment_method_code` varchar(15) DEFAULT NULL,
  `customer_number` varchar(20) DEFAULT NULL,
  `customer_name` varchar(80) DEFAULT NULL,
  `customer_address` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(80) DEFAULT NULL,
  `customer_email` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_items` (
  `order_item_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `order_quantity` varchar(80) DEFAULT NULL,
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `customer_orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_type_code` varchar(15) DEFAULT NULL,
  `product_name` varchar(80) DEFAULT NULL,
  `product_price` double DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
