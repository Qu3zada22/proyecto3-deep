CREATE TABLE `entrepreneur` (
  `entrepreneur_id` int NOT NULL,
  `people_id` int DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `money_requested` double DEFAULT NULL,
  `investor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`entrepreneur_id`),
  KEY `people_id` (`people_id`),
  CONSTRAINT `entrepreneur_ibfk_1` FOREIGN KEY (`people_id`) REFERENCES `people` (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `people` (
  `people_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `date_of_birth` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
