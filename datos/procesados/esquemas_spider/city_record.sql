CREATE TABLE `city` (
  `city_id` int NOT NULL,
  `city` varchar(50) DEFAULT NULL,
  `hanzi` varchar(50) DEFAULT NULL,
  `hanyu_pinyin` varchar(50) DEFAULT NULL,
  `regional_population` int DEFAULT NULL,
  `gdp` double DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `hosting_city` (
  `year` int NOT NULL,
  `match_id` int DEFAULT NULL,
  `host_city` int DEFAULT NULL,
  PRIMARY KEY (`year`),
  KEY `match_id` (`match_id`),
  KEY `host_city` (`host_city`),
  CONSTRAINT `hosting_city_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `match` (`match_id`),
  CONSTRAINT `hosting_city_ibfk_2` FOREIGN KEY (`host_city`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `match` (
  `match_id` int NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `venue` varchar(50) DEFAULT NULL,
  `score` varchar(50) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  `competition` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `temperature` (
  `city_id` int NOT NULL,
  `jan` double DEFAULT NULL,
  `feb` double DEFAULT NULL,
  `mar` double DEFAULT NULL,
  `apr` double DEFAULT NULL,
  `jun` double DEFAULT NULL,
  `jul` double DEFAULT NULL,
  `aug` double DEFAULT NULL,
  `sep` double DEFAULT NULL,
  `oct` double DEFAULT NULL,
  `nov` double DEFAULT NULL,
  `dec` double DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  CONSTRAINT `temperature_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
