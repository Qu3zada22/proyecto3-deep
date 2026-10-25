CREATE TABLE `course` (
  `cid` varchar(7) NOT NULL,
  `cname` varchar(40) DEFAULT NULL,
  `credits` int DEFAULT NULL,
  `instructor` int DEFAULT NULL,
  `days` varchar(5) DEFAULT NULL,
  `hours` varchar(11) DEFAULT NULL,
  `dno` int DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `dno` (`dno`),
  KEY `instructor` (`instructor`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dno`) REFERENCES `department` (`dno`),
  CONSTRAINT `course_ibfk_2` FOREIGN KEY (`instructor`) REFERENCES `faculty` (`facid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `department` (
  `dno` int NOT NULL,
  `division` varchar(2) DEFAULT NULL,
  `dname` varchar(25) DEFAULT NULL,
  `room` varchar(5) DEFAULT NULL,
  `building` varchar(13) DEFAULT NULL,
  `dphone` int DEFAULT NULL,
  PRIMARY KEY (`dno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `enrolled_in` (
  `stuid` int DEFAULT NULL,
  `cid` varchar(7) DEFAULT NULL,
  `grade` varchar(2) DEFAULT NULL,
  KEY `grade` (`grade`),
  KEY `cid` (`cid`),
  KEY `stuid` (`stuid`),
  CONSTRAINT `enrolled_in_ibfk_1` FOREIGN KEY (`grade`) REFERENCES `gradeconversion` (`lettergrade`),
  CONSTRAINT `enrolled_in_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `enrolled_in_ibfk_3` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`)
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

CREATE TABLE `gradeconversion` (
  `lettergrade` varchar(2) NOT NULL,
  `gradepoint` double DEFAULT NULL,
  PRIMARY KEY (`lettergrade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `member_of` (
  `facid` int DEFAULT NULL,
  `dno` int DEFAULT NULL,
  `appt_type` varchar(15) DEFAULT NULL,
  KEY `dno` (`dno`),
  KEY `facid` (`facid`),
  CONSTRAINT `member_of_ibfk_1` FOREIGN KEY (`dno`) REFERENCES `department` (`dno`),
  CONSTRAINT `member_of_ibfk_2` FOREIGN KEY (`facid`) REFERENCES `faculty` (`facid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `minor_in` (
  `stuid` int DEFAULT NULL,
  `dno` int DEFAULT NULL,
  KEY `dno` (`dno`),
  KEY `stuid` (`stuid`),
  CONSTRAINT `minor_in_ibfk_1` FOREIGN KEY (`dno`) REFERENCES `department` (`dno`),
  CONSTRAINT `minor_in_ibfk_2` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`)
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
