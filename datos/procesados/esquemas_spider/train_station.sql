CREATE TABLE `station` (
  `station_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `annual_entry_exit` double DEFAULT NULL,
  `annual_interchanges` double DEFAULT NULL,
  `total_passengers` double DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `main_services` varchar(50) DEFAULT NULL,
  `number_of_platforms` int DEFAULT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `train` (
  `train_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `train_station` (
  `train_id` int NOT NULL,
  `station_id` int NOT NULL,
  PRIMARY KEY (`train_id`,`station_id`),
  KEY `station_id` (`station_id`),
  CONSTRAINT `train_station_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `station` (`station_id`),
  CONSTRAINT `train_station_ibfk_2` FOREIGN KEY (`train_id`) REFERENCES `train` (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
