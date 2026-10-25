CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `address_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `agreements` (
  `document_id` int NOT NULL,
  `event_id` int DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `agreements_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `assets` (
  `asset_id` int NOT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `assets_in_events` (
  `asset_id` int NOT NULL,
  `event_id` int NOT NULL,
  PRIMARY KEY (`asset_id`,`event_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `assets_in_events_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  CONSTRAINT `assets_in_events_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `channels` (
  `channel_id` int NOT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `events` (
  `event_id` int NOT NULL,
  `address_id` int DEFAULT NULL,
  `channel_id` int DEFAULT NULL,
  `event_type_code` varchar(15) DEFAULT NULL,
  `finance_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `finance_id` (`finance_id`),
  KEY `address_id` (`address_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`finance_id`) REFERENCES `finances` (`finance_id`),
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  CONSTRAINT `events_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `finances` (
  `finance_id` int NOT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`finance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `locations` (
  `location_id` int NOT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `parties` (
  `party_id` int NOT NULL,
  `party_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `parties_in_events` (
  `party_id` int NOT NULL,
  `event_id` int NOT NULL,
  `role_code` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`party_id`,`event_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `parties_in_events_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  CONSTRAINT `parties_in_events_ibfk_2` FOREIGN KEY (`party_id`) REFERENCES `parties` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_type_code` varchar(15) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products_in_events` (
  `product_in_event_id` int NOT NULL,
  `event_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`product_in_event_id`),
  KEY `product_id` (`product_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `products_in_events_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `products_in_events_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
