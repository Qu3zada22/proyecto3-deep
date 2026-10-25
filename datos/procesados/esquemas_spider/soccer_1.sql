CREATE TABLE `country` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `league` (
  `id` int NOT NULL,
  `country_id` int DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `league_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player` (
  `id` int NOT NULL,
  `player_api_id` int DEFAULT NULL,
  `player_name` varchar(50) DEFAULT NULL,
  `player_fifa_api_id` int DEFAULT NULL,
  `birthday` varchar(50) DEFAULT NULL,
  `height` int DEFAULT NULL,
  `weight` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player_attributes` (
  `id` int NOT NULL,
  `player_fifa_api_id` int DEFAULT NULL,
  `player_api_id` int DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `overall_rating` int DEFAULT NULL,
  `potential` int DEFAULT NULL,
  `preferred_foot` varchar(50) DEFAULT NULL,
  `attacking_work_rate` varchar(50) DEFAULT NULL,
  `defensive_work_rate` varchar(50) DEFAULT NULL,
  `crossing` int DEFAULT NULL,
  `finishing` int DEFAULT NULL,
  `heading_accuracy` int DEFAULT NULL,
  `short_passing` int DEFAULT NULL,
  `volleys` int DEFAULT NULL,
  `dribbling` int DEFAULT NULL,
  `curve` int DEFAULT NULL,
  `free_kick_accuracy` int DEFAULT NULL,
  `long_passing` int DEFAULT NULL,
  `ball_control` int DEFAULT NULL,
  `acceleration` int DEFAULT NULL,
  `sprint_speed` int DEFAULT NULL,
  `agility` int DEFAULT NULL,
  `reactions` int DEFAULT NULL,
  `balance` int DEFAULT NULL,
  `shot_power` int DEFAULT NULL,
  `jumping` int DEFAULT NULL,
  `stamina` int DEFAULT NULL,
  `strength` int DEFAULT NULL,
  `long_shots` int DEFAULT NULL,
  `aggression` int DEFAULT NULL,
  `interceptions` int DEFAULT NULL,
  `positioning` int DEFAULT NULL,
  `vision` int DEFAULT NULL,
  `penalties` int DEFAULT NULL,
  `marking` int DEFAULT NULL,
  `standing_tackle` int DEFAULT NULL,
  `sliding_tackle` int DEFAULT NULL,
  `gk_diving` int DEFAULT NULL,
  `gk_handling` int DEFAULT NULL,
  `gk_kicking` int DEFAULT NULL,
  `gk_positioning` int DEFAULT NULL,
  `gk_reflexes` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `team` (
  `id` int NOT NULL,
  `team_api_id` int DEFAULT NULL,
  `team_fifa_api_id` int DEFAULT NULL,
  `team_long_name` varchar(50) DEFAULT NULL,
  `team_short_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `team_attributes` (
  `id` int NOT NULL,
  `team_fifa_api_id` int DEFAULT NULL,
  `team_api_id` int DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `buildupplayspeed` int DEFAULT NULL,
  `buildupplayspeedclass` varchar(50) DEFAULT NULL,
  `buildupplaydribbling` int DEFAULT NULL,
  `buildupplaydribblingclass` varchar(50) DEFAULT NULL,
  `buildupplaypassing` int DEFAULT NULL,
  `buildupplaypassingclass` varchar(50) DEFAULT NULL,
  `buildupplaypositioningclass` varchar(50) DEFAULT NULL,
  `chancecreationpassing` int DEFAULT NULL,
  `chancecreationpassingclass` varchar(50) DEFAULT NULL,
  `chancecreationcrossing` int DEFAULT NULL,
  `chancecreationcrossingclass` varchar(50) DEFAULT NULL,
  `chancecreationshooting` int DEFAULT NULL,
  `chancecreationshootingclass` varchar(50) DEFAULT NULL,
  `chancecreationpositioningclass` varchar(50) DEFAULT NULL,
  `defencepressure` int DEFAULT NULL,
  `defencepressureclass` varchar(50) DEFAULT NULL,
  `defenceaggression` int DEFAULT NULL,
  `defenceaggressionclass` varchar(50) DEFAULT NULL,
  `defenceteamwidth` int DEFAULT NULL,
  `defenceteamwidthclass` varchar(50) DEFAULT NULL,
  `defencedefenderlineclass` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
