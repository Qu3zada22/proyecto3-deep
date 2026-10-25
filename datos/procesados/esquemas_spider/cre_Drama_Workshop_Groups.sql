CREATE TABLE `addresses` (
  `address_id` varchar(100) NOT NULL,
  `line_1` varchar(255) DEFAULT NULL,
  `line_2` varchar(255) DEFAULT NULL,
  `city_town` varchar(255) DEFAULT NULL,
  `state_county` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `bookings` (
  `booking_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `workshop_group_id` int DEFAULT NULL,
  `status_code` varchar(15) DEFAULT NULL,
  `store_id` int DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `planned_delivery_date` datetime DEFAULT NULL,
  `actual_delivery_date` datetime DEFAULT NULL,
  `other_order_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `workshop_group_id` (`workshop_group_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`workshop_group_id`) REFERENCES `drama_workshop_groups` (`workshop_group_id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `clients` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `bookings_services` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `bookings_services_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `services` (`service_id`),
  CONSTRAINT `bookings_services_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `bookings` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `clients` (
  `client_id` int NOT NULL,
  `address_id` varchar(100) DEFAULT NULL,
  `customer_email_address` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_orders` (
  `order_id` int NOT NULL,
  `customer_id` varchar(100) DEFAULT NULL,
  `store_id` varchar(100) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `planned_delivery_date` datetime DEFAULT NULL,
  `actual_delivery_date` datetime DEFAULT NULL,
  `other_order_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `store_id` (`store_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_orders_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`),
  CONSTRAINT `customer_orders_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` varchar(100) NOT NULL,
  `address_id` varchar(100) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(255) DEFAULT NULL,
  `customer_email_address` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `drama_workshop_groups` (
  `workshop_group_id` int NOT NULL,
  `address_id` varchar(100) DEFAULT NULL,
  `currency_code` varchar(15) DEFAULT NULL,
  `marketing_region_code` varchar(15) DEFAULT NULL,
  `store_name` varchar(255) DEFAULT NULL,
  `store_phone` varchar(255) DEFAULT NULL,
  `store_email_address` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`workshop_group_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `drama_workshop_groups_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `invoice_items` (
  `invoice_item_id` int NOT NULL,
  `invoice_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `order_item_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `order_quantity` int DEFAULT NULL,
  `other_item_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`invoice_item_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `order_item_id` (`order_item_id`),
  CONSTRAINT `invoice_items_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`),
  CONSTRAINT `invoice_items_ibfk_2` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`order_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `invoices` (
  `invoice_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `payment_method_code` varchar(10) DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `order_quantity` varchar(288) DEFAULT NULL,
  `other_item_details` varchar(255) DEFAULT NULL,
  `order_item_id` int DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `payment_method_code` (`payment_method_code`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`payment_method_code`) REFERENCES `ref_payment_methods` (`payment_method_code`),
  CONSTRAINT `invoices_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `bookings` (`booking_id`),
  CONSTRAINT `invoices_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `customer_orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `marketing_regions` (
  `marketing_region_code` varchar(15) NOT NULL,
  `marketing_region_name` varchar(255) DEFAULT NULL,
  `marketing_region_descriptrion` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`marketing_region_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` varchar(100) DEFAULT NULL,
  `order_quantity` varchar(288) DEFAULT NULL,
  `other_item_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `product_id` (`product_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `customer_orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `performers` (
  `performer_id` int NOT NULL,
  `address_id` varchar(100) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(255) DEFAULT NULL,
  `customer_email_address` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`performer_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `performers_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `performers_in_bookings` (
  `order_id` int NOT NULL,
  `performer_id` int NOT NULL,
  PRIMARY KEY (`order_id`,`performer_id`),
  KEY `performer_id` (`performer_id`),
  CONSTRAINT `performers_in_bookings_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `bookings` (`booking_id`),
  CONSTRAINT `performers_in_bookings_ibfk_2` FOREIGN KEY (`performer_id`) REFERENCES `performers` (`performer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` varchar(100) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` decimal(20,4) DEFAULT NULL,
  `product_description` varchar(255) DEFAULT NULL,
  `other_product_service_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_payment_methods` (
  `payment_method_code` varchar(10) NOT NULL,
  `payment_method_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`payment_method_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_service_types` (
  `service_type_code` varchar(15) NOT NULL,
  `parent_service_type_code` varchar(15) DEFAULT NULL,
  `service_type_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`service_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `services` (
  `service_id` int NOT NULL,
  `service_type_code` varchar(15) DEFAULT NULL,
  `workshop_group_id` int DEFAULT NULL,
  `product_description` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` decimal(20,4) DEFAULT NULL,
  `other_product_service_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`service_id`),
  KEY `service_type_code` (`service_type_code`),
  KEY `workshop_group_id` (`workshop_group_id`),
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`service_type_code`) REFERENCES `ref_service_types` (`service_type_code`),
  CONSTRAINT `services_ibfk_2` FOREIGN KEY (`workshop_group_id`) REFERENCES `drama_workshop_groups` (`workshop_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `stores` (
  `store_id` varchar(100) NOT NULL,
  `address_id` varchar(100) DEFAULT NULL,
  `marketing_region_code` varchar(15) DEFAULT NULL,
  `store_name` varchar(255) DEFAULT NULL,
  `store_phone` varchar(255) DEFAULT NULL,
  `store_email_address` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  KEY `marketing_region_code` (`marketing_region_code`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `stores_ibfk_1` FOREIGN KEY (`marketing_region_code`) REFERENCES `marketing_regions` (`marketing_region_code`),
  CONSTRAINT `stores_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
