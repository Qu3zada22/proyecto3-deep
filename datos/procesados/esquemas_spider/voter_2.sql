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

CREATE TABLE `voting_record` (
  `stuid` int DEFAULT NULL,
  `registration_date` varchar(12) DEFAULT NULL,
  `election_cycle` varchar(12) DEFAULT NULL,
  `president_vote` int DEFAULT NULL,
  `vice_president_vote` int DEFAULT NULL,
  `secretary_vote` int DEFAULT NULL,
  `treasurer_vote` int DEFAULT NULL,
  `class_president_vote` int DEFAULT NULL,
  `class_senator_vote` int DEFAULT NULL,
  KEY `class_senator_vote` (`class_senator_vote`),
  KEY `class_president_vote` (`class_president_vote`),
  KEY `treasurer_vote` (`treasurer_vote`),
  KEY `secretary_vote` (`secretary_vote`),
  KEY `vice_president_vote` (`vice_president_vote`),
  KEY `president_vote` (`president_vote`),
  KEY `stuid` (`stuid`),
  CONSTRAINT `voting_record_ibfk_1` FOREIGN KEY (`class_senator_vote`) REFERENCES `student` (`stuid`),
  CONSTRAINT `voting_record_ibfk_2` FOREIGN KEY (`class_president_vote`) REFERENCES `student` (`stuid`),
  CONSTRAINT `voting_record_ibfk_3` FOREIGN KEY (`treasurer_vote`) REFERENCES `student` (`stuid`),
  CONSTRAINT `voting_record_ibfk_4` FOREIGN KEY (`secretary_vote`) REFERENCES `student` (`stuid`),
  CONSTRAINT `voting_record_ibfk_5` FOREIGN KEY (`vice_president_vote`) REFERENCES `student` (`stuid`),
  CONSTRAINT `voting_record_ibfk_6` FOREIGN KEY (`president_vote`) REFERENCES `student` (`stuid`),
  CONSTRAINT `voting_record_ibfk_7` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
