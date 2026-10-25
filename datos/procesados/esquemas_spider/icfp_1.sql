CREATE TABLE `authors` (
  `authid` int NOT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`authid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `authorship` (
  `authid` int NOT NULL,
  `instid` int NOT NULL,
  `paperid` int NOT NULL,
  `authorder` int DEFAULT NULL,
  PRIMARY KEY (`authid`,`instid`,`paperid`),
  KEY `paperid` (`paperid`),
  KEY `instid` (`instid`),
  CONSTRAINT `authorship_ibfk_1` FOREIGN KEY (`paperid`) REFERENCES `papers` (`paperid`),
  CONSTRAINT `authorship_ibfk_2` FOREIGN KEY (`instid`) REFERENCES `inst` (`instid`),
  CONSTRAINT `authorship_ibfk_3` FOREIGN KEY (`authid`) REFERENCES `authors` (`authid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `inst` (
  `instid` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`instid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `papers` (
  `paperid` int NOT NULL,
  `title` varchar(83) DEFAULT NULL,
  PRIMARY KEY (`paperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
