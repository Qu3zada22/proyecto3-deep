CREATE TABLE `route` (
  `train_id` int NOT NULL,
  `station_id` int NOT NULL,
  PRIMARY KEY (`train_id`,`station_id`),
  KEY `station_id` (`station_id`),
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`),
  CONSTRAINT `route_ibfk_2` FOREIGN KEY (`train_id`) REFERENCES `train` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `station` (
  `id` int NOT NULL,
  `network_name` varchar(50) DEFAULT NULL,
  `services` varchar(50) DEFAULT NULL,
  `local_authority` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `train` (
  `id` int NOT NULL,
  `train_number` int DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `interval` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `weekly_weather` (
  `station_id` int NOT NULL,
  `day_of_week` varchar(50) NOT NULL,
  `high_temperature` int DEFAULT NULL,
  `low_temperature` int DEFAULT NULL,
  `precipitation` double DEFAULT NULL,
  `wind_speed_mph` int DEFAULT NULL,
  PRIMARY KEY (`station_id`,`day_of_week`),
  CONSTRAINT `weekly_weather_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
