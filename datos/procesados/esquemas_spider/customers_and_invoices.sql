CREATE TABLE `accounts` (
  `account_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `date_account_opened` datetime DEFAULT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `other_account_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_first_name` varchar(50) DEFAULT NULL,
  `customer_middle_initial` varchar(1) DEFAULT NULL,
  `customer_last_name` varchar(50) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `login_name` varchar(80) DEFAULT NULL,
  `login_password` varchar(20) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `town_city` varchar(50) DEFAULT NULL,
  `state_county_province` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `financial_transactions` (
  `transaction_id` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `invoice_number` int DEFAULT NULL,
  `transaction_type` varchar(15) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `transaction_amount` decimal(19,4) DEFAULT NULL,
  `transaction_comment` varchar(255) DEFAULT NULL,
  `other_transaction_details` varchar(255) DEFAULT NULL,
  KEY `account_id` (`account_id`),
  KEY `invoice_number` (`invoice_number`),
  CONSTRAINT `financial_transactions_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`),
  CONSTRAINT `financial_transactions_ibfk_2` FOREIGN KEY (`invoice_number`) REFERENCES `invoices` (`invoice_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `invoice_line_items` (
  `order_item_id` int DEFAULT NULL,
  `invoice_number` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `product_title` varchar(80) DEFAULT NULL,
  `product_quantity` varchar(50) DEFAULT NULL,
  `product_price` decimal(19,4) DEFAULT NULL,
  `derived_product_cost` decimal(19,4) DEFAULT NULL,
  `derived_vat_payable` decimal(19,4) DEFAULT NULL,
  `derived_total_cost` decimal(19,4) DEFAULT NULL,
  KEY `product_id` (`product_id`),
  KEY `invoice_number` (`invoice_number`),
  KEY `order_item_id` (`order_item_id`),
  CONSTRAINT `invoice_line_items_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `invoice_line_items_ibfk_2` FOREIGN KEY (`invoice_number`) REFERENCES `invoices` (`invoice_number`),
  CONSTRAINT `invoice_line_items_ibfk_3` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`order_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `invoices` (
  `invoice_number` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `invoice_date` datetime DEFAULT NULL,
  PRIMARY KEY (`invoice_number`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `product_quantity` varchar(50) DEFAULT NULL,
  `other_order_item_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `date_order_placed` datetime DEFAULT NULL,
  `order_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product_categories` (
  `production_type_code` varchar(15) NOT NULL,
  `product_type_description` varchar(80) DEFAULT NULL,
  `vat_rating` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`production_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `parent_product_id` int DEFAULT NULL,
  `production_type_code` varchar(15) DEFAULT NULL,
  `unit_price` decimal(19,4) DEFAULT NULL,
  `product_name` varchar(80) DEFAULT NULL,
  `product_color` varchar(20) DEFAULT NULL,
  `product_size` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `production_type_code` (`production_type_code`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`production_type_code`) REFERENCES `product_categories` (`production_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
