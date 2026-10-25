CREATE TABLE `race` (
  `race_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `track_id` int DEFAULT NULL,
  PRIMARY KEY (`race_id`),
  KEY `track_id` (`track_id`),
  CONSTRAINT `race_ibfk_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `track` (
  `track_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `seating` double DEFAULT NULL,
  `year_opened` double DEFAULT NULL,
  PRIMARY KEY (`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
