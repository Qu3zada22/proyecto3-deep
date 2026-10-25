CREATE TABLE `captain` (
  `captain_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ship_id` int DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `rank` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`captain_id`),
  KEY `ship_id` (`ship_id`),
  CONSTRAINT `captain_ibfk_1` FOREIGN KEY (`ship_id`) REFERENCES `ship` (`ship_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ship` (
  `ship_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `built_year` double DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `flag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ship_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
