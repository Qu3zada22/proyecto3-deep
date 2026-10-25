CREATE TABLE `customer_event_notes` (
  `customer_event_note_id` int NOT NULL,
  `customer_event_id` int DEFAULT NULL,
  `service_type_code` varchar(15) DEFAULT NULL,
  `resident_id` int DEFAULT NULL,
  `property_id` int DEFAULT NULL,
  `date_moved_in` datetime DEFAULT NULL,
  PRIMARY KEY (`customer_event_note_id`),
  KEY `customer_event_id` (`customer_event_id`),
  CONSTRAINT `customer_event_notes_ibfk_1` FOREIGN KEY (`customer_event_id`) REFERENCES `customer_events` (`customer_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_events` (
  `customer_event_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `date_moved_in` datetime DEFAULT NULL,
  `property_id` int DEFAULT NULL,
  `resident_id` int DEFAULT NULL,
  `thing_id` int DEFAULT NULL,
  PRIMARY KEY (`customer_event_id`),
  KEY `customer_id` (`customer_id`),
  KEY `thing_id` (`thing_id`),
  CONSTRAINT `customer_events_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `customer_events_ibfk_2` FOREIGN KEY (`thing_id`) REFERENCES `things` (`thing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `organizations` (
  `organization_id` int NOT NULL,
  `parent_organization_id` int DEFAULT NULL,
  `organization_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `properties` (
  `property_id` int NOT NULL,
  `property_type_code` varchar(15) DEFAULT NULL,
  `property_address` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `residents` (
  `resident_id` int NOT NULL,
  `property_id` int NOT NULL,
  `date_moved_in` datetime NOT NULL,
  `date_moved_out` datetime DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`resident_id`,`property_id`,`date_moved_in`),
  KEY `property_id` (`property_id`),
  CONSTRAINT `residents_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `residents_services` (
  `resident_id` int NOT NULL,
  `service_id` int NOT NULL,
  `date_moved_in` datetime DEFAULT NULL,
  `property_id` int DEFAULT NULL,
  `date_requested` datetime DEFAULT NULL,
  `date_provided` datetime DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`resident_id`,`service_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `residents_services_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `services` (
  `service_id` int NOT NULL,
  `organization_id` int DEFAULT NULL,
  `service_type_code` varchar(15) DEFAULT NULL,
  `service_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`service_id`),
  KEY `organization_id` (`organization_id`),
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `things` (
  `thing_id` int NOT NULL,
  `organization_id` int DEFAULT NULL,
  `type_of_thing_code` varchar(15) DEFAULT NULL,
  `service_type_code` varchar(10) DEFAULT NULL,
  `service_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`thing_id`),
  KEY `organization_id` (`organization_id`),
  CONSTRAINT `things_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `timed_locations_of_things` (
  `thing_id` int NOT NULL,
  `date_and_time` datetime NOT NULL,
  `location_code` varchar(15) NOT NULL,
  PRIMARY KEY (`thing_id`,`date_and_time`,`location_code`),
  CONSTRAINT `timed_locations_of_things_ibfk_1` FOREIGN KEY (`thing_id`) REFERENCES `things` (`thing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `timed_status_of_things` (
  `thing_id` int NOT NULL,
  `date_and_date` datetime NOT NULL,
  `status_of_thing_code` varchar(15) NOT NULL,
  PRIMARY KEY (`thing_id`,`date_and_date`,`status_of_thing_code`),
  CONSTRAINT `timed_status_of_things_ibfk_1` FOREIGN KEY (`thing_id`) REFERENCES `things` (`thing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
