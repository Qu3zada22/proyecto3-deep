CREATE TABLE `claim_headers` (
  `claim_header_id` int NOT NULL,
  `claim_status_code` varchar(15) DEFAULT NULL,
  `claim_type_code` varchar(21) DEFAULT NULL,
  `policy_id` int DEFAULT NULL,
  `date_of_claim` datetime DEFAULT NULL,
  `date_of_settlement` datetime DEFAULT NULL,
  `amount_claimed` decimal(20,4) DEFAULT NULL,
  `amount_piad` decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (`claim_header_id`),
  KEY `policy_id` (`policy_id`),
  CONSTRAINT `claim_headers_ibfk_1` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `claims_documents` (
  `claim_id` int NOT NULL,
  `document_type_code` varchar(15) NOT NULL,
  `created_by_staff_id` int DEFAULT NULL,
  `created_date` int DEFAULT NULL,
  PRIMARY KEY (`claim_id`,`document_type_code`),
  KEY `created_by_staff_id` (`created_by_staff_id`),
  CONSTRAINT `claims_documents_ibfk_1` FOREIGN KEY (`created_by_staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `claims_documents_ibfk_2` FOREIGN KEY (`claim_id`) REFERENCES `claim_headers` (`claim_header_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `claims_processing` (
  `claim_processing_id` int NOT NULL,
  `claim_id` int DEFAULT NULL,
  `claim_outcome_code` varchar(15) DEFAULT NULL,
  `claim_stage_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  PRIMARY KEY (`claim_processing_id`),
  KEY `staff_id` (`staff_id`),
  KEY `claim_id` (`claim_id`),
  CONSTRAINT `claims_processing_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `claims_processing_ibfk_2` FOREIGN KEY (`claim_id`) REFERENCES `claim_headers` (`claim_header_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `claims_processing_stages` (
  `claim_stage_id` int NOT NULL,
  `next_claim_stage_id` int DEFAULT NULL,
  `claim_status_name` varchar(255) DEFAULT NULL,
  `claim_status_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`claim_stage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `policies` (
  `policy_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `policy_type_code` varchar(15) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`policy_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `policies_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `staff_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
