CREATE TABLE `club` (
  `clubid` int NOT NULL,
  `clubname` varchar(40) DEFAULT NULL,
  `clubdesc` varchar(1000) DEFAULT NULL,
  `clublocation` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`clubid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `member_of_club` (
  `stuid` int DEFAULT NULL,
  `clubid` int DEFAULT NULL,
  `position` varchar(40) DEFAULT NULL,
  KEY `clubid` (`clubid`),
  KEY `stuid` (`stuid`),
  CONSTRAINT `member_of_club_ibfk_1` FOREIGN KEY (`clubid`) REFERENCES `club` (`clubid`),
  CONSTRAINT `member_of_club_ibfk_2` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`)
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
