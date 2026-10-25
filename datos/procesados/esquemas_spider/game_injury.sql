CREATE TABLE `game` (
  `stadium_id` int DEFAULT NULL,
  `id` int NOT NULL,
  `season` int DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `home_team` varchar(50) DEFAULT NULL,
  `away_team` varchar(50) DEFAULT NULL,
  `score` varchar(50) DEFAULT NULL,
  `competition` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stadium_id` (`stadium_id`),
  CONSTRAINT `game_ibfk_1` FOREIGN KEY (`stadium_id`) REFERENCES `stadium` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `injury_accident` (
  `game_id` int DEFAULT NULL,
  `id` int NOT NULL,
  `player` varchar(50) DEFAULT NULL,
  `injury` varchar(50) DEFAULT NULL,
  `number_of_matches` varchar(50) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `injury_accident_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `stadium` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `home_games` int DEFAULT NULL,
  `average_attendance` double DEFAULT NULL,
  `total_attendance` double DEFAULT NULL,
  `capacity_percentage` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
