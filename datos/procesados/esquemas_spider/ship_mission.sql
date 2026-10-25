CREATE TABLE `mission` (
  `mission_id` int NOT NULL,
  `ship_id` int DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `launched_year` int DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `speed_knots` int DEFAULT NULL,
  `fate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mission_id`),
  KEY `ship_id` (`ship_id`),
  CONSTRAINT `mission_ibfk_1` FOREIGN KEY (`ship_id`) REFERENCES `ship` (`ship_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ship` (
  `ship_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `tonnage` int DEFAULT NULL,
  PRIMARY KEY (`ship_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
