CREATE TABLE `event` (
  `event_id` int NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `venue` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `event_attendance` int DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `journalist` (
  `journalist_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  `years_working` int DEFAULT NULL,
  PRIMARY KEY (`journalist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `news_report` (
  `journalist_id` int NOT NULL,
  `event_id` int NOT NULL,
  `work_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`journalist_id`,`event_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `news_report_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  CONSTRAINT `news_report_ibfk_2` FOREIGN KEY (`journalist_id`) REFERENCES `journalist` (`journalist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
