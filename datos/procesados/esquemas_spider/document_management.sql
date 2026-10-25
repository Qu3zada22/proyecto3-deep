CREATE TABLE `document_functional_areas` (
  `document_code` varchar(15) DEFAULT NULL,
  `functional_area_code` varchar(15) DEFAULT NULL,
  KEY `functional_area_code` (`functional_area_code`),
  KEY `document_code` (`document_code`),
  CONSTRAINT `document_functional_areas_ibfk_1` FOREIGN KEY (`functional_area_code`) REFERENCES `functional_areas` (`functional_area_code`),
  CONSTRAINT `document_functional_areas_ibfk_2` FOREIGN KEY (`document_code`) REFERENCES `documents` (`document_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `document_sections` (
  `section_id` int NOT NULL,
  `document_code` varchar(15) DEFAULT NULL,
  `section_sequence` int DEFAULT NULL,
  `section_code` varchar(20) DEFAULT NULL,
  `section_title` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `document_code` (`document_code`),
  CONSTRAINT `document_sections_ibfk_1` FOREIGN KEY (`document_code`) REFERENCES `documents` (`document_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `document_sections_images` (
  `section_id` int NOT NULL,
  `image_id` int NOT NULL,
  PRIMARY KEY (`section_id`,`image_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `document_sections_images_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `images` (`image_id`),
  CONSTRAINT `document_sections_images_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `document_sections` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `document_structures` (
  `document_structure_code` varchar(15) NOT NULL,
  `parent_document_structure_code` varchar(15) DEFAULT NULL,
  `document_structure_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`document_structure_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `documents` (
  `document_code` varchar(15) NOT NULL,
  `document_structure_code` varchar(15) DEFAULT NULL,
  `document_type_code` varchar(15) DEFAULT NULL,
  `access_count` int DEFAULT NULL,
  `document_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`document_code`),
  KEY `document_structure_code` (`document_structure_code`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`document_structure_code`) REFERENCES `document_structures` (`document_structure_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `functional_areas` (
  `functional_area_code` varchar(15) NOT NULL,
  `parent_functional_area_code` varchar(15) DEFAULT NULL,
  `functional_area_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`functional_area_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `images` (
  `image_id` int NOT NULL,
  `image_alt_text` varchar(80) DEFAULT NULL,
  `image_name` varchar(40) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `roles` (
  `role_code` varchar(15) NOT NULL,
  `role_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `role_code` varchar(15) DEFAULT NULL,
  `user_name` varchar(40) DEFAULT NULL,
  `user_login` varchar(40) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `role_code` (`role_code`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_code`) REFERENCES `roles` (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
