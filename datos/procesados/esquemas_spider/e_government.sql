CREATE TABLE `addresses` (
  `address_id` int NOT NULL,
  `line_1_number_building` varchar(80) DEFAULT NULL,
  `town_city` varchar(50) DEFAULT NULL,
  `zip_postcode` varchar(20) DEFAULT NULL,
  `state_province_county` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `forms` (
  `form_id` int NOT NULL,
  `form_type_code` varchar(15) DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `form_number` varchar(50) DEFAULT NULL,
  `form_name` varchar(80) DEFAULT NULL,
  `form_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`form_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `forms_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `individuals` (
  `individual_id` int NOT NULL,
  `individual_first_name` varchar(80) DEFAULT NULL,
  `individual_middle_name` varchar(80) DEFAULT NULL,
  `inidividual_phone` varchar(80) DEFAULT NULL,
  `individual_email` varchar(80) DEFAULT NULL,
  `individual_address` varchar(255) DEFAULT NULL,
  `individual_last_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`individual_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `organization_contact_individuals` (
  `individual_id` int NOT NULL,
  `organization_id` int NOT NULL,
  `date_contact_from` datetime DEFAULT NULL,
  `date_contact_to` datetime DEFAULT NULL,
  PRIMARY KEY (`individual_id`,`organization_id`),
  KEY `organization_id` (`organization_id`),
  CONSTRAINT `organization_contact_individuals_ibfk_1` FOREIGN KEY (`individual_id`) REFERENCES `individuals` (`individual_id`),
  CONSTRAINT `organization_contact_individuals_ibfk_2` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `organizations` (
  `organization_id` int NOT NULL,
  `date_formed` datetime DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `uk_vat_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `parties` (
  `party_id` int NOT NULL,
  `payment_method_code` varchar(15) DEFAULT NULL,
  `party_phone` varchar(80) DEFAULT NULL,
  `party_email` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `party_addresses` (
  `party_id` int NOT NULL,
  `address_id` int NOT NULL,
  `date_address_from` datetime DEFAULT NULL,
  `address_type_code` varchar(15) DEFAULT NULL,
  `date_address_to` datetime DEFAULT NULL,
  PRIMARY KEY (`party_id`,`address_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `party_addresses_ibfk_1` FOREIGN KEY (`party_id`) REFERENCES `parties` (`party_id`),
  CONSTRAINT `party_addresses_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `party_forms` (
  `party_id` int NOT NULL,
  `form_id` int NOT NULL,
  `date_completion_started` datetime DEFAULT NULL,
  `form_status_code` varchar(19) DEFAULT NULL,
  `date_fully_completed` datetime DEFAULT NULL,
  PRIMARY KEY (`party_id`,`form_id`),
  KEY `form_id` (`form_id`),
  CONSTRAINT `party_forms_ibfk_1` FOREIGN KEY (`form_id`) REFERENCES `forms` (`form_id`),
  CONSTRAINT `party_forms_ibfk_2` FOREIGN KEY (`party_id`) REFERENCES `parties` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `party_services` (
  `booking_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `service_datetime` datetime DEFAULT NULL,
  `booking_made_date` datetime DEFAULT NULL,
  KEY `customer_id` (`customer_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `party_services_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `parties` (`party_id`),
  CONSTRAINT `party_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `services` (
  `service_id` int NOT NULL,
  `service_type_code` varchar(15) DEFAULT NULL,
  `service_name` varchar(80) DEFAULT NULL,
  `service_descriptio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
