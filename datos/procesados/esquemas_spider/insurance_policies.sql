CREATE TABLE `claims` (
  `claim_id` int NOT NULL,
  `policy_id` int DEFAULT NULL,
  `date_claim_made` date DEFAULT NULL,
  `date_claim_settled` date DEFAULT NULL,
  `amount_claimed` int DEFAULT NULL,
  `amount_settled` int DEFAULT NULL,
  PRIMARY KEY (`claim_id`),
  KEY `policy_id` (`policy_id`),
  CONSTRAINT `claims_ibfk_1` FOREIGN KEY (`policy_id`) REFERENCES `customer_policies` (`policy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_policies` (
  `policy_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `policy_type_code` varchar(15) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`policy_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_policies_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `payments` (
  `payment_id` int NOT NULL,
  `settlement_id` int DEFAULT NULL,
  `payment_method_code` varchar(255) DEFAULT NULL,
  `date_payment_made` date DEFAULT NULL,
  `amount_payment` int DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `settlement_id` (`settlement_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`settlement_id`) REFERENCES `settlements` (`settlement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `settlements` (
  `settlement_id` int NOT NULL,
  `claim_id` int DEFAULT NULL,
  `date_claim_made` date DEFAULT NULL,
  `date_claim_settled` date DEFAULT NULL,
  `amount_claimed` int DEFAULT NULL,
  `amount_settled` int DEFAULT NULL,
  `customer_policy_id` int DEFAULT NULL,
  PRIMARY KEY (`settlement_id`),
  KEY `claim_id` (`claim_id`),
  CONSTRAINT `settlements_ibfk_1` FOREIGN KEY (`claim_id`) REFERENCES `claims` (`claim_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
