CREATE TABLE `geographic` (
  `city_name` varchar(50) NOT NULL,
  `county` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`city_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `location` (
  `restaurant_id` int NOT NULL,
  `house_number` int DEFAULT NULL,
  `street_name` varchar(50) DEFAULT NULL,
  `city_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`),
  KEY `city_name` (`city_name`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`city_name`) REFERENCES `geographic` (`city_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `restaurant` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `food_type` varchar(50) DEFAULT NULL,
  `city_name` varchar(50) DEFAULT NULL,
  `rating` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `city_name` (`city_name`),
  CONSTRAINT `restaurant_ibfk_1` FOREIGN KEY (`city_name`) REFERENCES `geographic` (`city_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
