CREATE TABLE `campuses` (
  `id` int NOT NULL,
  `campus` varchar(55) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `csu_fees` (
  `campus` int NOT NULL,
  `year` int DEFAULT NULL,
  `campusfee` int DEFAULT NULL,
  PRIMARY KEY (`campus`),
  CONSTRAINT `csu_fees_ibfk_1` FOREIGN KEY (`campus`) REFERENCES `campuses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `degrees` (
  `year` int NOT NULL,
  `campus` int NOT NULL,
  `degrees` int DEFAULT NULL,
  PRIMARY KEY (`year`,`campus`),
  KEY `campus` (`campus`),
  CONSTRAINT `degrees_ibfk_1` FOREIGN KEY (`campus`) REFERENCES `campuses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `discipline_enrollments` (
  `campus` int NOT NULL,
  `discipline` int NOT NULL,
  `year` int DEFAULT NULL,
  `undergraduate` int DEFAULT NULL,
  `graduate` int DEFAULT NULL,
  PRIMARY KEY (`campus`,`discipline`),
  CONSTRAINT `discipline_enrollments_ibfk_1` FOREIGN KEY (`campus`) REFERENCES `campuses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `enrollments` (
  `campus` int NOT NULL,
  `year` int NOT NULL,
  `totalenrollment_ay` int DEFAULT NULL,
  `fte_ay` int DEFAULT NULL,
  PRIMARY KEY (`campus`,`year`),
  CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`campus`) REFERENCES `campuses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `faculty` (
  `campus` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `faculty` double DEFAULT NULL,
  KEY `campus` (`campus`),
  CONSTRAINT `faculty_ibfk_1` FOREIGN KEY (`campus`) REFERENCES `campuses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
