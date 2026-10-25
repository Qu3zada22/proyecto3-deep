CREATE TABLE `election` (
  `election_id` int NOT NULL,
  `representative_id` int DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `votes` double DEFAULT NULL,
  `vote_percent` double DEFAULT NULL,
  `seats` double DEFAULT NULL,
  `place` double DEFAULT NULL,
  PRIMARY KEY (`election_id`),
  KEY `representative_id` (`representative_id`),
  CONSTRAINT `election_ibfk_1` FOREIGN KEY (`representative_id`) REFERENCES `representative` (`representative_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `representative` (
  `representative_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `party` varchar(50) DEFAULT NULL,
  `lifespan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`representative_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
