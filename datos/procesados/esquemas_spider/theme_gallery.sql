CREATE TABLE `artist` (
  `artist_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `year_join` int DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `exhibition` (
  `exhibition_id` int NOT NULL,
  `year` int DEFAULT NULL,
  `theme` varchar(50) DEFAULT NULL,
  `artist_id` int DEFAULT NULL,
  `ticket_price` double DEFAULT NULL,
  PRIMARY KEY (`exhibition_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `exhibition_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `exhibition_record` (
  `exhibition_id` int NOT NULL,
  `date` varchar(50) NOT NULL,
  `attendance` int DEFAULT NULL,
  PRIMARY KEY (`exhibition_id`,`date`),
  CONSTRAINT `exhibition_record_ibfk_1` FOREIGN KEY (`exhibition_id`) REFERENCES `exhibition` (`exhibition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
