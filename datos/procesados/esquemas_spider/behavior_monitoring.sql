CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `line_1` varchar(120) DEFAULT NULL,
  `line_2` varchar(120) DEFAULT NULL,
  `line_3` varchar(120) DEFAULT NULL,
  `city` varchar(80) DEFAULT NULL,
  `zip_postcode` varchar(20) DEFAULT NULL,
  `state_province_county` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `other_address_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `assessment_notes` (
  `notes_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `teacher_id` int DEFAULT NULL,
  `date_of_notes` datetime DEFAULT NULL,
  `text_of_notes` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  KEY `teacher_id` (`teacher_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `assessment_notes_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`),
  CONSTRAINT `assessment_notes_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `behavior_incident` (
  `incident_id` int NOT NULL,
  `incident_type_code` varchar(10) DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `date_incident_start` datetime DEFAULT NULL,
  `date_incident_end` datetime DEFAULT NULL,
  `incident_summary` varchar(255) DEFAULT NULL,
  `recommendations` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`incident_id`),
  KEY `student_id` (`student_id`),
  KEY `incident_type_code` (`incident_type_code`),
  CONSTRAINT `behavior_incident_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `behavior_incident_ibfk_2` FOREIGN KEY (`incident_type_code`) REFERENCES `ref_incident_type` (`incident_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `detention` (
  `detention_id` int NOT NULL,
  `detention_type_code` varchar(10) DEFAULT NULL,
  `teacher_id` int DEFAULT NULL,
  `datetime_detention_start` datetime DEFAULT NULL,
  `datetime_detention_end` datetime DEFAULT NULL,
  `detention_summary` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`detention_id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `detention_type_code` (`detention_type_code`),
  CONSTRAINT `detention_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`),
  CONSTRAINT `detention_ibfk_2` FOREIGN KEY (`detention_type_code`) REFERENCES `ref_detention_type` (`detention_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_address_types` (
  `address_type_code` varchar(15) NOT NULL,
  `address_type_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`address_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_detention_type` (
  `detention_type_code` varchar(10) NOT NULL,
  `detention_type_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`detention_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_incident_type` (
  `incident_type_code` varchar(10) NOT NULL,
  `incident_type_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`incident_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student_addresses` (
  `student_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `date_address_from` datetime DEFAULT NULL,
  `date_address_to` datetime DEFAULT NULL,
  `monthly_rental` decimal(19,4) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  KEY `student_id` (`student_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `student_addresses_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `student_addresses_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `students` (
  `student_id` int NOT NULL,
  `address_id` int DEFAULT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `middle_name` varchar(40) DEFAULT NULL,
  `last_name` varchar(40) DEFAULT NULL,
  `cell_mobile_number` varchar(40) DEFAULT NULL,
  `email_address` varchar(40) DEFAULT NULL,
  `date_first_rental` datetime DEFAULT NULL,
  `date_left_university` datetime DEFAULT NULL,
  `other_student_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `students_in_detention` (
  `student_id` int DEFAULT NULL,
  `detention_id` int DEFAULT NULL,
  `incident_id` int DEFAULT NULL,
  KEY `student_id` (`student_id`),
  KEY `detention_id` (`detention_id`),
  KEY `incident_id` (`incident_id`),
  CONSTRAINT `students_in_detention_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `students_in_detention_ibfk_2` FOREIGN KEY (`detention_id`) REFERENCES `detention` (`detention_id`),
  CONSTRAINT `students_in_detention_ibfk_3` FOREIGN KEY (`incident_id`) REFERENCES `behavior_incident` (`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `teachers` (
  `teacher_id` int NOT NULL,
  `address_id` int DEFAULT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `middle_name` varchar(80) DEFAULT NULL,
  `last_name` varchar(80) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `cell_mobile_number` varchar(40) DEFAULT NULL,
  `email_address` varchar(40) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`teacher_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
