CREATE TABLE `club` (
  `club_id` int NOT NULL,
  `club_name` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `start_year` int DEFAULT NULL,
  PRIMARY KEY (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `coach` (
  `coach_id` int NOT NULL,
  `coach_name` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `club_id` int DEFAULT NULL,
  `rank` int DEFAULT NULL,
  PRIMARY KEY (`coach_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `coach_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `match_result` (
  `rank` int NOT NULL,
  `club_id` int NOT NULL,
  `gold` int DEFAULT NULL,
  `big_silver` int DEFAULT NULL,
  `small_silver` int DEFAULT NULL,
  `bronze` int DEFAULT NULL,
  `points` int DEFAULT NULL,
  PRIMARY KEY (`rank`,`club_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `match_result_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player` (
  `player_id` int NOT NULL,
  `sponsor_name` varchar(50) DEFAULT NULL,
  `player_name` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `residence` varchar(50) DEFAULT NULL,
  `occupation` varchar(50) DEFAULT NULL,
  `votes` int DEFAULT NULL,
  `rank` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player_coach` (
  `player_id` int NOT NULL,
  `coach_id` int NOT NULL,
  `starting_year` int DEFAULT NULL,
  PRIMARY KEY (`player_id`,`coach_id`),
  KEY `coach_id` (`coach_id`),
  CONSTRAINT `player_coach_ibfk_1` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`coach_id`),
  CONSTRAINT `player_coach_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
