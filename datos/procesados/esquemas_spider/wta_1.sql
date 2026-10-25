CREATE TABLE `matches` (
  `best_of` int DEFAULT NULL,
  `draw_size` int DEFAULT NULL,
  `loser_age` double DEFAULT NULL,
  `loser_entry` varchar(50) DEFAULT NULL,
  `loser_hand` varchar(50) DEFAULT NULL,
  `loser_ht` int DEFAULT NULL,
  `loser_id` int DEFAULT NULL,
  `loser_ioc` varchar(50) DEFAULT NULL,
  `loser_name` varchar(50) DEFAULT NULL,
  `loser_rank` int DEFAULT NULL,
  `loser_rank_points` int DEFAULT NULL,
  `loser_seed` int DEFAULT NULL,
  `match_num` int DEFAULT NULL,
  `minutes` int DEFAULT NULL,
  `round` varchar(50) DEFAULT NULL,
  `score` varchar(50) DEFAULT NULL,
  `surface` varchar(50) DEFAULT NULL,
  `tourney_date` varchar(50) DEFAULT NULL,
  `tourney_id` varchar(50) DEFAULT NULL,
  `tourney_level` varchar(50) DEFAULT NULL,
  `tourney_name` varchar(50) DEFAULT NULL,
  `winner_age` double DEFAULT NULL,
  `winner_entry` varchar(50) DEFAULT NULL,
  `winner_hand` varchar(50) DEFAULT NULL,
  `winner_ht` int DEFAULT NULL,
  `winner_id` int DEFAULT NULL,
  `winner_ioc` varchar(50) DEFAULT NULL,
  `winner_name` varchar(50) DEFAULT NULL,
  `winner_rank` int DEFAULT NULL,
  `winner_rank_points` int DEFAULT NULL,
  `winner_seed` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  KEY `winner_id` (`winner_id`),
  KEY `loser_id` (`loser_id`),
  CONSTRAINT `matches_ibfk_1` FOREIGN KEY (`winner_id`) REFERENCES `players` (`player_id`),
  CONSTRAINT `matches_ibfk_2` FOREIGN KEY (`loser_id`) REFERENCES `players` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `players` (
  `player_id` int NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `hand` varchar(50) DEFAULT NULL,
  `birth_date` varchar(50) DEFAULT NULL,
  `country_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `rankings` (
  `ranking_date` varchar(50) DEFAULT NULL,
  `ranking` int DEFAULT NULL,
  `player_id` int DEFAULT NULL,
  `ranking_points` int DEFAULT NULL,
  `tours` int DEFAULT NULL,
  KEY `player_id` (`player_id`),
  CONSTRAINT `rankings_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
