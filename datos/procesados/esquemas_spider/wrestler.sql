CREATE TABLE `elimination` (
  `elimination_id` varchar(50) NOT NULL,
  `wrestler_id` int DEFAULT NULL,
  `team` varchar(50) DEFAULT NULL,
  `eliminated_by` varchar(50) DEFAULT NULL,
  `elimination_move` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`elimination_id`),
  KEY `wrestler_id` (`wrestler_id`),
  CONSTRAINT `elimination_ibfk_1` FOREIGN KEY (`wrestler_id`) REFERENCES `wrestler` (`wrestler_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `wrestler` (
  `wrestler_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `reign` varchar(50) DEFAULT NULL,
  `days_held` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `event` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`wrestler_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
