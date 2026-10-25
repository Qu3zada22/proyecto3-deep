CREATE TABLE `basketball_match` (
  `team_id` int NOT NULL,
  `school_id` int DEFAULT NULL,
  `team_name` varchar(50) DEFAULT NULL,
  `acc_regular_season` varchar(50) DEFAULT NULL,
  `acc_percent` varchar(50) DEFAULT NULL,
  `acc_home` varchar(50) DEFAULT NULL,
  `acc_road` varchar(50) DEFAULT NULL,
  `all_games` varchar(50) DEFAULT NULL,
  `all_games_percent` int DEFAULT NULL,
  `all_home` varchar(50) DEFAULT NULL,
  `all_road` varchar(50) DEFAULT NULL,
  `all_neutral` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`team_id`),
  KEY `school_id` (`school_id`),
  CONSTRAINT `basketball_match_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `university` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `university` (
  `school_id` int NOT NULL,
  `school` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `founded` double DEFAULT NULL,
  `affiliation` varchar(50) DEFAULT NULL,
  `enrollment` double DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `primary_conference` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
