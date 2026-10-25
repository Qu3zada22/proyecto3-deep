CREATE TABLE `airport` (
  `id` int NOT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `iata` varchar(50) DEFAULT NULL,
  `icao` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `flight` (
  `id` int NOT NULL,
  `vehicle_flight_number` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `pilot` varchar(50) DEFAULT NULL,
  `velocity` double DEFAULT NULL,
  `altitude` double DEFAULT NULL,
  `airport_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `airport_id` (`airport_id`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `operate_company` (`id`),
  CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`airport_id`) REFERENCES `airport` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `operate_company` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `principal_activities` varchar(50) DEFAULT NULL,
  `incorporated_in` varchar(50) DEFAULT NULL,
  `group_equity_shareholding` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
