CREATE TABLE `accounts` (
  `account_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `other_account_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_first_name` varchar(20) DEFAULT NULL,
  `customer_last_name` varchar(20) DEFAULT NULL,
  `customer_address` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(255) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `other_customer_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers_cards` (
  `card_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `card_type_code` varchar(15) DEFAULT NULL,
  `card_number` varchar(80) DEFAULT NULL,
  `date_valid_from` datetime DEFAULT NULL,
  `date_valid_to` datetime DEFAULT NULL,
  `other_card_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `financial_transactions` (
  `transaction_id` int DEFAULT NULL,
  `previous_transaction_id` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `card_id` int DEFAULT NULL,
  `transaction_type` varchar(15) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `transaction_amount` double DEFAULT NULL,
  `transaction_comment` varchar(255) DEFAULT NULL,
  `other_transaction_details` varchar(255) DEFAULT NULL,
  KEY `account_id` (`account_id`),
  KEY `card_id` (`card_id`),
  CONSTRAINT `financial_transactions_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`),
  CONSTRAINT `financial_transactions_ibfk_2` FOREIGN KEY (`card_id`) REFERENCES `customers_cards` (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
