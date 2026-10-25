CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `address_content` varchar(80) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `zip_postcode` varchar(20) DEFAULT NULL,
  `state_province_county` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `other_address_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_addresses` (
  `customer_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `date_address_from` datetime DEFAULT NULL,
  `address_type` varchar(15) DEFAULT NULL,
  `date_address_to` datetime DEFAULT NULL,
  KEY `customer_id` (`customer_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `customer_addresses_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `customer_addresses_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_contact_channels` (
  `customer_id` int DEFAULT NULL,
  `channel_code` varchar(15) DEFAULT NULL,
  `active_from_date` datetime DEFAULT NULL,
  `active_to_date` datetime DEFAULT NULL,
  `contact_number` varchar(50) DEFAULT NULL,
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_contact_channels_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_orders` (
  `order_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `order_status` varchar(15) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `order_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `payment_method` varchar(15) DEFAULT NULL,
  `customer_name` varchar(80) DEFAULT NULL,
  `date_became_customer` datetime DEFAULT NULL,
  `other_customer_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_items` (
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `order_quantity` varchar(15) DEFAULT NULL,
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `customer_orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
