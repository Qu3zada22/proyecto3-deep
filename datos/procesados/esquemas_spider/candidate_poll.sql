CREATE TABLE `candidate` (
  `candidate_id` int NOT NULL,
  `people_id` int DEFAULT NULL,
  `poll_source` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `support_rate` double DEFAULT NULL,
  `consider_rate` double DEFAULT NULL,
  `oppose_rate` double DEFAULT NULL,
  `unsure_rate` double DEFAULT NULL,
  PRIMARY KEY (`candidate_id`),
  KEY `people_id` (`people_id`),
  CONSTRAINT `candidate_ibfk_1` FOREIGN KEY (`people_id`) REFERENCES `people` (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `people` (
  `people_id` int NOT NULL,
  `sex` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `date_of_birth` varchar(50) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
