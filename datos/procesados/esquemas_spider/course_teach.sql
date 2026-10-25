CREATE TABLE `course` (
  `course_id` int NOT NULL,
  `staring_date` varchar(50) DEFAULT NULL,
  `course` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `course_arrange` (
  `course_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  `grade` int NOT NULL,
  PRIMARY KEY (`course_id`,`teacher_id`,`grade`),
  KEY `teacher_id` (`teacher_id`),
  CONSTRAINT `course_arrange_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`),
  CONSTRAINT `course_arrange_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `teacher` (
  `teacher_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  `hometown` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
