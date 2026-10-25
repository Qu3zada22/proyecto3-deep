CREATE TABLE `broadcast` (
  `channel_id` int NOT NULL,
  `program_id` int NOT NULL,
  `time_of_day` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`channel_id`,`program_id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `broadcast_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `broadcast_ibfk_2` FOREIGN KEY (`channel_id`) REFERENCES `channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `broadcast_share` (
  `channel_id` int NOT NULL,
  `program_id` int NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `share_in_percent` double DEFAULT NULL,
  PRIMARY KEY (`channel_id`,`program_id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `broadcast_share_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `broadcast_share_ibfk_2` FOREIGN KEY (`channel_id`) REFERENCES `channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `channel` (
  `channel_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `share_in_percent` double DEFAULT NULL,
  `rating_in_percent` double DEFAULT NULL,
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `program` (
  `program_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `launch` double DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
