CREATE TABLE `member` (
  `member_id` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `member_attendance` (
  `member_id` varchar(50) NOT NULL,
  `performance_id` double NOT NULL,
  `num_of_pieces` int DEFAULT NULL,
  PRIMARY KEY (`member_id`,`performance_id`),
  KEY `performance_id` (`performance_id`),
  CONSTRAINT `member_attendance_ibfk_1` FOREIGN KEY (`performance_id`) REFERENCES `performance` (`performance_id`),
  CONSTRAINT `member_attendance_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `performance` (
  `performance_id` double NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `host` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `attendance` int DEFAULT NULL,
  PRIMARY KEY (`performance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
