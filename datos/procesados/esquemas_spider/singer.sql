CREATE TABLE `singer` (
  `singer_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `birth_year` double DEFAULT NULL,
  `net_worth_millions` double DEFAULT NULL,
  `citizenship` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`singer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `song` (
  `song_id` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `singer_id` int DEFAULT NULL,
  `sales` double DEFAULT NULL,
  `highest_position` double DEFAULT NULL,
  PRIMARY KEY (`song_id`),
  KEY `singer_id` (`singer_id`),
  CONSTRAINT `song_ibfk_1` FOREIGN KEY (`singer_id`) REFERENCES `singer` (`singer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
