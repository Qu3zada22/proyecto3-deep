CREATE TABLE `class` (
  `class_code` varchar(5) NOT NULL,
  `crs_code` varchar(10) DEFAULT NULL,
  `class_section` varchar(2) DEFAULT NULL,
  `class_time` varchar(20) DEFAULT NULL,
  `class_room` varchar(8) DEFAULT NULL,
  `prof_num` int DEFAULT NULL,
  PRIMARY KEY (`class_code`),
  KEY `prof_num` (`prof_num`),
  KEY `crs_code` (`crs_code`),
  CONSTRAINT `class_ibfk_1` FOREIGN KEY (`prof_num`) REFERENCES `employee` (`emp_num`),
  CONSTRAINT `class_ibfk_2` FOREIGN KEY (`crs_code`) REFERENCES `course` (`crs_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `course` (
  `crs_code` varchar(10) NOT NULL,
  `dept_code` varchar(10) DEFAULT NULL,
  `crs_description` varchar(35) DEFAULT NULL,
  `crs_credit` double DEFAULT NULL,
  PRIMARY KEY (`crs_code`),
  KEY `dept_code` (`dept_code`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dept_code`) REFERENCES `department` (`dept_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `department` (
  `dept_code` varchar(10) NOT NULL,
  `dept_name` varchar(30) DEFAULT NULL,
  `school_code` varchar(8) DEFAULT NULL,
  `emp_num` int DEFAULT NULL,
  `dept_address` varchar(20) DEFAULT NULL,
  `dept_extension` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`dept_code`),
  KEY `emp_num` (`emp_num`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`emp_num`) REFERENCES `employee` (`emp_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employee` (
  `emp_num` int NOT NULL,
  `emp_lname` varchar(15) DEFAULT NULL,
  `emp_fname` varchar(12) DEFAULT NULL,
  `emp_initial` varchar(1) DEFAULT NULL,
  `emp_jobcode` varchar(5) DEFAULT NULL,
  `emp_hiredate` varchar(50) DEFAULT NULL,
  `emp_dob` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emp_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `enroll` (
  `class_code` varchar(5) DEFAULT NULL,
  `stu_num` int DEFAULT NULL,
  `enroll_grade` varchar(50) DEFAULT NULL,
  KEY `stu_num` (`stu_num`),
  KEY `class_code` (`class_code`),
  CONSTRAINT `enroll_ibfk_1` FOREIGN KEY (`stu_num`) REFERENCES `student` (`stu_num`),
  CONSTRAINT `enroll_ibfk_2` FOREIGN KEY (`class_code`) REFERENCES `class` (`class_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `professor` (
  `emp_num` int DEFAULT NULL,
  `dept_code` varchar(10) DEFAULT NULL,
  `prof_office` varchar(50) DEFAULT NULL,
  `prof_extension` varchar(4) DEFAULT NULL,
  `prof_high_degree` varchar(5) DEFAULT NULL,
  KEY `dept_code` (`dept_code`),
  KEY `emp_num` (`emp_num`),
  CONSTRAINT `professor_ibfk_1` FOREIGN KEY (`dept_code`) REFERENCES `department` (`dept_code`),
  CONSTRAINT `professor_ibfk_2` FOREIGN KEY (`emp_num`) REFERENCES `employee` (`emp_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student` (
  `stu_num` int NOT NULL,
  `stu_lname` varchar(15) DEFAULT NULL,
  `stu_fname` varchar(15) DEFAULT NULL,
  `stu_init` varchar(1) DEFAULT NULL,
  `stu_dob` varchar(50) DEFAULT NULL,
  `stu_hrs` int DEFAULT NULL,
  `stu_class` varchar(2) DEFAULT NULL,
  `stu_gpa` double DEFAULT NULL,
  `stu_transfer` double DEFAULT NULL,
  `dept_code` varchar(10) DEFAULT NULL,
  `stu_phone` varchar(4) DEFAULT NULL,
  `prof_num` int DEFAULT NULL,
  PRIMARY KEY (`stu_num`),
  KEY `dept_code` (`dept_code`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`dept_code`) REFERENCES `department` (`dept_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
