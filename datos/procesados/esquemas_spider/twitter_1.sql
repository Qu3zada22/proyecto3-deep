CREATE TABLE `follows` (
  `f1` int NOT NULL,
  `f2` int NOT NULL,
  PRIMARY KEY (`f1`,`f2`),
  KEY `f2` (`f2`),
  CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`f2`) REFERENCES `user_profiles` (`uid`),
  CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`f1`) REFERENCES `user_profiles` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tweets` (
  `id` int NOT NULL,
  `uid` int DEFAULT NULL,
  `text` varchar(140) DEFAULT NULL,
  `createdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  CONSTRAINT `tweets_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user_profiles` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user_profiles` (
  `uid` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `partitionid` int DEFAULT NULL,
  `followers` int DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
