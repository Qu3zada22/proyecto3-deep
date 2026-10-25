CREATE TABLE `manager` (
  `manager_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `working_year_starts` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `level` int DEFAULT NULL,
  PRIMARY KEY (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `railway` (
  `railway_id` int NOT NULL,
  `railway` varchar(50) DEFAULT NULL,
  `builder` varchar(50) DEFAULT NULL,
  `built` varchar(50) DEFAULT NULL,
  `wheels` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `objectnumber` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`railway_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `railway_manage` (
  `railway_id` int NOT NULL,
  `manager_id` int NOT NULL,
  `from_year` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`railway_id`,`manager_id`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `railway_manage_ibfk_1` FOREIGN KEY (`railway_id`) REFERENCES `railway` (`railway_id`),
  CONSTRAINT `railway_manage_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `train` (
  `train_id` int NOT NULL,
  `train_num` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `from` varchar(50) DEFAULT NULL,
  `arrival` varchar(50) DEFAULT NULL,
  `railway_id` int DEFAULT NULL,
  PRIMARY KEY (`train_id`),
  KEY `railway_id` (`railway_id`),
  CONSTRAINT `train_ibfk_1` FOREIGN KEY (`railway_id`) REFERENCES `railway` (`railway_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
