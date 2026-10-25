CREATE TABLE `investors` (
  `investor_id` int NOT NULL,
  `investor_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`investor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `lots` (
  `lot_id` int NOT NULL,
  `investor_id` int DEFAULT NULL,
  `lot_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lot_id`),
  KEY `investor_id` (`investor_id`),
  CONSTRAINT `lots_ibfk_1` FOREIGN KEY (`investor_id`) REFERENCES `investors` (`investor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `purchases` (
  `purchase_transaction_id` int DEFAULT NULL,
  `purchase_details` varchar(255) DEFAULT NULL,
  KEY `purchase_transaction_id` (`purchase_transaction_id`),
  CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`purchase_transaction_id`) REFERENCES `transactions` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_transaction_types` (
  `transaction_type_code` varchar(10) NOT NULL,
  `transaction_type_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`transaction_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sales` (
  `sales_transaction_id` int NOT NULL,
  `sales_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sales_transaction_id`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`sales_transaction_id`) REFERENCES `transactions` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL,
  `investor_id` int DEFAULT NULL,
  `transaction_type_code` varchar(10) DEFAULT NULL,
  `date_of_transaction` datetime DEFAULT NULL,
  `amount_of_transaction` decimal(19,4) DEFAULT NULL,
  `share_count` varchar(40) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `transaction_type_code` (`transaction_type_code`),
  KEY `investor_id` (`investor_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`transaction_type_code`) REFERENCES `ref_transaction_types` (`transaction_type_code`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`investor_id`) REFERENCES `investors` (`investor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transactions_lots` (
  `transaction_id` int DEFAULT NULL,
  `lot_id` int DEFAULT NULL,
  KEY `transaction_id` (`transaction_id`),
  KEY `lot_id` (`lot_id`),
  CONSTRAINT `transactions_lots_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`),
  CONSTRAINT `transactions_lots_ibfk_2` FOREIGN KEY (`lot_id`) REFERENCES `lots` (`lot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
