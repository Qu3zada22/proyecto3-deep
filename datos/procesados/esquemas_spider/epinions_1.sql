CREATE TABLE `item` (
  `i_id` int NOT NULL,
  `title` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`i_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `review` (
  `a_id` int NOT NULL,
  `u_id` int DEFAULT NULL,
  `i_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `rank` int DEFAULT NULL,
  PRIMARY KEY (`a_id`),
  KEY `i_id` (`i_id`),
  KEY `u_id` (`u_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`i_id`) REFERENCES `item` (`i_id`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `useracct` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `trust` (
  `source_u_id` int DEFAULT NULL,
  `target_u_id` int DEFAULT NULL,
  `trust` int DEFAULT NULL,
  KEY `target_u_id` (`target_u_id`),
  KEY `source_u_id` (`source_u_id`),
  CONSTRAINT `trust_ibfk_1` FOREIGN KEY (`target_u_id`) REFERENCES `useracct` (`u_id`),
  CONSTRAINT `trust_ibfk_2` FOREIGN KEY (`source_u_id`) REFERENCES `useracct` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `useracct` (
  `u_id` int NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
