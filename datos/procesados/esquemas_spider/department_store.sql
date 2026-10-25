CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `address_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_addresses` (
  `customer_id` int NOT NULL,
  `address_id` int NOT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`address_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `customer_addresses_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `customer_addresses_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_orders` (
  `order_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `order_status_code` varchar(10) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `payment_method_code` varchar(12) DEFAULT NULL,
  `customer_code` varchar(20) DEFAULT NULL,
  `customer_name` varchar(80) DEFAULT NULL,
  `customer_address` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(80) DEFAULT NULL,
  `customer_email` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `department_store_chain` (
  `dept_store_chain_id` int NOT NULL,
  `dept_store_chain_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`dept_store_chain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `department_stores` (
  `dept_store_id` int NOT NULL,
  `dept_store_chain_id` int DEFAULT NULL,
  `store_name` varchar(80) DEFAULT NULL,
  `store_address` varchar(255) DEFAULT NULL,
  `store_phone` varchar(80) DEFAULT NULL,
  `store_email` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`dept_store_id`),
  KEY `dept_store_chain_id` (`dept_store_chain_id`),
  CONSTRAINT `department_stores_ibfk_1` FOREIGN KEY (`dept_store_chain_id`) REFERENCES `department_store_chain` (`dept_store_chain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `departments` (
  `department_id` int NOT NULL,
  `dept_store_id` int DEFAULT NULL,
  `department_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `dept_store_id` (`dept_store_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`dept_store_id`) REFERENCES `department_stores` (`dept_store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `product_id` (`product_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `customer_orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product_suppliers` (
  `product_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `date_supplied_from` datetime DEFAULT NULL,
  `date_supplied_to` datetime DEFAULT NULL,
  `total_amount_purchased` varchar(80) DEFAULT NULL,
  `total_value_purchased` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`product_id`,`supplier_id`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `product_suppliers_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `product_suppliers_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_type_code` varchar(10) DEFAULT NULL,
  `product_name` varchar(80) DEFAULT NULL,
  `product_price` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `staff_gender` varchar(1) DEFAULT NULL,
  `staff_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff_department_assignments` (
  `staff_id` int NOT NULL,
  `department_id` int NOT NULL,
  `date_assigned_from` datetime DEFAULT NULL,
  `job_title_code` varchar(18) DEFAULT NULL,
  `date_assigned_to` datetime DEFAULT NULL,
  PRIMARY KEY (`staff_id`,`department_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `staff_department_assignments_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `staff_department_assignments_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `supplier_addresses` (
  `supplier_id` int NOT NULL,
  `address_id` int NOT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  PRIMARY KEY (`supplier_id`,`address_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `supplier_addresses_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  CONSTRAINT `supplier_addresses_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL,
  `supplier_name` varchar(80) DEFAULT NULL,
  `supplier_phone` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
