CREATE TABLE `author` (
  `aid` int NOT NULL,
  `homepage` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `oid` int DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cite` (
  `cited` int DEFAULT NULL,
  `citing` int DEFAULT NULL,
  KEY `citing` (`citing`),
  KEY `cited` (`cited`),
  CONSTRAINT `cite_ibfk_1` FOREIGN KEY (`citing`) REFERENCES `publication` (`pid`),
  CONSTRAINT `cite_ibfk_2` FOREIGN KEY (`cited`) REFERENCES `publication` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `conference` (
  `cid` int NOT NULL,
  `homepage` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `domain` (
  `did` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `domain_author` (
  `aid` int NOT NULL,
  `did` int NOT NULL,
  PRIMARY KEY (`did`,`aid`),
  KEY `aid` (`aid`),
  CONSTRAINT `domain_author_ibfk_1` FOREIGN KEY (`did`) REFERENCES `domain` (`did`),
  CONSTRAINT `domain_author_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `author` (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `domain_conference` (
  `cid` int NOT NULL,
  `did` int NOT NULL,
  PRIMARY KEY (`did`,`cid`),
  KEY `cid` (`cid`),
  CONSTRAINT `domain_conference_ibfk_1` FOREIGN KEY (`did`) REFERENCES `domain` (`did`),
  CONSTRAINT `domain_conference_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `conference` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `domain_journal` (
  `did` int NOT NULL,
  `jid` int NOT NULL,
  PRIMARY KEY (`did`,`jid`),
  KEY `jid` (`jid`),
  CONSTRAINT `domain_journal_ibfk_1` FOREIGN KEY (`did`) REFERENCES `domain` (`did`),
  CONSTRAINT `domain_journal_ibfk_2` FOREIGN KEY (`jid`) REFERENCES `journal` (`jid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `domain_keyword` (
  `did` int NOT NULL,
  `kid` int NOT NULL,
  PRIMARY KEY (`did`,`kid`),
  KEY `kid` (`kid`),
  CONSTRAINT `domain_keyword_ibfk_1` FOREIGN KEY (`did`) REFERENCES `domain` (`did`),
  CONSTRAINT `domain_keyword_ibfk_2` FOREIGN KEY (`kid`) REFERENCES `keyword` (`kid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `domain_publication` (
  `did` int NOT NULL,
  `pid` int NOT NULL,
  PRIMARY KEY (`did`,`pid`),
  KEY `pid` (`pid`),
  CONSTRAINT `domain_publication_ibfk_1` FOREIGN KEY (`did`) REFERENCES `domain` (`did`),
  CONSTRAINT `domain_publication_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `publication` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `journal` (
  `homepage` varchar(50) DEFAULT NULL,
  `jid` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`jid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `keyword` (
  `keyword` varchar(50) DEFAULT NULL,
  `kid` int NOT NULL,
  PRIMARY KEY (`kid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `organization` (
  `continent` varchar(50) DEFAULT NULL,
  `homepage` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `oid` int NOT NULL,
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `publication` (
  `abstract` varchar(50) DEFAULT NULL,
  `cid` int DEFAULT NULL,
  `citation_num` int DEFAULT NULL,
  `jid` int DEFAULT NULL,
  `pid` int NOT NULL,
  `reference_num` int DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `cid` (`cid`),
  KEY `jid` (`jid`),
  CONSTRAINT `publication_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `conference` (`cid`),
  CONSTRAINT `publication_ibfk_2` FOREIGN KEY (`jid`) REFERENCES `journal` (`jid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `publication_keyword` (
  `pid` int NOT NULL,
  `kid` int NOT NULL,
  PRIMARY KEY (`kid`,`pid`),
  KEY `pid` (`pid`),
  CONSTRAINT `publication_keyword_ibfk_1` FOREIGN KEY (`kid`) REFERENCES `keyword` (`kid`),
  CONSTRAINT `publication_keyword_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `publication` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `writes` (
  `aid` int NOT NULL,
  `pid` int NOT NULL,
  PRIMARY KEY (`aid`,`pid`),
  KEY `pid` (`pid`),
  CONSTRAINT `writes_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `author` (`aid`),
  CONSTRAINT `writes_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `publication` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
