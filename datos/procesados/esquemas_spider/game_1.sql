CREATE TABLE `plays_games` (
  `stuid` int DEFAULT NULL,
  `gameid` int DEFAULT NULL,
  `hours_played` int DEFAULT NULL,
  KEY `stuid` (`stuid`),
  KEY `gameid` (`gameid`),
  CONSTRAINT `plays_games_ibfk_1` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`),
  CONSTRAINT `plays_games_ibfk_2` FOREIGN KEY (`gameid`) REFERENCES `video_games` (`gameid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sportsinfo` (
  `stuid` int DEFAULT NULL,
  `sportname` varchar(32) DEFAULT NULL,
  `hoursperweek` int DEFAULT NULL,
  `gamesplayed` int DEFAULT NULL,
  `onscholarship` varchar(1) DEFAULT NULL,
  KEY `stuid` (`stuid`),
  CONSTRAINT `sportsinfo_ibfk_1` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`)
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

CREATE TABLE `video_games` (
  `gameid` int NOT NULL,
  `gname` varchar(40) DEFAULT NULL,
  `gtype` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`gameid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
