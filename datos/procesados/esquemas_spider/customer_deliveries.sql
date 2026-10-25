CREATE TABLE `actual_order_products` (
  `actual_order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  KEY `actual_order_id` (`actual_order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `actual_order_products_ibfk_1` FOREIGN KEY (`actual_order_id`) REFERENCES `actual_orders` (`actual_order_id`),
  CONSTRAINT `actual_order_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `actual_orders` (
  `actual_order_id` int NOT NULL,
  `order_status_code` varchar(10) DEFAULT NULL,
  `regular_order_id` int DEFAULT NULL,
  `actual_order_date` datetime DEFAULT NULL,
  PRIMARY KEY (`actual_order_id`),
  KEY `regular_order_id` (`regular_order_id`),
  CONSTRAINT `actual_orders_ibfk_1` FOREIGN KEY (`regular_order_id`) REFERENCES `regular_orders` (`regular_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `address_details` varchar(80) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `zip_postcode` varchar(20) DEFAULT NULL,
  `state_province_county` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_addresses` (
  `customer_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `address_type` varchar(10) DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  KEY `address_id` (`address_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_addresses_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  CONSTRAINT `customer_addresses_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `payment_method` varchar(10) DEFAULT NULL,
  `customer_name` varchar(80) DEFAULT NULL,
  `customer_phone` varchar(80) DEFAULT NULL,
  `customer_email` varchar(80) DEFAULT NULL,
  `date_became_customer` datetime DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `delivery_route_locations` (
  `location_code` varchar(13) NOT NULL,
  `route_id` int DEFAULT NULL,
  `location_address_id` int DEFAULT NULL,
  `location_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`location_code`),
  KEY `route_id` (`route_id`),
  KEY `location_address_id` (`location_address_id`),
  CONSTRAINT `delivery_route_locations_ibfk_1` FOREIGN KEY (`route_id`) REFERENCES `delivery_routes` (`route_id`),
  CONSTRAINT `delivery_route_locations_ibfk_2` FOREIGN KEY (`location_address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `delivery_routes` (
  `route_id` int NOT NULL,
  `route_name` varchar(50) DEFAULT NULL,
  `other_route_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`route_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employees` (
  `employee_id` int NOT NULL,
  `employee_address_id` int DEFAULT NULL,
  `employee_name` varchar(80) DEFAULT NULL,
  `employee_phone` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `employee_address_id` (`employee_address_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`employee_address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_deliveries` (
  `location_code` varchar(13) DEFAULT NULL,
  `actual_order_id` int DEFAULT NULL,
  `delivery_status_code` varchar(10) DEFAULT NULL,
  `driver_employee_id` int DEFAULT NULL,
  `truck_id` int DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  KEY `driver_employee_id` (`driver_employee_id`),
  KEY `location_code` (`location_code`),
  KEY `actual_order_id` (`actual_order_id`),
  KEY `truck_id` (`truck_id`),
  CONSTRAINT `order_deliveries_ibfk_1` FOREIGN KEY (`driver_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `order_deliveries_ibfk_2` FOREIGN KEY (`location_code`) REFERENCES `delivery_route_locations` (`location_code`),
  CONSTRAINT `order_deliveries_ibfk_3` FOREIGN KEY (`actual_order_id`) REFERENCES `actual_orders` (`actual_order_id`),
  CONSTRAINT `order_deliveries_ibfk_4` FOREIGN KEY (`truck_id`) REFERENCES `trucks` (`truck_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_name` varchar(20) DEFAULT NULL,
  `product_price` decimal(19,4) DEFAULT NULL,
  `product_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `regular_order_products` (
  `regular_order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  KEY `regular_order_id` (`regular_order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `regular_order_products_ibfk_1` FOREIGN KEY (`regular_order_id`) REFERENCES `regular_orders` (`regular_order_id`),
  CONSTRAINT `regular_order_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `regular_orders` (
  `regular_order_id` int NOT NULL,
  `distributer_id` int DEFAULT NULL,
  PRIMARY KEY (`regular_order_id`),
  KEY `distributer_id` (`distributer_id`),
  CONSTRAINT `regular_orders_ibfk_1` FOREIGN KEY (`distributer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `trucks` (
  `truck_id` int NOT NULL,
  `truck_licence_number` varchar(20) DEFAULT NULL,
  `truck_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`truck_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
