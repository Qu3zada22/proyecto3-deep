CREATE TABLE `church` (
  `church_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `organized_by` varchar(50) DEFAULT NULL,
  `open_date` int DEFAULT NULL,
  `continuation_of` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`church_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `people` (
  `people_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `is_male` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `wedding` (
  `church_id` int NOT NULL,
  `male_id` int NOT NULL,
  `female_id` int NOT NULL,
  `year` int DEFAULT NULL,
  PRIMARY KEY (`church_id`,`male_id`,`female_id`),
  KEY `female_id` (`female_id`),
  KEY `male_id` (`male_id`),
  CONSTRAINT `wedding_ibfk_1` FOREIGN KEY (`female_id`) REFERENCES `people` (`people_id`),
  CONSTRAINT `wedding_ibfk_2` FOREIGN KEY (`male_id`) REFERENCES `people` (`people_id`),
  CONSTRAINT `wedding_ibfk_3` FOREIGN KEY (`church_id`) REFERENCES `church` (`church_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
