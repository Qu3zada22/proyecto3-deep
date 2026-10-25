CREATE TABLE `documents` (
  `document_id` int NOT NULL,
  `template_id` int DEFAULT NULL,
  `document_name` varchar(255) DEFAULT NULL,
  `document_description` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `template_id` (`template_id`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `templates` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `paragraphs` (
  `paragraph_id` int NOT NULL,
  `document_id` int DEFAULT NULL,
  `paragraph_text` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`paragraph_id`),
  KEY `document_id` (`document_id`),
  CONSTRAINT `paragraphs_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_template_types` (
  `template_type_code` varchar(15) NOT NULL,
  `template_type_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`template_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `templates` (
  `template_id` int NOT NULL,
  `version_number` int DEFAULT NULL,
  `template_type_code` varchar(15) DEFAULT NULL,
  `date_effective_from` datetime DEFAULT NULL,
  `date_effective_to` datetime DEFAULT NULL,
  `template_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`template_id`),
  KEY `template_type_code` (`template_type_code`),
  CONSTRAINT `templates_ibfk_1` FOREIGN KEY (`template_type_code`) REFERENCES `ref_template_types` (`template_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
