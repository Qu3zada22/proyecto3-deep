CREATE TABLE `event` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `stadium_id` int DEFAULT NULL,
  `year` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stadium_id` (`stadium_id`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`stadium_id`) REFERENCES `stadium` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `record` (
  `id` int DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  `swimmer_id` int NOT NULL,
  `event_id` int NOT NULL,
  PRIMARY KEY (`swimmer_id`,`event_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `record_ibfk_1` FOREIGN KEY (`swimmer_id`) REFERENCES `swimmer` (`id`),
  CONSTRAINT `record_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `stadium` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `opening_year` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `swimmer` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `meter_100` double DEFAULT NULL,
  `meter_200` varchar(50) DEFAULT NULL,
  `meter_300` varchar(50) DEFAULT NULL,
  `meter_400` varchar(50) DEFAULT NULL,
  `meter_500` varchar(50) DEFAULT NULL,
  `meter_600` varchar(50) DEFAULT NULL,
  `meter_700` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
