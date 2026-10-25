CREATE TABLE `person` (
  `name` varchar(20) NOT NULL,
  `age` int DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `job` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `personfriend` (
  `name` varchar(20) DEFAULT NULL,
  `friend` varchar(20) DEFAULT NULL,
  `year` int DEFAULT NULL,
  KEY `friend` (`friend`),
  KEY `name` (`name`),
  CONSTRAINT `personfriend_ibfk_1` FOREIGN KEY (`friend`) REFERENCES `person` (`name`),
  CONSTRAINT `personfriend_ibfk_2` FOREIGN KEY (`name`) REFERENCES `person` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
