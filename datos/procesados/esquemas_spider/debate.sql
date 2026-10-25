CREATE TABLE `debate` (
  `debate_id` int NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `venue` varchar(50) DEFAULT NULL,
  `num_of_audience` int DEFAULT NULL,
  PRIMARY KEY (`debate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `debate_people` (
  `debate_id` int NOT NULL,
  `affirmative` int NOT NULL,
  `negative` int NOT NULL,
  `if_affirmative_win` int DEFAULT NULL,
  PRIMARY KEY (`debate_id`,`affirmative`,`negative`),
  KEY `negative` (`negative`),
  KEY `affirmative` (`affirmative`),
  CONSTRAINT `debate_people_ibfk_1` FOREIGN KEY (`negative`) REFERENCES `people` (`people_id`),
  CONSTRAINT `debate_people_ibfk_2` FOREIGN KEY (`affirmative`) REFERENCES `people` (`people_id`),
  CONSTRAINT `debate_people_ibfk_3` FOREIGN KEY (`debate_id`) REFERENCES `debate` (`debate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `people` (
  `people_id` int NOT NULL,
  `district` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `party` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
