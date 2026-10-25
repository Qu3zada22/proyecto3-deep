CREATE TABLE `machine` (
  `machine_id` int NOT NULL,
  `making_year` int DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `team` varchar(50) DEFAULT NULL,
  `machine_series` varchar(50) DEFAULT NULL,
  `value_points` double DEFAULT NULL,
  `quality_rank` int DEFAULT NULL,
  PRIMARY KEY (`machine_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `repair` (
  `repair_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `launch_date` varchar(50) DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`repair_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `repair_assignment` (
  `technician_id` double NOT NULL,
  `repair_id` int NOT NULL,
  `machine_id` int NOT NULL,
  PRIMARY KEY (`technician_id`,`repair_id`,`machine_id`),
  KEY `machine_id` (`machine_id`),
  KEY `repair_id` (`repair_id`),
  CONSTRAINT `repair_assignment_ibfk_1` FOREIGN KEY (`machine_id`) REFERENCES `machine` (`machine_id`),
  CONSTRAINT `repair_assignment_ibfk_2` FOREIGN KEY (`repair_id`) REFERENCES `repair` (`repair_id`),
  CONSTRAINT `repair_assignment_ibfk_3` FOREIGN KEY (`technician_id`) REFERENCES `technician` (`technician_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `technician` (
  `technician_id` double NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `team` varchar(50) DEFAULT NULL,
  `starting_year` double DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`technician_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
