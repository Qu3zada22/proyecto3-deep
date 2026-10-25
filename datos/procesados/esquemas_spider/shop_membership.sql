CREATE TABLE `branch` (
  `branch_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `open_year` varchar(50) DEFAULT NULL,
  `address_road` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `membership_amount` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `member` (
  `member_id` int NOT NULL,
  `card_number` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `hometown` varchar(50) DEFAULT NULL,
  `level` int DEFAULT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `membership_register_branch` (
  `member_id` int NOT NULL,
  `branch_id` int DEFAULT NULL,
  `register_year` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `membership_register_branch_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `membership_register_branch_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `purchase` (
  `member_id` int NOT NULL,
  `branch_id` int NOT NULL,
  `year` varchar(50) NOT NULL,
  `total_pounds` double DEFAULT NULL,
  PRIMARY KEY (`member_id`,`branch_id`,`year`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
