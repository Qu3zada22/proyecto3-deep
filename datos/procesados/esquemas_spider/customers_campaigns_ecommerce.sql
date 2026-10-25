CREATE TABLE `customer_addresses` (
  `customer_id` int DEFAULT NULL,
  `premise_id` int DEFAULT NULL,
  `date_address_from` datetime DEFAULT NULL,
  `address_type_code` varchar(15) DEFAULT NULL,
  `date_address_to` datetime DEFAULT NULL,
  KEY `customer_id` (`customer_id`),
  KEY `premise_id` (`premise_id`),
  CONSTRAINT `customer_addresses_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `customer_addresses_ibfk_2` FOREIGN KEY (`premise_id`) REFERENCES `premises` (`premise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_orders` (
  `order_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `order_status_code` varchar(15) DEFAULT NULL,
  `shipping_method_code` varchar(15) DEFAULT NULL,
  `order_placed_datetime` datetime DEFAULT NULL,
  `order_delivered_datetime` datetime DEFAULT NULL,
  `order_shipping_charges` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `payment_method` varchar(15) DEFAULT NULL,
  `customer_name` varchar(80) DEFAULT NULL,
  `customer_phone` varchar(80) DEFAULT NULL,
  `customer_email` varchar(80) DEFAULT NULL,
  `customer_address` varchar(255) DEFAULT NULL,
  `customer_login` varchar(80) DEFAULT NULL,
  `customer_password` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mailshot_campaigns` (
  `mailshot_id` int NOT NULL,
  `product_category` varchar(15) DEFAULT NULL,
  `mailshot_name` varchar(80) DEFAULT NULL,
  `mailshot_start_date` datetime DEFAULT NULL,
  `mailshot_end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`mailshot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mailshot_customers` (
  `mailshot_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `outcome_code` varchar(15) DEFAULT NULL,
  `mailshot_customer_date` datetime DEFAULT NULL,
  KEY `mailshot_id` (`mailshot_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `mailshot_customers_ibfk_1` FOREIGN KEY (`mailshot_id`) REFERENCES `mailshot_campaigns` (`mailshot_id`),
  CONSTRAINT `mailshot_customers_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_items` (
  `item_id` int DEFAULT NULL,
  `order_item_status_code` varchar(15) DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `item_status_code` varchar(15) DEFAULT NULL,
  `item_delivered_datetime` datetime DEFAULT NULL,
  `item_order_quantity` varchar(80) DEFAULT NULL,
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `customer_orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `premises` (
  `premise_id` int NOT NULL,
  `premises_type` varchar(15) DEFAULT NULL,
  `premise_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`premise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_category` varchar(15) DEFAULT NULL,
  `product_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
