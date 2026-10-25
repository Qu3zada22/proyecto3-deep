CREATE TABLE `activity` (
  `actid` int NOT NULL,
  `activity_name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`actid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `faculty` (
  `facid` int NOT NULL,
  `lname` varchar(15) DEFAULT NULL,
  `fname` varchar(15) DEFAULT NULL,
  `rank` varchar(15) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `phone` int DEFAULT NULL,
  `room` varchar(5) DEFAULT NULL,
  `building` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`facid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `faculty_participates_in` (
  `facid` int DEFAULT NULL,
  `actid` int DEFAULT NULL,
  KEY `actid` (`actid`),
  KEY `facid` (`facid`),
  CONSTRAINT `faculty_participates_in_ibfk_1` FOREIGN KEY (`actid`) REFERENCES `activity` (`actid`),
  CONSTRAINT `faculty_participates_in_ibfk_2` FOREIGN KEY (`facid`) REFERENCES `faculty` (`facid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `participates_in` (
  `stuid` int DEFAULT NULL,
  `actid` int DEFAULT NULL,
  KEY `actid` (`actid`),
  KEY `stuid` (`stuid`),
  CONSTRAINT `participates_in_ibfk_1` FOREIGN KEY (`actid`) REFERENCES `activity` (`actid`),
  CONSTRAINT `participates_in_ibfk_2` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`)
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
