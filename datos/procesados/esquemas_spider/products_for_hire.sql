CREATE TABLE `bookings` (
  `booking_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `booking_status_code` varchar(11) DEFAULT NULL,
  `returned_damaged_yn` varchar(40) DEFAULT NULL,
  `booking_start_date` datetime DEFAULT NULL,
  `booking_end_date` datetime DEFAULT NULL,
  `count_hired` varchar(40) DEFAULT NULL,
  `amount_payable` decimal(19,4) DEFAULT NULL,
  `amount_of_discount` decimal(19,4) DEFAULT NULL,
  `amount_outstanding` decimal(19,4) DEFAULT NULL,
  `amount_of_refund` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `coupon_id` int DEFAULT NULL,
  `good_or_bad_customer` varchar(4) DEFAULT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `last_name` varchar(80) DEFAULT NULL,
  `gender_mf` varchar(1) DEFAULT NULL,
  `date_became_customer` datetime DEFAULT NULL,
  `date_last_hire` datetime DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `coupon_id` (`coupon_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `discount_coupons` (`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `discount_coupons` (
  `coupon_id` int NOT NULL,
  `date_issued` datetime DEFAULT NULL,
  `coupon_amount` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `payments` (
  `payment_id` int NOT NULL,
  `booking_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `payment_type_code` varchar(15) DEFAULT NULL,
  `amount_paid_in_full_yn` varchar(1) DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `amount_due` decimal(19,4) DEFAULT NULL,
  `amount_paid` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `customer_id` (`customer_id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products_booked` (
  `booking_id` int NOT NULL,
  `product_id` int NOT NULL,
  `returned_yn` varchar(1) DEFAULT NULL,
  `returned_late_yn` varchar(1) DEFAULT NULL,
  `booked_count` int DEFAULT NULL,
  `booked_amount` double DEFAULT NULL,
  PRIMARY KEY (`booking_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `products_booked_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products_for_hire` (`product_id`),
  CONSTRAINT `products_booked_ibfk_2` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products_for_hire` (
  `product_id` int NOT NULL,
  `product_type_code` varchar(15) DEFAULT NULL,
  `daily_hire_cost` decimal(19,4) DEFAULT NULL,
  `product_name` varchar(80) DEFAULT NULL,
  `product_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `view_product_availability` (
  `product_id` int DEFAULT NULL,
  `booking_id` int DEFAULT NULL,
  `status_date` datetime NOT NULL,
  `available_yn` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`status_date`),
  KEY `product_id` (`product_id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `view_product_availability_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products_for_hire` (`product_id`),
  CONSTRAINT `view_product_availability_ibfk_2` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
