CREATE TABLE `body_builder` (
  `body_builder_id` int NOT NULL,
  `people_id` int DEFAULT NULL,
  `snatch` double DEFAULT NULL,
  `clean_jerk` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`body_builder_id`),
  KEY `people_id` (`people_id`),
  CONSTRAINT `body_builder_ibfk_1` FOREIGN KEY (`people_id`) REFERENCES `people` (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `people` (
  `people_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `birth_date` varchar(50) DEFAULT NULL,
  `birth_place` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
