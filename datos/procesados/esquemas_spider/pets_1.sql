CREATE TABLE `has_pet` (
  `stuid` int DEFAULT NULL,
  `petid` int DEFAULT NULL,
  KEY `stuid` (`stuid`),
  KEY `petid` (`petid`),
  CONSTRAINT `has_pet_ibfk_1` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`),
  CONSTRAINT `has_pet_ibfk_2` FOREIGN KEY (`petid`) REFERENCES `pets` (`petid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pets` (
  `petid` int NOT NULL,
  `pettype` varchar(20) DEFAULT NULL,
  `pet_age` int DEFAULT NULL,
  `weight` double DEFAULT NULL,
  PRIMARY KEY (`petid`)
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
