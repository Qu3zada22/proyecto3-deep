CREATE TABLE `city` (
  `id` int NOT NULL,
  `name` varchar(35) DEFAULT NULL,
  `countrycode` varchar(3) DEFAULT NULL,
  `district` varchar(20) DEFAULT NULL,
  `population` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `countrycode` (`countrycode`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`countrycode`) REFERENCES `country` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `country` (
  `code` varchar(3) NOT NULL,
  `name` varchar(52) DEFAULT NULL,
  `continent` varchar(50) DEFAULT NULL,
  `region` varchar(26) DEFAULT NULL,
  `surfacearea` double DEFAULT NULL,
  `indepyear` int DEFAULT NULL,
  `population` int DEFAULT NULL,
  `lifeexpectancy` double DEFAULT NULL,
  `gnp` double DEFAULT NULL,
  `gnpold` double DEFAULT NULL,
  `localname` varchar(45) DEFAULT NULL,
  `governmentform` varchar(45) DEFAULT NULL,
  `headofstate` varchar(60) DEFAULT NULL,
  `capital` int DEFAULT NULL,
  `code2` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `countrylanguage` (
  `countrycode` varchar(3) NOT NULL,
  `language` varchar(30) NOT NULL,
  `isofficial` varchar(50) DEFAULT NULL,
  `percentage` double DEFAULT NULL,
  PRIMARY KEY (`countrycode`,`language`),
  CONSTRAINT `countrylanguage_ibfk_1` FOREIGN KEY (`countrycode`) REFERENCES `country` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
