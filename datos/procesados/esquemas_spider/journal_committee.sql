CREATE TABLE `editor` (
  `editor_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` double DEFAULT NULL,
  PRIMARY KEY (`editor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `journal` (
  `journal_id` int NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `theme` varchar(50) DEFAULT NULL,
  `sales` int DEFAULT NULL,
  PRIMARY KEY (`journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `journal_committee` (
  `editor_id` int NOT NULL,
  `journal_id` int NOT NULL,
  `work_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`editor_id`,`journal_id`),
  KEY `journal_id` (`journal_id`),
  CONSTRAINT `journal_committee_ibfk_1` FOREIGN KEY (`journal_id`) REFERENCES `journal` (`journal_id`),
  CONSTRAINT `journal_committee_ibfk_2` FOREIGN KEY (`editor_id`) REFERENCES `editor` (`editor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
