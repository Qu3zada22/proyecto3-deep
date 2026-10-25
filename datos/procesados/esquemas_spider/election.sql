CREATE TABLE `county` (
  `county_id` int NOT NULL,
  `county_name` varchar(50) DEFAULT NULL,
  `population` double DEFAULT NULL,
  `zip_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`county_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `election` (
  `election_id` int NOT NULL,
  `counties_represented` varchar(50) DEFAULT NULL,
  `district` int DEFAULT NULL,
  `delegate` varchar(50) DEFAULT NULL,
  `party` int DEFAULT NULL,
  `first_elected` double DEFAULT NULL,
  `committee` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`election_id`),
  KEY `district` (`district`),
  KEY `party` (`party`),
  CONSTRAINT `election_ibfk_1` FOREIGN KEY (`district`) REFERENCES `county` (`county_id`),
  CONSTRAINT `election_ibfk_2` FOREIGN KEY (`party`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `party` (
  `party_id` int NOT NULL,
  `year` double DEFAULT NULL,
  `party` varchar(50) DEFAULT NULL,
  `governor` varchar(50) DEFAULT NULL,
  `lieutenant_governor` varchar(50) DEFAULT NULL,
  `comptroller` varchar(50) DEFAULT NULL,
  `attorney_general` varchar(50) DEFAULT NULL,
  `us_senate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
