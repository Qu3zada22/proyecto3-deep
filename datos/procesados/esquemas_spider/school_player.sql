CREATE TABLE `player` (
  `player_id` int NOT NULL,
  `player` varchar(50) DEFAULT NULL,
  `team` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `school_id` int DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  KEY `school_id` (`school_id`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `school` (
  `school_id` int NOT NULL,
  `school` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `enrollment` double DEFAULT NULL,
  `founded` double DEFAULT NULL,
  `denomination` varchar(50) DEFAULT NULL,
  `boys_or_girls` varchar(50) DEFAULT NULL,
  `day_or_boarding` varchar(50) DEFAULT NULL,
  `year_entered_competition` double DEFAULT NULL,
  `school_colors` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `school_details` (
  `school_id` int NOT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `colors` varchar(50) DEFAULT NULL,
  `league` varchar(50) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `division` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`school_id`),
  CONSTRAINT `school_details_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `school_performance` (
  `school_id` int NOT NULL,
  `school_year` varchar(50) NOT NULL,
  `class_a` varchar(50) DEFAULT NULL,
  `class_aa` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`school_id`,`school_year`),
  CONSTRAINT `school_performance_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
