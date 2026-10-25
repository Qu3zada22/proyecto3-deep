CREATE TABLE `events` (
  `event_id` int NOT NULL,
  `service_id` int DEFAULT NULL,
  `event_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `participants` (
  `participant_id` int NOT NULL,
  `participant_type_code` varchar(15) DEFAULT NULL,
  `participant_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`participant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `participants_in_events` (
  `event_id` int NOT NULL,
  `participant_id` int NOT NULL,
  PRIMARY KEY (`event_id`,`participant_id`),
  KEY `participant_id` (`participant_id`),
  CONSTRAINT `participants_in_events_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  CONSTRAINT `participants_in_events_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`participant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `services` (
  `service_id` int NOT NULL,
  `service_type_code` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
