CREATE TABLE `architect` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `bridge` (
  `architect_id` varchar(50) DEFAULT NULL,
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `length_meters` double DEFAULT NULL,
  `length_feet` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `architect_id` (`architect_id`),
  CONSTRAINT `bridge_ibfk_1` FOREIGN KEY (`architect_id`) REFERENCES `architect` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mill` (
  `architect_id` varchar(50) DEFAULT NULL,
  `id` int NOT NULL,
  `location` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `built_year` int DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `architect_id` (`architect_id`),
  CONSTRAINT `mill_ibfk_1` FOREIGN KEY (`architect_id`) REFERENCES `architect` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
