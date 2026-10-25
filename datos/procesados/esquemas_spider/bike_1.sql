CREATE TABLE `station` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `long` double DEFAULT NULL,
  `dock_count` int DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `installation_date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `status` (
  `station_id` int DEFAULT NULL,
  `bikes_available` int DEFAULT NULL,
  `docks_available` int DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  KEY `station_id` (`station_id`),
  CONSTRAINT `status_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `trip` (
  `id` int NOT NULL,
  `duration` int DEFAULT NULL,
  `start_date` varchar(50) DEFAULT NULL,
  `start_station_name` varchar(50) DEFAULT NULL,
  `start_station_id` int DEFAULT NULL,
  `end_date` varchar(50) DEFAULT NULL,
  `end_station_name` varchar(50) DEFAULT NULL,
  `end_station_id` int DEFAULT NULL,
  `bike_id` int DEFAULT NULL,
  `subscription_type` varchar(50) DEFAULT NULL,
  `zip_code` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `weather` (
  `date` varchar(50) DEFAULT NULL,
  `max_temperature_f` int DEFAULT NULL,
  `mean_temperature_f` int DEFAULT NULL,
  `min_temperature_f` int DEFAULT NULL,
  `max_dew_point_f` int DEFAULT NULL,
  `mean_dew_point_f` int DEFAULT NULL,
  `min_dew_point_f` int DEFAULT NULL,
  `max_humidity` int DEFAULT NULL,
  `mean_humidity` int DEFAULT NULL,
  `min_humidity` int DEFAULT NULL,
  `max_sea_level_pressure_inches` double DEFAULT NULL,
  `mean_sea_level_pressure_inches` double DEFAULT NULL,
  `min_sea_level_pressure_inches` double DEFAULT NULL,
  `max_visibility_miles` int DEFAULT NULL,
  `mean_visibility_miles` int DEFAULT NULL,
  `min_visibility_miles` int DEFAULT NULL,
  `max_wind_speed_mph` int DEFAULT NULL,
  `mean_wind_speed_mph` int DEFAULT NULL,
  `max_gust_speed_mph` int DEFAULT NULL,
  `precipitation_inches` int DEFAULT NULL,
  `cloud_cover` int DEFAULT NULL,
  `events` varchar(50) DEFAULT NULL,
  `wind_dir_degrees` int DEFAULT NULL,
  `zip_code` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
