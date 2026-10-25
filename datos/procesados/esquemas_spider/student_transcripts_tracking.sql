CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `line_1` varchar(255) DEFAULT NULL,
  `line_2` varchar(255) DEFAULT NULL,
  `line_3` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip_postcode` varchar(20) DEFAULT NULL,
  `state_province_county` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `other_address_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `courses` (
  `course_id` int NOT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `course_description` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `degree_programs` (
  `degree_program_id` int NOT NULL,
  `department_id` int DEFAULT NULL,
  `degree_summary_name` varchar(255) DEFAULT NULL,
  `degree_summary_description` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`degree_program_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `degree_programs_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `departments` (
  `department_id` int NOT NULL,
  `department_name` varchar(255) DEFAULT NULL,
  `department_description` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sections` (
  `section_id` int NOT NULL,
  `course_id` int DEFAULT NULL,
  `section_name` varchar(255) DEFAULT NULL,
  `section_description` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `semesters` (
  `semester_id` int NOT NULL,
  `semester_name` varchar(255) DEFAULT NULL,
  `semester_description` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`semester_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student_enrolment` (
  `student_enrolment_id` int NOT NULL,
  `degree_program_id` int DEFAULT NULL,
  `semester_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_enrolment_id`),
  KEY `student_id` (`student_id`),
  KEY `semester_id` (`semester_id`),
  KEY `degree_program_id` (`degree_program_id`),
  CONSTRAINT `student_enrolment_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `student_enrolment_ibfk_2` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`semester_id`),
  CONSTRAINT `student_enrolment_ibfk_3` FOREIGN KEY (`degree_program_id`) REFERENCES `degree_programs` (`degree_program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student_enrolment_courses` (
  `student_course_id` int NOT NULL,
  `course_id` int DEFAULT NULL,
  `student_enrolment_id` int DEFAULT NULL,
  PRIMARY KEY (`student_course_id`),
  KEY `student_enrolment_id` (`student_enrolment_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `student_enrolment_courses_ibfk_1` FOREIGN KEY (`student_enrolment_id`) REFERENCES `student_enrolment` (`student_enrolment_id`),
  CONSTRAINT `student_enrolment_courses_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `students` (
  `student_id` int NOT NULL,
  `current_address_id` int DEFAULT NULL,
  `permanent_address_id` int DEFAULT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `middle_name` varchar(40) DEFAULT NULL,
  `last_name` varchar(40) DEFAULT NULL,
  `cell_mobile_number` varchar(40) DEFAULT NULL,
  `email_address` varchar(40) DEFAULT NULL,
  `ssn` varchar(40) DEFAULT NULL,
  `date_first_registered` datetime DEFAULT NULL,
  `date_left` datetime DEFAULT NULL,
  `other_student_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `permanent_address_id` (`permanent_address_id`),
  KEY `current_address_id` (`current_address_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`permanent_address_id`) REFERENCES `addresses` (`address_id`),
  CONSTRAINT `students_ibfk_2` FOREIGN KEY (`current_address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transcript_contents` (
  `student_course_id` int DEFAULT NULL,
  `transcript_id` int DEFAULT NULL,
  KEY `transcript_id` (`transcript_id`),
  KEY `student_course_id` (`student_course_id`),
  CONSTRAINT `transcript_contents_ibfk_1` FOREIGN KEY (`transcript_id`) REFERENCES `transcripts` (`transcript_id`),
  CONSTRAINT `transcript_contents_ibfk_2` FOREIGN KEY (`student_course_id`) REFERENCES `student_enrolment_courses` (`student_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transcripts` (
  `transcript_id` int NOT NULL,
  `transcript_date` datetime DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transcript_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
