CREATE TABLE `climber` (
  `climber_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `points` double DEFAULT NULL,
  `mountain_id` int DEFAULT NULL,
  PRIMARY KEY (`climber_id`),
  KEY `mountain_id` (`mountain_id`),
  CONSTRAINT `climber_ibfk_1` FOREIGN KEY (`mountain_id`) REFERENCES `mountain` (`mountain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mountain` (
  `mountain_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `prominence` double DEFAULT NULL,
  `range` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mountain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
