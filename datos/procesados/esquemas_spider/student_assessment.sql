CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `line_1` varchar(80) DEFAULT NULL,
  `line_2` varchar(80) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `zip_postcode` varchar(20) DEFAULT NULL,
  `state_province_county` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `candidate_assessments` (
  `candidate_id` int NOT NULL,
  `qualification` varchar(15) NOT NULL,
  `assessment_date` datetime DEFAULT NULL,
  `asessment_outcome_code` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`candidate_id`,`qualification`),
  CONSTRAINT `candidate_assessments_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`candidate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `candidates` (
  `candidate_id` int NOT NULL,
  `candidate_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`candidate_id`),
  CONSTRAINT `candidates_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `courses` (
  `course_id` varchar(100) NOT NULL,
  `course_name` varchar(120) DEFAULT NULL,
  `course_description` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `people` (
  `person_id` int NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `cell_mobile_number` varchar(40) DEFAULT NULL,
  `email_address` varchar(40) DEFAULT NULL,
  `login_name` varchar(40) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `people_addresses` (
  `person_address_id` int NOT NULL,
  `person_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  PRIMARY KEY (`person_address_id`),
  KEY `address_id` (`address_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `people_addresses_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  CONSTRAINT `people_addresses_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student_course_attendance` (
  `student_id` int NOT NULL,
  `course_id` varchar(100) NOT NULL,
  `date_of_attendance` datetime DEFAULT NULL,
  PRIMARY KEY (`student_id`,`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student_course_registrations` (
  `student_id` int NOT NULL,
  `course_id` varchar(100) NOT NULL,
  `registration_date` datetime DEFAULT NULL,
  PRIMARY KEY (`student_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `student_course_registrations_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `student_course_registrations_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `students` (
  `student_id` int NOT NULL,
  `student_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
