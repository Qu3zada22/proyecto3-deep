CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `address_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `circulation_history` (
  `document_id` int NOT NULL,
  `draft_number` int NOT NULL,
  `copy_number` int NOT NULL,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`document_id`,`draft_number`,`copy_number`,`employee_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `circulation_history_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `document_drafts` (
  `document_id` int NOT NULL,
  `draft_number` int NOT NULL,
  `draft_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_id`,`draft_number`),
  CONSTRAINT `document_drafts_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `documents` (
  `document_id` int NOT NULL,
  `document_status_code` varchar(15) DEFAULT NULL,
  `document_type_code` varchar(15) DEFAULT NULL,
  `shipping_agent_code` varchar(15) DEFAULT NULL,
  `receipt_date` datetime DEFAULT NULL,
  `receipt_number` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `shipping_agent_code` (`shipping_agent_code`),
  KEY `document_status_code` (`document_status_code`),
  KEY `document_type_code` (`document_type_code`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`shipping_agent_code`) REFERENCES `ref_shipping_agents` (`shipping_agent_code`),
  CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`document_status_code`) REFERENCES `ref_document_status` (`document_status_code`),
  CONSTRAINT `documents_ibfk_3` FOREIGN KEY (`document_type_code`) REFERENCES `ref_document_types` (`document_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `documents_mailed` (
  `document_id` int NOT NULL,
  `mailed_to_address_id` int NOT NULL,
  `mailing_date` datetime DEFAULT NULL,
  PRIMARY KEY (`document_id`,`mailed_to_address_id`),
  KEY `mailed_to_address_id` (`mailed_to_address_id`),
  CONSTRAINT `documents_mailed_ibfk_1` FOREIGN KEY (`mailed_to_address_id`) REFERENCES `addresses` (`address_id`),
  CONSTRAINT `documents_mailed_ibfk_2` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `draft_copies` (
  `document_id` int NOT NULL,
  `draft_number` int NOT NULL,
  `copy_number` int NOT NULL,
  PRIMARY KEY (`document_id`,`draft_number`,`copy_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employees` (
  `employee_id` int NOT NULL,
  `role_code` varchar(15) DEFAULT NULL,
  `employee_name` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `role_code` (`role_code`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`role_code`) REFERENCES `roles` (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_document_status` (
  `document_status_code` varchar(15) NOT NULL,
  `document_status_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_status_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_document_types` (
  `document_type_code` varchar(15) NOT NULL,
  `document_type_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_shipping_agents` (
  `shipping_agent_code` varchar(15) NOT NULL,
  `shipping_agent_name` varchar(255) DEFAULT NULL,
  `shipping_agent_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`shipping_agent_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `roles` (
  `role_code` varchar(15) NOT NULL,
  `role_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
