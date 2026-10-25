CREATE TABLE `area_code_state` (
  `area_code` int NOT NULL,
  `state` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`area_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `contestants` (
  `contestant_number` int NOT NULL,
  `contestant_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`contestant_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `votes` (
  `vote_id` int NOT NULL,
  `phone_number` bigint DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `contestant_number` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`vote_id`),
  KEY `contestant_number` (`contestant_number`),
  CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`contestant_number`) REFERENCES `contestants` (`contestant_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
