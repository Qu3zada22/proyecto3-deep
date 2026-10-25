CREATE TABLE `budget` (
  `school_id` varchar(50) NOT NULL,
  `year` int NOT NULL,
  `budgeted` int DEFAULT NULL,
  `total_budget_percent_budgeted` double DEFAULT NULL,
  `invested` int DEFAULT NULL,
  `total_budget_percent_invested` double DEFAULT NULL,
  `budget_invested_percent` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`school_id`,`year`),
  CONSTRAINT `budget_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `endowment` (
  `endowment_id` int NOT NULL,
  `school_id` varchar(50) DEFAULT NULL,
  `donator_name` varchar(50) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`endowment_id`),
  KEY `school_id` (`school_id`),
  CONSTRAINT `endowment_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `school` (
  `school_id` varchar(50) NOT NULL,
  `school_name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `mascot` varchar(50) DEFAULT NULL,
  `enrollment` int DEFAULT NULL,
  `ihsaa_class` varchar(50) DEFAULT NULL,
  `ihsaa_football_class` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
