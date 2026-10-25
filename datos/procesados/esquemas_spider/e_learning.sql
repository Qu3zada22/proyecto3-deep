CREATE TABLE `course_authors_and_tutors` (
  `author_id` int NOT NULL,
  `author_tutor_atb` varchar(3) DEFAULT NULL,
  `login_name` varchar(40) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `personal_name` varchar(80) DEFAULT NULL,
  `middle_name` varchar(80) DEFAULT NULL,
  `family_name` varchar(80) DEFAULT NULL,
  `gender_mf` varchar(1) DEFAULT NULL,
  `address_line_1` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `courses` (
  `course_id` int NOT NULL,
  `author_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `course_name` varchar(120) DEFAULT NULL,
  `course_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `subject_id` (`subject_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`),
  CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `course_authors_and_tutors` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student_course_enrolment` (
  `registration_id` int NOT NULL,
  `student_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `date_of_enrolment` datetime DEFAULT NULL,
  `date_of_completion` datetime DEFAULT NULL,
  PRIMARY KEY (`registration_id`),
  KEY `student_id` (`student_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `student_course_enrolment_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `student_course_enrolment_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student_tests_taken` (
  `registration_id` int DEFAULT NULL,
  `date_test_taken` datetime DEFAULT NULL,
  `test_result` varchar(255) DEFAULT NULL,
  KEY `registration_id` (`registration_id`),
  CONSTRAINT `student_tests_taken_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `student_course_enrolment` (`registration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `students` (
  `student_id` int NOT NULL,
  `date_of_registration` datetime DEFAULT NULL,
  `date_of_latest_logon` datetime DEFAULT NULL,
  `login_name` varchar(40) DEFAULT NULL,
  `password` varchar(10) DEFAULT NULL,
  `personal_name` varchar(40) DEFAULT NULL,
  `middle_name` varchar(40) DEFAULT NULL,
  `family_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `subjects` (
  `subject_id` int NOT NULL,
  `subject_name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
