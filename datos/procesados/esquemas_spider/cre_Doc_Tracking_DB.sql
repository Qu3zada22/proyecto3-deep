CREATE TABLE `all_documents` (
  `document_id` int NOT NULL,
  `date_stored` datetime DEFAULT NULL,
  `document_type_code` varchar(15) DEFAULT NULL,
  `document_name` varchar(255) DEFAULT NULL,
  `document_description` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `date_stored` (`date_stored`),
  KEY `document_type_code` (`document_type_code`),
  CONSTRAINT `all_documents_ibfk_1` FOREIGN KEY (`date_stored`) REFERENCES `ref_calendar` (`calendar_date`),
  CONSTRAINT `all_documents_ibfk_2` FOREIGN KEY (`document_type_code`) REFERENCES `ref_document_types` (`document_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `document_locations` (
  `document_id` int NOT NULL,
  `location_code` varchar(15) NOT NULL,
  `date_in_location_from` datetime NOT NULL,
  `date_in_locaton_to` datetime DEFAULT NULL,
  PRIMARY KEY (`document_id`,`location_code`,`date_in_location_from`),
  KEY `date_in_locaton_to` (`date_in_locaton_to`),
  KEY `date_in_location_from` (`date_in_location_from`),
  KEY `location_code` (`location_code`),
  CONSTRAINT `document_locations_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `all_documents` (`document_id`),
  CONSTRAINT `document_locations_ibfk_2` FOREIGN KEY (`date_in_locaton_to`) REFERENCES `ref_calendar` (`calendar_date`),
  CONSTRAINT `document_locations_ibfk_3` FOREIGN KEY (`date_in_location_from`) REFERENCES `ref_calendar` (`calendar_date`),
  CONSTRAINT `document_locations_ibfk_4` FOREIGN KEY (`location_code`) REFERENCES `ref_locations` (`location_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `documents_to_be_destroyed` (
  `document_id` int NOT NULL,
  `destruction_authorised_by_employee_id` int DEFAULT NULL,
  `destroyed_by_employee_id` int DEFAULT NULL,
  `planned_destruction_date` datetime DEFAULT NULL,
  `actual_destruction_date` datetime DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `actual_destruction_date` (`actual_destruction_date`),
  KEY `planned_destruction_date` (`planned_destruction_date`),
  KEY `destruction_authorised_by_employee_id` (`destruction_authorised_by_employee_id`),
  KEY `destroyed_by_employee_id` (`destroyed_by_employee_id`),
  CONSTRAINT `documents_to_be_destroyed_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `all_documents` (`document_id`),
  CONSTRAINT `documents_to_be_destroyed_ibfk_2` FOREIGN KEY (`actual_destruction_date`) REFERENCES `ref_calendar` (`calendar_date`),
  CONSTRAINT `documents_to_be_destroyed_ibfk_3` FOREIGN KEY (`planned_destruction_date`) REFERENCES `ref_calendar` (`calendar_date`),
  CONSTRAINT `documents_to_be_destroyed_ibfk_4` FOREIGN KEY (`destruction_authorised_by_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `documents_to_be_destroyed_ibfk_5` FOREIGN KEY (`destroyed_by_employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employees` (
  `employee_id` int NOT NULL,
  `role_code` varchar(15) DEFAULT NULL,
  `employee_name` varchar(255) DEFAULT NULL,
  `gender_mfu` varchar(1) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `role_code` (`role_code`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`role_code`) REFERENCES `roles` (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_calendar` (
  `calendar_date` datetime NOT NULL,
  `day_number` int DEFAULT NULL,
  PRIMARY KEY (`calendar_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_document_types` (
  `document_type_code` varchar(15) NOT NULL,
  `document_type_name` varchar(255) DEFAULT NULL,
  `document_type_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_locations` (
  `location_code` varchar(15) NOT NULL,
  `location_name` varchar(255) DEFAULT NULL,
  `location_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `roles` (
  `role_code` varchar(15) NOT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `role_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
