CREATE TABLE `country` (
  `country_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `population` int DEFAULT NULL,
  `area` int DEFAULT NULL,
  `languages` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `roller_coaster` (
  `roller_coaster_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `park` varchar(50) DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `length` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `speed` varchar(50) DEFAULT NULL,
  `opened` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`roller_coaster_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `roller_coaster_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
