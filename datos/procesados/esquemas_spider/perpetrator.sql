CREATE TABLE `people` (
  `people_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `home town` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `perpetrator` (
  `perpetrator_id` int NOT NULL,
  `people_id` int DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `year` double DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `killed` int DEFAULT NULL,
  `injured` int DEFAULT NULL,
  PRIMARY KEY (`perpetrator_id`),
  KEY `people_id` (`people_id`),
  CONSTRAINT `perpetrator_ibfk_1` FOREIGN KEY (`people_id`) REFERENCES `people` (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
