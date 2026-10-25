CREATE TABLE `country` (
  `country_id` int NOT NULL,
  `country_name` varchar(50) DEFAULT NULL,
  `capital` varchar(50) DEFAULT NULL,
  `official_native_language` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `match_season` (
  `season` double NOT NULL,
  `player` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `country` int DEFAULT NULL,
  `team` int DEFAULT NULL,
  `draft_pick_number` int DEFAULT NULL,
  `draft_class` varchar(50) DEFAULT NULL,
  `college` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`season`),
  KEY `team` (`team`),
  KEY `country` (`country`),
  CONSTRAINT `match_season_ibfk_1` FOREIGN KEY (`team`) REFERENCES `team` (`team_id`),
  CONSTRAINT `match_season_ibfk_2` FOREIGN KEY (`country`) REFERENCES `country` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player` (
  `player_id` int NOT NULL,
  `player` varchar(50) DEFAULT NULL,
  `years_played` varchar(50) DEFAULT NULL,
  `total_wl` varchar(50) DEFAULT NULL,
  `singles_wl` varchar(50) DEFAULT NULL,
  `doubles_wl` varchar(50) DEFAULT NULL,
  `team` int DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  KEY `team` (`team`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`team`) REFERENCES `team` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `team` (
  `team_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
