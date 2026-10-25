CREATE TABLE `college` (
  `college_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `leader_name` varchar(50) DEFAULT NULL,
  `college_location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`college_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `member` (
  `member_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `college_id` int DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  KEY `college_id` (`college_id`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `round` (
  `round_id` int NOT NULL,
  `member_id` int NOT NULL,
  `decoration_theme` varchar(50) DEFAULT NULL,
  `rank_in_round` int DEFAULT NULL,
  PRIMARY KEY (`member_id`,`round_id`),
  CONSTRAINT `round_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
