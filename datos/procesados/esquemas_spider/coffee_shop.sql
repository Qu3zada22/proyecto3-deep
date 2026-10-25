CREATE TABLE `happy_hour` (
  `hh_id` int NOT NULL,
  `shop_id` int NOT NULL,
  `month` varchar(50) NOT NULL,
  `num_of_shaff_in_charge` int DEFAULT NULL,
  PRIMARY KEY (`hh_id`,`shop_id`,`month`),
  KEY `shop_id` (`shop_id`),
  CONSTRAINT `happy_hour_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `happy_hour_member` (
  `hh_id` int NOT NULL,
  `member_id` int NOT NULL,
  `total_amount` double DEFAULT NULL,
  PRIMARY KEY (`hh_id`,`member_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `happy_hour_member_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `member` (
  `member_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `membership_card` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `time_of_purchase` int DEFAULT NULL,
  `level_of_membership` int DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `shop` (
  `shop_id` int NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `num_of_staff` varchar(50) DEFAULT NULL,
  `score` double DEFAULT NULL,
  `open_year` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
