CREATE TABLE `movie` (
  `mid` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `director` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `rating` (
  `rid` int DEFAULT NULL,
  `mid` int DEFAULT NULL,
  `stars` int DEFAULT NULL,
  `ratingdate` date DEFAULT NULL,
  KEY `rid` (`rid`),
  KEY `mid` (`mid`),
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `reviewer` (`rid`),
  CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`mid`) REFERENCES `movie` (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `reviewer` (
  `rid` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
