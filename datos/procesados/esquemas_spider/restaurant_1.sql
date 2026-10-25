CREATE TABLE `restaurant` (
  `resid` int NOT NULL,
  `resname` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `rating` int DEFAULT NULL,
  PRIMARY KEY (`resid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `restaurant_type` (
  `restypeid` int NOT NULL,
  `restypename` varchar(40) DEFAULT NULL,
  `restypedescription` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`restypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student` (
  `stuid` int NOT NULL,
  `lname` varchar(12) DEFAULT NULL,
  `fname` varchar(12) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `major` int DEFAULT NULL,
  `advisor` int DEFAULT NULL,
  `city_code` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`stuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `type_of_restaurant` (
  `resid` int DEFAULT NULL,
  `restypeid` int DEFAULT NULL,
  KEY `restypeid` (`restypeid`),
  KEY `resid` (`resid`),
  CONSTRAINT `type_of_restaurant_ibfk_1` FOREIGN KEY (`restypeid`) REFERENCES `restaurant_type` (`restypeid`),
  CONSTRAINT `type_of_restaurant_ibfk_2` FOREIGN KEY (`resid`) REFERENCES `restaurant` (`resid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `visits_restaurant` (
  `stuid` int DEFAULT NULL,
  `resid` int DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `spent` double DEFAULT NULL,
  KEY `resid` (`resid`),
  KEY `stuid` (`stuid`),
  CONSTRAINT `visits_restaurant_ibfk_1` FOREIGN KEY (`resid`) REFERENCES `restaurant` (`resid`),
  CONSTRAINT `visits_restaurant_ibfk_2` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
