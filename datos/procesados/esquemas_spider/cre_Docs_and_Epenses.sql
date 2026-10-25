CREATE TABLE `accounts` (
  `account_id` int NOT NULL,
  `statement_id` int DEFAULT NULL,
  `account_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  KEY `statement_id` (`statement_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`statement_id`) REFERENCES `statements` (`statement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `documents` (
  `document_id` int NOT NULL,
  `document_type_code` varchar(15) DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `document_date` datetime DEFAULT NULL,
  `document_name` varchar(255) DEFAULT NULL,
  `document_description` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `project_id` (`project_id`),
  KEY `document_type_code` (`document_type_code`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`),
  CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`document_type_code`) REFERENCES `ref_document_types` (`document_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `documents_with_expenses` (
  `document_id` int NOT NULL,
  `budget_type_code` varchar(15) DEFAULT NULL,
  `document_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `budget_type_code` (`budget_type_code`),
  CONSTRAINT `documents_with_expenses_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`),
  CONSTRAINT `documents_with_expenses_ibfk_2` FOREIGN KEY (`budget_type_code`) REFERENCES `ref_budget_codes` (`budget_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `projects` (
  `project_id` int NOT NULL,
  `project_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_budget_codes` (
  `budget_type_code` varchar(15) NOT NULL,
  `budget_type_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`budget_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_document_types` (
  `document_type_code` varchar(15) NOT NULL,
  `document_type_name` varchar(255) DEFAULT NULL,
  `document_type_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `statements` (
  `statement_id` int NOT NULL,
  `statement_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`statement_id`),
  CONSTRAINT `statements_ibfk_1` FOREIGN KEY (`statement_id`) REFERENCES `documents` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
