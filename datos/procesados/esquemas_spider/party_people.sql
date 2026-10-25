CREATE TABLE `member` (
  `member_id` int NOT NULL,
  `member_name` varchar(50) DEFAULT NULL,
  `party_id` int DEFAULT NULL,
  `in_office` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  KEY `party_id` (`party_id`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `party` (
  `party_id` int NOT NULL,
  `minister` varchar(50) DEFAULT NULL,
  `took_office` varchar(50) DEFAULT NULL,
  `left_office` varchar(50) DEFAULT NULL,
  `region_id` int DEFAULT NULL,
  `party_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`party_id`),
  KEY `region_id` (`region_id`),
  CONSTRAINT `party_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `party_events` (
  `event_id` int NOT NULL,
  `event_name` varchar(50) DEFAULT NULL,
  `party_id` int DEFAULT NULL,
  `member_in_charge_id` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `member_in_charge_id` (`member_in_charge_id`),
  KEY `party_id` (`party_id`),
  CONSTRAINT `party_events_ibfk_1` FOREIGN KEY (`member_in_charge_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `party_events_ibfk_2` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `region` (
  `region_id` int NOT NULL,
  `region_name` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `format` varchar(50) DEFAULT NULL,
  `catalogue` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
