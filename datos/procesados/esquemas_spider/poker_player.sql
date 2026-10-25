CREATE TABLE `people` (
  `people_id` int NOT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `birth_date` varchar(50) DEFAULT NULL,
  `height` double DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `poker_player` (
  `poker_player_id` int NOT NULL,
  `people_id` int DEFAULT NULL,
  `final_table_made` double DEFAULT NULL,
  `best_finish` double DEFAULT NULL,
  `money_rank` double DEFAULT NULL,
  `earnings` double DEFAULT NULL,
  PRIMARY KEY (`poker_player_id`),
  KEY `people_id` (`people_id`),
  CONSTRAINT `poker_player_ibfk_1` FOREIGN KEY (`people_id`) REFERENCES `people` (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
