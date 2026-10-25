CREATE TABLE `aircraft` (
  `aircraft_id` int NOT NULL,
  `aircraft` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `max_gross_weight` varchar(50) DEFAULT NULL,
  `total_disk_area` varchar(50) DEFAULT NULL,
  `max_disk_loading` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`aircraft_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `airport` (
  `airport_id` int NOT NULL,
  `airport_name` varchar(50) DEFAULT NULL,
  `total_passengers` double DEFAULT NULL,
  `%_change_2007` varchar(50) DEFAULT NULL,
  `international_passengers` double DEFAULT NULL,
  `domestic_passengers` double DEFAULT NULL,
  `transit_passengers` double DEFAULT NULL,
  `aircraft_movements` double DEFAULT NULL,
  `freight_metric_tonnes` double DEFAULT NULL,
  PRIMARY KEY (`airport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `airport_aircraft` (
  `id` int DEFAULT NULL,
  `airport_id` int NOT NULL,
  `aircraft_id` int NOT NULL,
  PRIMARY KEY (`airport_id`,`aircraft_id`),
  KEY `aircraft_id` (`aircraft_id`),
  CONSTRAINT `airport_aircraft_ibfk_1` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`),
  CONSTRAINT `airport_aircraft_ibfk_2` FOREIGN KEY (`airport_id`) REFERENCES `airport` (`airport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `match` (
  `round` double NOT NULL,
  `location` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `fastest_qualifying` varchar(50) DEFAULT NULL,
  `winning_pilot` int DEFAULT NULL,
  `winning_aircraft` int DEFAULT NULL,
  PRIMARY KEY (`round`),
  KEY `winning_pilot` (`winning_pilot`),
  KEY `winning_aircraft` (`winning_aircraft`),
  CONSTRAINT `match_ibfk_1` FOREIGN KEY (`winning_pilot`) REFERENCES `pilot` (`pilot_id`),
  CONSTRAINT `match_ibfk_2` FOREIGN KEY (`winning_aircraft`) REFERENCES `aircraft` (`aircraft_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pilot` (
  `pilot_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`pilot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
