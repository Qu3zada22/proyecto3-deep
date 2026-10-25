CREATE TABLE `driver` (
  `driver_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `party` varchar(50) DEFAULT NULL,
  `home_city` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`driver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `school` (
  `school_id` int NOT NULL,
  `grade` varchar(50) DEFAULT NULL,
  `school` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `school_bus` (
  `school_id` int NOT NULL,
  `driver_id` int NOT NULL,
  `years_working` int DEFAULT NULL,
  `if_full_time` int DEFAULT NULL,
  PRIMARY KEY (`school_id`,`driver_id`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `school_bus_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`),
  CONSTRAINT `school_bus_ibfk_2` FOREIGN KEY (`school_id`) REFERENCES `school` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
