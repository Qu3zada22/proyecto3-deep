CREATE TABLE `author` (
  `authorid` int NOT NULL,
  `authorname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`authorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cite` (
  `citingpaperid` int NOT NULL,
  `citedpaperid` int NOT NULL,
  PRIMARY KEY (`citingpaperid`,`citedpaperid`),
  KEY `citedpaperid` (`citedpaperid`),
  CONSTRAINT `cite_ibfk_1` FOREIGN KEY (`citingpaperid`) REFERENCES `paper` (`paperid`),
  CONSTRAINT `cite_ibfk_2` FOREIGN KEY (`citedpaperid`) REFERENCES `paper` (`paperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `dataset` (
  `datasetid` int NOT NULL,
  `datasetname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`datasetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `journal` (
  `journalid` int NOT NULL,
  `journalname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`journalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `keyphrase` (
  `keyphraseid` int NOT NULL,
  `keyphrasename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`keyphraseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `paper` (
  `paperid` int NOT NULL,
  `title` varchar(300) DEFAULT NULL,
  `venueid` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `numciting` int DEFAULT NULL,
  `numcitedby` int DEFAULT NULL,
  `journalid` int DEFAULT NULL,
  PRIMARY KEY (`paperid`),
  KEY `venueid` (`venueid`),
  KEY `journalid` (`journalid`),
  CONSTRAINT `paper_ibfk_1` FOREIGN KEY (`venueid`) REFERENCES `venue` (`venueid`),
  CONSTRAINT `paper_ibfk_2` FOREIGN KEY (`journalid`) REFERENCES `journal` (`journalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `paperdataset` (
  `paperid` int NOT NULL,
  `datasetid` int NOT NULL,
  PRIMARY KEY (`datasetid`,`paperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `paperkeyphrase` (
  `paperid` int NOT NULL,
  `keyphraseid` int NOT NULL,
  PRIMARY KEY (`keyphraseid`,`paperid`),
  KEY `paperid` (`paperid`),
  CONSTRAINT `paperkeyphrase_ibfk_1` FOREIGN KEY (`keyphraseid`) REFERENCES `keyphrase` (`keyphraseid`),
  CONSTRAINT `paperkeyphrase_ibfk_2` FOREIGN KEY (`paperid`) REFERENCES `paper` (`paperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `venue` (
  `venueid` int NOT NULL,
  `venuename` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`venueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `writes` (
  `paperid` int NOT NULL,
  `authorid` int NOT NULL,
  PRIMARY KEY (`paperid`,`authorid`),
  KEY `authorid` (`authorid`),
  CONSTRAINT `writes_ibfk_1` FOREIGN KEY (`authorid`) REFERENCES `author` (`authorid`),
  CONSTRAINT `writes_ibfk_2` FOREIGN KEY (`paperid`) REFERENCES `paper` (`paperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
