CREATE TABLE `features` (
  `feature_id` int NOT NULL,
  `feature_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `hotels` (
  `hotel_id` int NOT NULL,
  `star_rating_code` varchar(15) DEFAULT NULL,
  `pets_allowed_yn` varchar(1) DEFAULT NULL,
  `price_range` double DEFAULT NULL,
  `other_hotel_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`hotel_id`),
  KEY `star_rating_code` (`star_rating_code`),
  CONSTRAINT `hotels_ibfk_1` FOREIGN KEY (`star_rating_code`) REFERENCES `ref_hotel_star_ratings` (`star_rating_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `locations` (
  `location_id` int NOT NULL,
  `location_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `museums` (
  `museum_id` int NOT NULL,
  `museum_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`museum_id`),
  CONSTRAINT `museums_ibfk_1` FOREIGN KEY (`museum_id`) REFERENCES `tourist_attractions` (`tourist_attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `photos` (
  `photo_id` int NOT NULL,
  `tourist_attraction_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `tourist_attraction_id` (`tourist_attraction_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`tourist_attraction_id`) REFERENCES `tourist_attractions` (`tourist_attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_attraction_types` (
  `attraction_type_code` varchar(15) NOT NULL,
  `attraction_type_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`attraction_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_hotel_star_ratings` (
  `star_rating_code` varchar(15) NOT NULL,
  `star_rating_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`star_rating_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `royal_family` (
  `royal_family_id` int NOT NULL,
  `royal_family_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`royal_family_id`),
  CONSTRAINT `royal_family_ibfk_1` FOREIGN KEY (`royal_family_id`) REFERENCES `tourist_attractions` (`tourist_attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `shops` (
  `shop_id` int NOT NULL,
  `shop_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`shop_id`),
  CONSTRAINT `shops_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `tourist_attractions` (`tourist_attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `tourist_attraction_id` int DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `tourist_attraction_id` (`tourist_attraction_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`tourist_attraction_id`) REFERENCES `tourist_attractions` (`tourist_attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `street_markets` (
  `market_id` int NOT NULL,
  `market_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`market_id`),
  CONSTRAINT `street_markets_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `tourist_attractions` (`tourist_attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `theme_parks` (
  `theme_park_id` int NOT NULL,
  `theme_park_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`theme_park_id`),
  CONSTRAINT `theme_parks_ibfk_1` FOREIGN KEY (`theme_park_id`) REFERENCES `tourist_attractions` (`tourist_attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tourist_attraction_features` (
  `tourist_attraction_id` int NOT NULL,
  `feature_id` int NOT NULL,
  PRIMARY KEY (`tourist_attraction_id`,`feature_id`),
  KEY `feature_id` (`feature_id`),
  CONSTRAINT `tourist_attraction_features_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `features` (`feature_id`),
  CONSTRAINT `tourist_attraction_features_ibfk_2` FOREIGN KEY (`tourist_attraction_id`) REFERENCES `tourist_attractions` (`tourist_attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tourist_attractions` (
  `tourist_attraction_id` int NOT NULL,
  `attraction_type_code` varchar(15) DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `how_to_get_there` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `opening_hours` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tourist_attraction_id`),
  KEY `attraction_type_code` (`attraction_type_code`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `tourist_attractions_ibfk_1` FOREIGN KEY (`attraction_type_code`) REFERENCES `ref_attraction_types` (`attraction_type_code`),
  CONSTRAINT `tourist_attractions_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `visitors` (
  `tourist_id` int NOT NULL,
  `tourist_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tourist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `visits` (
  `visit_id` int NOT NULL,
  `tourist_attraction_id` int DEFAULT NULL,
  `tourist_id` int DEFAULT NULL,
  `visit_date` datetime DEFAULT NULL,
  `visit_details` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`visit_id`),
  KEY `tourist_id` (`tourist_id`),
  KEY `tourist_attraction_id` (`tourist_attraction_id`),
  CONSTRAINT `visits_ibfk_1` FOREIGN KEY (`tourist_id`) REFERENCES `visitors` (`tourist_id`),
  CONSTRAINT `visits_ibfk_2` FOREIGN KEY (`tourist_attraction_id`) REFERENCES `tourist_attractions` (`tourist_attraction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
