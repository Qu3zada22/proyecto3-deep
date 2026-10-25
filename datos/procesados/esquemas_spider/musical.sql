CREATE TABLE `actor` (
  `actor_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `musical_id` int DEFAULT NULL,
  `character` varchar(50) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`actor_id`),
  KEY `musical_id` (`musical_id`),
  CONSTRAINT `actor_ibfk_1` FOREIGN KEY (`musical_id`) REFERENCES `actor` (`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `musical` (
  `musical_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `award` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `nominee` varchar(50) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`musical_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
