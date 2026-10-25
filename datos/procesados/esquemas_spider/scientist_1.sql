CREATE TABLE `assignedto` (
  `scientist` int NOT NULL,
  `project` varchar(4) NOT NULL,
  PRIMARY KEY (`scientist`,`project`),
  KEY `project` (`project`),
  CONSTRAINT `assignedto_ibfk_1` FOREIGN KEY (`project`) REFERENCES `projects` (`code`),
  CONSTRAINT `assignedto_ibfk_2` FOREIGN KEY (`scientist`) REFERENCES `scientists` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `projects` (
  `code` varchar(4) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `hours` int DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `scientists` (
  `ssn` int NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
