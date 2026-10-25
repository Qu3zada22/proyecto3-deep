CREATE TABLE `accelerator_compatible_browser` (
  `accelerator_id` int NOT NULL,
  `browser_id` int NOT NULL,
  `compatible_since_year` int DEFAULT NULL,
  PRIMARY KEY (`accelerator_id`,`browser_id`),
  KEY `browser_id` (`browser_id`),
  CONSTRAINT `accelerator_compatible_browser_ibfk_1` FOREIGN KEY (`browser_id`) REFERENCES `browser` (`id`),
  CONSTRAINT `accelerator_compatible_browser_ibfk_2` FOREIGN KEY (`accelerator_id`) REFERENCES `web_client_accelerator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `browser` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `market_share` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `web_client_accelerator` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `operating_system` varchar(50) DEFAULT NULL,
  `client` varchar(50) DEFAULT NULL,
  `connection` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
