CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `line_1_number_building` varchar(80) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `zip_postcode` varchar(20) DEFAULT NULL,
  `state_province_county` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_payments` (
  `customer_id` int NOT NULL,
  `datetime_payment` datetime NOT NULL,
  `payment_method_code` varchar(12) DEFAULT NULL,
  `amount_payment` double DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`datetime_payment`),
  CONSTRAINT `customer_payments_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_address_id` int DEFAULT NULL,
  `customer_status_code` varchar(15) DEFAULT NULL,
  `date_became_customer` datetime DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `last_name` varchar(80) DEFAULT NULL,
  `amount_outstanding` double DEFAULT NULL,
  `email_address` varchar(250) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `cell_mobile_phone_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `customer_address_id` (`customer_address_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`customer_address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `lessons` (
  `lesson_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `lesson_status_code` varchar(15) DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `vehicle_id` int DEFAULT NULL,
  `lesson_date` datetime DEFAULT NULL,
  `lesson_time` varchar(10) DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`lesson_id`),
  KEY `customer_id` (`customer_id`),
  KEY `staff_id` (`staff_id`),
  KEY `vehicle_id` (`vehicle_id`),
  CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `lessons_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `lessons_ibfk_3` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `staff_address_id` int DEFAULT NULL,
  `nickname` varchar(80) DEFAULT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `middle_name` varchar(80) DEFAULT NULL,
  `last_name` varchar(80) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `date_joined_staff` datetime DEFAULT NULL,
  `date_left_staff` datetime DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `staff_address_id` (`staff_address_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`staff_address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `vehicles` (
  `vehicle_id` int NOT NULL,
  `vehicle_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
