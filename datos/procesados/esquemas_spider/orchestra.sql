CREATE TABLE `conductor` (
  `conductor_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `year_of_work` int DEFAULT NULL,
  PRIMARY KEY (`conductor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `orchestra` (
  `orchestra_id` int NOT NULL,
  `orchestra` varchar(50) DEFAULT NULL,
  `conductor_id` int DEFAULT NULL,
  `record_company` varchar(50) DEFAULT NULL,
  `year_of_founded` double DEFAULT NULL,
  `major_record_format` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`orchestra_id`),
  KEY `conductor_id` (`conductor_id`),
  CONSTRAINT `orchestra_ibfk_1` FOREIGN KEY (`conductor_id`) REFERENCES `conductor` (`conductor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `performance` (
  `performance_id` int NOT NULL,
  `orchestra_id` int DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `official_ratings_(millions)` double DEFAULT NULL,
  `weekly_rank` varchar(50) DEFAULT NULL,
  `share` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`performance_id`),
  KEY `orchestra_id` (`orchestra_id`),
  CONSTRAINT `performance_ibfk_1` FOREIGN KEY (`orchestra_id`) REFERENCES `orchestra` (`orchestra_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `show` (
  `show_id` int DEFAULT NULL,
  `performance_id` int DEFAULT NULL,
  `if_first_show` int DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  `attendance` double DEFAULT NULL,
  KEY `performance_id` (`performance_id`),
  CONSTRAINT `show_ibfk_1` FOREIGN KEY (`performance_id`) REFERENCES `performance` (`performance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
