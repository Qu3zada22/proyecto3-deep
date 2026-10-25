CREATE TABLE `concert` (
  `concert_id` int NOT NULL,
  `concert_name` varchar(50) DEFAULT NULL,
  `theme` varchar(50) DEFAULT NULL,
  `stadium_id` int DEFAULT NULL,
  `year` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`concert_id`),
  KEY `stadium_id` (`stadium_id`),
  CONSTRAINT `concert_ibfk_1` FOREIGN KEY (`stadium_id`) REFERENCES `stadium` (`stadium_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `singer` (
  `singer_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `song_name` varchar(50) DEFAULT NULL,
  `song_release_year` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `is_male` int DEFAULT NULL,
  PRIMARY KEY (`singer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `singer_in_concert` (
  `concert_id` int NOT NULL,
  `singer_id` int NOT NULL,
  PRIMARY KEY (`concert_id`,`singer_id`),
  KEY `singer_id` (`singer_id`),
  CONSTRAINT `singer_in_concert_ibfk_1` FOREIGN KEY (`singer_id`) REFERENCES `singer` (`singer_id`),
  CONSTRAINT `singer_in_concert_ibfk_2` FOREIGN KEY (`concert_id`) REFERENCES `concert` (`concert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `stadium` (
  `stadium_id` int NOT NULL,
  `location` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `highest` int DEFAULT NULL,
  `lowest` int DEFAULT NULL,
  `average` int DEFAULT NULL,
  PRIMARY KEY (`stadium_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
