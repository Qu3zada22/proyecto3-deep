CREATE TABLE `available_policies` (
  `policy_id` int NOT NULL,
  `policy_type_code` varchar(18) DEFAULT NULL,
  `customer_phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`policy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `claims` (
  `claim_id` int NOT NULL,
  `fnol_id` int DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  PRIMARY KEY (`claim_id`),
  KEY `fnol_id` (`fnol_id`),
  CONSTRAINT `claims_ibfk_1` FOREIGN KEY (`fnol_id`) REFERENCES `first_notification_of_loss` (`fnol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers_policies` (
  `customer_id` int NOT NULL,
  `policy_id` int NOT NULL,
  `date_opened` date DEFAULT NULL,
  `date_closed` date DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`policy_id`),
  KEY `policy_id` (`policy_id`),
  CONSTRAINT `customers_policies_ibfk_1` FOREIGN KEY (`policy_id`) REFERENCES `available_policies` (`policy_id`),
  CONSTRAINT `customers_policies_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `first_notification_of_loss` (
  `fnol_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `policy_id` int DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  PRIMARY KEY (`fnol_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `first_notification_of_loss_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `services` (
  `service_id` int NOT NULL,
  `service_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `settlements` (
  `settlement_id` int NOT NULL,
  `claim_id` int DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  `settlement_amount` double DEFAULT NULL,
  PRIMARY KEY (`settlement_id`),
  KEY `claim_id` (`claim_id`),
  CONSTRAINT `settlements_ibfk_1` FOREIGN KEY (`claim_id`) REFERENCES `claims` (`claim_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
