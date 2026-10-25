CREATE TABLE `actor` (
  `aid` int NOT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `birth_city` varchar(50) DEFAULT NULL,
  `birth_year` int DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cast` (
  `id` int NOT NULL,
  `msid` int DEFAULT NULL,
  `aid` int DEFAULT NULL,
  `role` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aid` (`aid`),
  CONSTRAINT `cast_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `actor` (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `classification` (
  `id` int NOT NULL,
  `msid` int DEFAULT NULL,
  `gid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gid` (`gid`),
  CONSTRAINT `classification_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `genre` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `company` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `country_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `copyright` (
  `id` int NOT NULL,
  `msid` int DEFAULT NULL,
  `cid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `directed_by` (
  `id` int NOT NULL,
  `msid` int DEFAULT NULL,
  `did` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `did` (`did`),
  CONSTRAINT `directed_by_ibfk_1` FOREIGN KEY (`did`) REFERENCES `director` (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `director` (
  `did` int NOT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `birth_city` varchar(50) DEFAULT NULL,
  `birth_year` int DEFAULT NULL,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `genre` (
  `gid` int NOT NULL,
  `genre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `keyword` (
  `id` int NOT NULL,
  `keyword` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `made_by` (
  `id` int NOT NULL,
  `msid` int DEFAULT NULL,
  `pid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  CONSTRAINT `made_by_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `producer` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `movie` (
  `mid` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `release_year` int DEFAULT NULL,
  `title_aka` varchar(50) DEFAULT NULL,
  `budget` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `producer` (
  `pid` int NOT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `birth_city` varchar(50) DEFAULT NULL,
  `birth_year` int DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tags` (
  `id` int NOT NULL,
  `msid` int DEFAULT NULL,
  `kid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tv_series` (
  `sid` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `release_year` int DEFAULT NULL,
  `num_of_seasons` int DEFAULT NULL,
  `num_of_episodes` int DEFAULT NULL,
  `title_aka` varchar(50) DEFAULT NULL,
  `budget` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `writer` (
  `wid` int NOT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `name` int DEFAULT NULL,
  `nationality` int DEFAULT NULL,
  `num_of_episodes` int DEFAULT NULL,
  `birth_city` varchar(50) DEFAULT NULL,
  `birth_year` int DEFAULT NULL,
  PRIMARY KEY (`wid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `written_by` (
  `id` int DEFAULT NULL,
  `msid` int DEFAULT NULL,
  `wid` int DEFAULT NULL,
  KEY `wid` (`wid`),
  CONSTRAINT `written_by_ibfk_1` FOREIGN KEY (`wid`) REFERENCES `writer` (`wid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
