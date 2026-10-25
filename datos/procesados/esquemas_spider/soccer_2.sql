CREATE TABLE `college` (
  `cname` varchar(20) NOT NULL,
  `state` varchar(2) DEFAULT NULL,
  `enr` decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (`cname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player` (
  `pid` decimal(5,0) NOT NULL,
  `pname` varchar(20) DEFAULT NULL,
  `ycard` varchar(3) DEFAULT NULL,
  `hs` decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tryout` (
  `pid` decimal(5,0) NOT NULL,
  `cname` varchar(20) NOT NULL,
  `ppos` varchar(8) DEFAULT NULL,
  `decision` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`pid`,`cname`),
  KEY `cname` (`cname`),
  CONSTRAINT `tryout_ibfk_1` FOREIGN KEY (`cname`) REFERENCES `college` (`cname`),
  CONSTRAINT `tryout_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `player` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
