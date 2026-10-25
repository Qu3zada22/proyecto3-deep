CREATE TABLE `department` (
  `department_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `creation` varchar(50) DEFAULT NULL,
  `ranking` int DEFAULT NULL,
  `budget_in_billions` double DEFAULT NULL,
  `num_employees` double DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `head` (
  `head_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `born_state` varchar(50) DEFAULT NULL,
  `age` double DEFAULT NULL,
  PRIMARY KEY (`head_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `management` (
  `department_id` int NOT NULL,
  `head_id` int NOT NULL,
  `temporary_acting` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`department_id`,`head_id`),
  KEY `head_id` (`head_id`),
  CONSTRAINT `management_ibfk_1` FOREIGN KEY (`head_id`) REFERENCES `head` (`head_id`),
  CONSTRAINT `management_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
