CREATE TABLE `advisor` (
  `s_id` varchar(5) NOT NULL,
  `i_id` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`s_id`),
  KEY `i_id` (`i_id`),
  CONSTRAINT `advisor_ibfk_1` FOREIGN KEY (`s_id`) REFERENCES `student` (`id`),
  CONSTRAINT `advisor_ibfk_2` FOREIGN KEY (`i_id`) REFERENCES `instructor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `classroom` (
  `building` varchar(15) NOT NULL,
  `room_number` varchar(7) NOT NULL,
  `capacity` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`building`,`room_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `course` (
  `course_id` varchar(8) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `credits` decimal(2,0) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `department` (
  `dept_name` varchar(20) NOT NULL,
  `building` varchar(15) DEFAULT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `instructor` (
  `id` varchar(5) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `instructor_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `prereq` (
  `course_id` varchar(8) NOT NULL,
  `prereq_id` varchar(8) NOT NULL,
  PRIMARY KEY (`course_id`,`prereq_id`),
  KEY `prereq_id` (`prereq_id`),
  CONSTRAINT `prereq_ibfk_1` FOREIGN KEY (`prereq_id`) REFERENCES `course` (`course_id`),
  CONSTRAINT `prereq_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `section` (
  `course_id` varchar(8) NOT NULL,
  `sec_id` varchar(8) NOT NULL,
  `semester` varchar(6) NOT NULL,
  `year` decimal(4,0) NOT NULL,
  `building` varchar(15) DEFAULT NULL,
  `room_number` varchar(7) DEFAULT NULL,
  `time_slot_id` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`course_id`,`sec_id`,`semester`,`year`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student` (
  `id` varchar(5) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `dept_name` varchar(20) DEFAULT NULL,
  `tot_cred` decimal(3,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `takes` (
  `id` varchar(5) NOT NULL,
  `course_id` varchar(8) NOT NULL,
  `sec_id` varchar(8) NOT NULL,
  `semester` varchar(6) NOT NULL,
  `year` decimal(4,0) NOT NULL,
  `grade` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`,`course_id`,`sec_id`,`semester`,`year`),
  CONSTRAINT `takes_ibfk_1` FOREIGN KEY (`id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `teaches` (
  `id` varchar(5) NOT NULL,
  `course_id` varchar(8) NOT NULL,
  `sec_id` varchar(8) NOT NULL,
  `semester` varchar(6) NOT NULL,
  `year` decimal(4,0) NOT NULL,
  PRIMARY KEY (`id`,`course_id`,`sec_id`,`semester`,`year`),
  CONSTRAINT `teaches_ibfk_1` FOREIGN KEY (`id`) REFERENCES `instructor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `time_slot` (
  `time_slot_id` varchar(4) NOT NULL,
  `day` varchar(1) NOT NULL,
  `start_hr` double NOT NULL,
  `start_min` double NOT NULL,
  `end_hr` double DEFAULT NULL,
  `end_min` double DEFAULT NULL,
  PRIMARY KEY (`time_slot_id`,`day`,`start_hr`,`start_min`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
