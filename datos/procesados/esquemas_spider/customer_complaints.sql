CREATE TABLE `complaints` (
  `complaint_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `complaint_outcome_code` varchar(20) DEFAULT NULL,
  `complaint_status_code` varchar(20) DEFAULT NULL,
  `complaint_type_code` varchar(20) DEFAULT NULL,
  `date_complaint_raised` datetime DEFAULT NULL,
  `date_complaint_closed` datetime DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `complaints_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_type_code` varchar(20) DEFAULT NULL,
  `address_line_1` varchar(80) DEFAULT NULL,
  `address_line_2` varchar(80) DEFAULT NULL,
  `town_city` varchar(80) DEFAULT NULL,
  `state` varchar(80) DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `parent_product_id` int DEFAULT NULL,
  `product_category_code` varchar(20) DEFAULT NULL,
  `date_product_first_available` datetime DEFAULT NULL,
  `date_product_discontinued` datetime DEFAULT NULL,
  `product_name` varchar(80) DEFAULT NULL,
  `product_description` varchar(255) DEFAULT NULL,
  `product_price` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `last_name` varchar(80) DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
