CREATE TABLE `asset_parts` (
  `asset_id` int DEFAULT NULL,
  `part_id` int DEFAULT NULL,
  KEY `asset_id` (`asset_id`),
  KEY `part_id` (`part_id`),
  CONSTRAINT `asset_parts_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`),
  CONSTRAINT `asset_parts_ibfk_2` FOREIGN KEY (`part_id`) REFERENCES `parts` (`part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `assets` (
  `asset_id` int NOT NULL,
  `maintenance_contract_id` int DEFAULT NULL,
  `supplier_company_id` int DEFAULT NULL,
  `asset_details` varchar(255) DEFAULT NULL,
  `asset_make` varchar(20) DEFAULT NULL,
  `asset_model` varchar(20) DEFAULT NULL,
  `asset_acquired_date` datetime DEFAULT NULL,
  `asset_disposed_date` datetime DEFAULT NULL,
  `other_asset_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`asset_id`),
  KEY `supplier_company_id` (`supplier_company_id`),
  KEY `maintenance_contract_id` (`maintenance_contract_id`),
  CONSTRAINT `assets_ibfk_1` FOREIGN KEY (`supplier_company_id`) REFERENCES `third_party_companies` (`company_id`),
  CONSTRAINT `assets_ibfk_2` FOREIGN KEY (`maintenance_contract_id`) REFERENCES `maintenance_contracts` (`maintenance_contract_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `engineer_skills` (
  `engineer_id` int DEFAULT NULL,
  `skill_id` int DEFAULT NULL,
  KEY `skill_id` (`skill_id`),
  KEY `engineer_id` (`engineer_id`),
  CONSTRAINT `engineer_skills_ibfk_1` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`skill_id`),
  CONSTRAINT `engineer_skills_ibfk_2` FOREIGN KEY (`engineer_id`) REFERENCES `maintenance_engineers` (`engineer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `engineer_visits` (
  `engineer_visit_id` int NOT NULL,
  `contact_staff_id` int DEFAULT NULL,
  `engineer_id` int DEFAULT NULL,
  `fault_log_entry_id` int DEFAULT NULL,
  `fault_status` varchar(10) DEFAULT NULL,
  `visit_start_datetime` datetime DEFAULT NULL,
  `visit_end_datetime` datetime DEFAULT NULL,
  `other_visit_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`engineer_visit_id`),
  KEY `contact_staff_id` (`contact_staff_id`),
  KEY `engineer_id` (`engineer_id`),
  KEY `fault_log_entry_id` (`fault_log_entry_id`),
  CONSTRAINT `engineer_visits_ibfk_1` FOREIGN KEY (`contact_staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `engineer_visits_ibfk_2` FOREIGN KEY (`engineer_id`) REFERENCES `maintenance_engineers` (`engineer_id`),
  CONSTRAINT `engineer_visits_ibfk_3` FOREIGN KEY (`fault_log_entry_id`) REFERENCES `fault_log` (`fault_log_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `fault_log` (
  `fault_log_entry_id` int NOT NULL,
  `asset_id` int DEFAULT NULL,
  `recorded_by_staff_id` int DEFAULT NULL,
  `fault_log_entry_datetime` datetime DEFAULT NULL,
  `fault_description` varchar(255) DEFAULT NULL,
  `other_fault_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fault_log_entry_id`),
  KEY `recorded_by_staff_id` (`recorded_by_staff_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `fault_log_ibfk_1` FOREIGN KEY (`recorded_by_staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `fault_log_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `fault_log_parts` (
  `fault_log_entry_id` int DEFAULT NULL,
  `part_fault_id` int DEFAULT NULL,
  `fault_status` varchar(10) DEFAULT NULL,
  KEY `fault_log_entry_id` (`fault_log_entry_id`),
  KEY `part_fault_id` (`part_fault_id`),
  CONSTRAINT `fault_log_parts_ibfk_1` FOREIGN KEY (`fault_log_entry_id`) REFERENCES `fault_log` (`fault_log_entry_id`),
  CONSTRAINT `fault_log_parts_ibfk_2` FOREIGN KEY (`part_fault_id`) REFERENCES `part_faults` (`part_fault_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `maintenance_contracts` (
  `maintenance_contract_id` int NOT NULL,
  `maintenance_contract_company_id` int DEFAULT NULL,
  `contract_start_date` datetime DEFAULT NULL,
  `contract_end_date` datetime DEFAULT NULL,
  `other_contract_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`maintenance_contract_id`),
  KEY `maintenance_contract_company_id` (`maintenance_contract_company_id`),
  CONSTRAINT `maintenance_contracts_ibfk_1` FOREIGN KEY (`maintenance_contract_company_id`) REFERENCES `third_party_companies` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `maintenance_engineers` (
  `engineer_id` int NOT NULL,
  `company_id` int DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`engineer_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `maintenance_engineers_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `third_party_companies` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `part_faults` (
  `part_fault_id` int NOT NULL,
  `part_id` int DEFAULT NULL,
  `fault_short_name` varchar(20) DEFAULT NULL,
  `fault_description` varchar(255) DEFAULT NULL,
  `other_fault_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`part_fault_id`),
  KEY `part_id` (`part_id`),
  CONSTRAINT `part_faults_ibfk_1` FOREIGN KEY (`part_id`) REFERENCES `parts` (`part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `parts` (
  `part_id` int NOT NULL,
  `part_name` varchar(255) DEFAULT NULL,
  `chargeable_yn` varchar(1) DEFAULT NULL,
  `chargeable_amount` varchar(20) DEFAULT NULL,
  `other_part_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `skills` (
  `skill_id` int NOT NULL,
  `skill_code` varchar(20) DEFAULT NULL,
  `skill_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `skills_required_to_fix` (
  `part_fault_id` int DEFAULT NULL,
  `skill_id` int DEFAULT NULL,
  KEY `skill_id` (`skill_id`),
  KEY `part_fault_id` (`part_fault_id`),
  CONSTRAINT `skills_required_to_fix_ibfk_1` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`skill_id`),
  CONSTRAINT `skills_required_to_fix_ibfk_2` FOREIGN KEY (`part_fault_id`) REFERENCES `part_faults` (`part_fault_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `staff_name` varchar(255) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `other_staff_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `third_party_companies` (
  `company_id` int NOT NULL,
  `company_type` varchar(22) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `company_address` varchar(255) DEFAULT NULL,
  `other_company_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
