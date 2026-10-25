CREATE TABLE `acceptance` (
  `submission_id` int NOT NULL,
  `workshop_id` int NOT NULL,
  `result` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`submission_id`,`workshop_id`),
  KEY `workshop_id` (`workshop_id`),
  CONSTRAINT `acceptance_ibfk_1` FOREIGN KEY (`workshop_id`) REFERENCES `workshop` (`workshop_id`),
  CONSTRAINT `acceptance_ibfk_2` FOREIGN KEY (`submission_id`) REFERENCES `submission` (`submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `submission` (
  `submission_id` int NOT NULL,
  `scores` double DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `college` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `workshop` (
  `workshop_id` int NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `venue` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`workshop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
