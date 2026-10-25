CREATE TABLE `host` (
  `host_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `party` (
  `party_id` int NOT NULL,
  `party_theme` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `first_year` varchar(50) DEFAULT NULL,
  `last_year` varchar(50) DEFAULT NULL,
  `number_of_hosts` int DEFAULT NULL,
  PRIMARY KEY (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `party_host` (
  `party_id` int NOT NULL,
  `host_id` int NOT NULL,
  `is_main_in_charge` int DEFAULT NULL,
  PRIMARY KEY (`party_id`,`host_id`),
  KEY `host_id` (`host_id`),
  CONSTRAINT `party_host_ibfk_1` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `party_host_ibfk_2` FOREIGN KEY (`host_id`) REFERENCES `host` (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
