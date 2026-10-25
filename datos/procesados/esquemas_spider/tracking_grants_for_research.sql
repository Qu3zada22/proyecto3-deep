CREATE TABLE `document_types` (
  `document_type_code` varchar(10) NOT NULL,
  `document_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `documents` (
  `document_id` int NOT NULL,
  `document_type_code` varchar(10) DEFAULT NULL,
  `grant_id` int DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  `response_received_date` datetime DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `grant_id` (`grant_id`),
  KEY `document_type_code` (`document_type_code`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`grant_id`) REFERENCES `grants` (`grant_id`),
  CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`document_type_code`) REFERENCES `document_types` (`document_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `grants` (
  `grant_id` int NOT NULL,
  `organisation_id` int DEFAULT NULL,
  `grant_amount` decimal(19,4) DEFAULT NULL,
  `grant_start_date` datetime DEFAULT NULL,
  `grant_end_date` datetime DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`grant_id`),
  KEY `organisation_id` (`organisation_id`),
  CONSTRAINT `grants_ibfk_1` FOREIGN KEY (`organisation_id`) REFERENCES `organisations` (`organisation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `organisation_types` (
  `organisation_type` varchar(10) NOT NULL,
  `organisation_type_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`organisation_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `organisations` (
  `organisation_id` int NOT NULL,
  `organisation_type` varchar(10) DEFAULT NULL,
  `organisation_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`organisation_id`),
  KEY `organisation_type` (`organisation_type`),
  CONSTRAINT `organisations_ibfk_1` FOREIGN KEY (`organisation_type`) REFERENCES `organisation_types` (`organisation_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `project_outcomes` (
  `project_id` int DEFAULT NULL,
  `outcome_code` varchar(10) DEFAULT NULL,
  `outcome_details` varchar(255) DEFAULT NULL,
  KEY `outcome_code` (`outcome_code`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_outcomes_ibfk_1` FOREIGN KEY (`outcome_code`) REFERENCES `research_outcomes` (`outcome_code`),
  CONSTRAINT `project_outcomes_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `project_staff` (
  `staff_id` double NOT NULL,
  `project_id` int DEFAULT NULL,
  `role_code` varchar(10) DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `role_code` (`role_code`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_staff_ibfk_1` FOREIGN KEY (`role_code`) REFERENCES `staff_roles` (`role_code`),
  CONSTRAINT `project_staff_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `projects` (
  `project_id` int NOT NULL,
  `organisation_id` int DEFAULT NULL,
  `project_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `organisation_id` (`organisation_id`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`organisation_id`) REFERENCES `organisations` (`organisation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `research_outcomes` (
  `outcome_code` varchar(10) NOT NULL,
  `outcome_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`outcome_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `research_staff` (
  `staff_id` int NOT NULL,
  `employer_organisation_id` int DEFAULT NULL,
  `staff_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `employer_organisation_id` (`employer_organisation_id`),
  CONSTRAINT `research_staff_ibfk_1` FOREIGN KEY (`employer_organisation_id`) REFERENCES `organisations` (`organisation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff_roles` (
  `role_code` varchar(10) NOT NULL,
  `role_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tasks` (
  `task_id` int NOT NULL,
  `project_id` int DEFAULT NULL,
  `task_details` varchar(255) DEFAULT NULL,
  `eg agree objectives` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
