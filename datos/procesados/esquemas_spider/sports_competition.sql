CREATE TABLE `club` (
  `club_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `start_year` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `club_rank` (
  `rank` double NOT NULL,
  `club_id` int NOT NULL,
  `gold` double DEFAULT NULL,
  `silver` double DEFAULT NULL,
  `bronze` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`rank`,`club_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `club_rank_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `competition` (
  `competition_id` int NOT NULL,
  `year` double DEFAULT NULL,
  `competition_type` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`competition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `competition_result` (
  `competition_id` int NOT NULL,
  `club_id_1` int NOT NULL,
  `club_id_2` int NOT NULL,
  `score` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`competition_id`,`club_id_1`,`club_id_2`),
  KEY `club_id_2` (`club_id_2`),
  KEY `club_id_1` (`club_id_1`),
  CONSTRAINT `competition_result_ibfk_1` FOREIGN KEY (`competition_id`) REFERENCES `competition` (`competition_id`),
  CONSTRAINT `competition_result_ibfk_2` FOREIGN KEY (`club_id_2`) REFERENCES `club` (`club_id`),
  CONSTRAINT `competition_result_ibfk_3` FOREIGN KEY (`club_id_1`) REFERENCES `club` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player` (
  `player_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `club_id` int DEFAULT NULL,
  `apps` double DEFAULT NULL,
  `tries` double DEFAULT NULL,
  `goals` varchar(50) DEFAULT NULL,
  `points` double DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
