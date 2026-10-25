CREATE TABLE `actor` (
  `actor_id` int NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `address` (
  `address_id` int NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `district` varchar(20) DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `category` (
  `category_id` int NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `city` (
  `city_id` int NOT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `country` (
  `country_id` int NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer` (
  `customer_id` int NOT NULL,
  `store_id` int DEFAULT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `active` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `store_id` (`store_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`),
  CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `film` (
  `film_id` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(130) DEFAULT NULL,
  `release_year` int DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `original_language_id` int DEFAULT NULL,
  `rental_duration` int DEFAULT NULL,
  `rental_rate` decimal(4,2) DEFAULT NULL,
  `length` int DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` varchar(50) DEFAULT NULL,
  `special_features` varchar(54) DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  KEY `original_language_id` (`original_language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `film_ibfk_1` FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`),
  CONSTRAINT `film_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `film_actor` (
  `actor_id` int NOT NULL,
  `film_id` int NOT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`actor_id`,`film_id`),
  KEY `film_id` (`film_id`),
  CONSTRAINT `film_actor_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`),
  CONSTRAINT `film_actor_ibfk_2` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `film_category` (
  `film_id` int NOT NULL,
  `category_id` int NOT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`film_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `film_category_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `film_category_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `film_text` (
  `film_id` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`film_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL,
  `film_id` int DEFAULT NULL,
  `store_id` int DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  KEY `film_id` (`film_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`),
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `language` (
  `language_id` int NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `last_update` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `payment` (
  `payment_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `rental_id` int DEFAULT NULL,
  `amount` decimal(5,2) DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `staff_id` (`staff_id`),
  KEY `customer_id` (`customer_id`),
  KEY `rental_id` (`rental_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`rental_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `rental` (
  `rental_id` int NOT NULL,
  `rental_date` datetime DEFAULT NULL,
  `inventory_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `return_date` datetime DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`rental_id`),
  KEY `customer_id` (`customer_id`),
  KEY `inventory_id` (`inventory_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `rental_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `rental_ibfk_2` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`),
  CONSTRAINT `rental_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `picture` blob,
  `email` varchar(50) DEFAULT NULL,
  `store_id` int DEFAULT NULL,
  `active` int DEFAULT NULL,
  `username` varchar(16) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `last_update` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `store` (
  `store_id` int NOT NULL,
  `manager_staff_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `last_update` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  KEY `address_id` (`address_id`),
  KEY `manager_staff_id` (`manager_staff_id`),
  CONSTRAINT `store_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`),
  CONSTRAINT `store_ibfk_2` FOREIGN KEY (`manager_staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
