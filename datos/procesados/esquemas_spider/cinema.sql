CREATE TABLE `cinema` (
  `cinema_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `openning_year` int DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cinema_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `film` (
  `film_id` int NOT NULL,
  `rank_in_series` int DEFAULT NULL,
  `number_in_season` int DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `directed_by` varchar(50) DEFAULT NULL,
  `original_air_date` varchar(50) DEFAULT NULL,
  `production_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`film_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `schedule` (
  `cinema_id` int NOT NULL,
  `film_id` int NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `show_times_per_day` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`cinema_id`,`film_id`),
  KEY `film_id` (`film_id`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`cinema_id`) REFERENCES `cinema` (`cinema_id`),
  CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
