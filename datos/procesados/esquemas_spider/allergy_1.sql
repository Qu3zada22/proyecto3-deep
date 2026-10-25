CREATE TABLE `allergy_type` (
  `allergy` varchar(20) NOT NULL,
  `allergytype` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`allergy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `has_allergy` (
  `stuid` int DEFAULT NULL,
  `allergy` varchar(20) DEFAULT NULL,
  KEY `allergy` (`allergy`),
  KEY `stuid` (`stuid`),
  CONSTRAINT `has_allergy_ibfk_1` FOREIGN KEY (`allergy`) REFERENCES `allergy_type` (`allergy`),
  CONSTRAINT `has_allergy_ibfk_2` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`)
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
