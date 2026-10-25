CREATE TABLE `aircraft` (
  `aircraft_id` int NOT NULL,
  `order_year` int DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `fleet_series` varchar(50) DEFAULT NULL,
  `powertrain` varchar(50) DEFAULT NULL,
  `fuel_propulsion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`aircraft_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pilot` (
  `pilot_id` int NOT NULL,
  `pilot_name` varchar(50) DEFAULT NULL,
  `rank` int DEFAULT NULL,
  `age` int DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `join_year` int DEFAULT NULL,
  `team` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pilot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pilot_record` (
  `record_id` int DEFAULT NULL,
  `pilot_id` int NOT NULL,
  `aircraft_id` int NOT NULL,
  `date` varchar(50) NOT NULL,
  PRIMARY KEY (`pilot_id`,`aircraft_id`,`date`),
  KEY `aircraft_id` (`aircraft_id`),
  CONSTRAINT `pilot_record_ibfk_1` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`),
  CONSTRAINT `pilot_record_ibfk_2` FOREIGN KEY (`pilot_id`) REFERENCES `pilot` (`pilot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
