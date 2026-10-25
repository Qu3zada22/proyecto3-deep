CREATE TABLE `battle` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `bulgarian_commander` varchar(50) DEFAULT NULL,
  `latin_commander` varchar(50) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `death` (
  `caused_by_ship_id` int DEFAULT NULL,
  `id` int NOT NULL,
  `note` varchar(50) DEFAULT NULL,
  `killed` int DEFAULT NULL,
  `injured` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `caused_by_ship_id` (`caused_by_ship_id`),
  CONSTRAINT `death_ibfk_1` FOREIGN KEY (`caused_by_ship_id`) REFERENCES `ship` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ship` (
  `lost_in_battle` int DEFAULT NULL,
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `tonnage` varchar(50) DEFAULT NULL,
  `ship_type` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `disposition_of_ship` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lost_in_battle` (`lost_in_battle`),
  CONSTRAINT `ship_ibfk_1` FOREIGN KEY (`lost_in_battle`) REFERENCES `battle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
