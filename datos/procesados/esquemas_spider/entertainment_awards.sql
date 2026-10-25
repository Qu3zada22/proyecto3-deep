CREATE TABLE `artwork` (
  `artwork_id` int NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`artwork_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `festival_detail` (
  `festival_id` int NOT NULL,
  `festival_name` varchar(50) DEFAULT NULL,
  `chair_name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `num_of_audience` int DEFAULT NULL,
  PRIMARY KEY (`festival_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `nomination` (
  `artwork_id` int NOT NULL,
  `festival_id` int NOT NULL,
  `result` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`artwork_id`,`festival_id`),
  KEY `festival_id` (`festival_id`),
  CONSTRAINT `nomination_ibfk_1` FOREIGN KEY (`festival_id`) REFERENCES `festival_detail` (`festival_id`),
  CONSTRAINT `nomination_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artwork` (`artwork_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
