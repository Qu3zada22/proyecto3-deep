CREATE TABLE `affected_region` (
  `region_id` int NOT NULL,
  `storm_id` int NOT NULL,
  `number_city_affected` double DEFAULT NULL,
  PRIMARY KEY (`region_id`,`storm_id`),
  KEY `storm_id` (`storm_id`),
  CONSTRAINT `affected_region_ibfk_1` FOREIGN KEY (`storm_id`) REFERENCES `storm` (`storm_id`),
  CONSTRAINT `affected_region_ibfk_2` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `region` (
  `region_id` int NOT NULL,
  `region_code` varchar(50) DEFAULT NULL,
  `region_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `storm` (
  `storm_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `dates_active` varchar(50) DEFAULT NULL,
  `max_speed` int DEFAULT NULL,
  `damage_millions_usd` double DEFAULT NULL,
  `number_deaths` int DEFAULT NULL,
  PRIMARY KEY (`storm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
