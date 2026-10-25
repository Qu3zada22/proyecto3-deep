CREATE TABLE `museum` (
  `museum_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `num_of_staff` int DEFAULT NULL,
  `open_year` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`museum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `visit` (
  `museum_id` int NOT NULL,
  `visitor_id` int NOT NULL,
  `num_of_ticket` int DEFAULT NULL,
  `total_spent` double DEFAULT NULL,
  PRIMARY KEY (`museum_id`,`visitor_id`),
  KEY `visitor_id` (`visitor_id`),
  CONSTRAINT `visit_ibfk_1` FOREIGN KEY (`visitor_id`) REFERENCES `visitor` (`id`),
  CONSTRAINT `visit_ibfk_2` FOREIGN KEY (`museum_id`) REFERENCES `museum` (`museum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `visitor` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `level_of_membership` int DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
