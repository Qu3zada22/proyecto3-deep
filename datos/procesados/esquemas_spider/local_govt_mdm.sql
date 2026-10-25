CREATE TABLE `benefits_overpayments` (
  `council_tax_id` int NOT NULL,
  `cmi_cross_ref_id` int DEFAULT NULL,
  PRIMARY KEY (`council_tax_id`),
  KEY `cmi_cross_ref_id` (`cmi_cross_ref_id`),
  CONSTRAINT `benefits_overpayments_ibfk_1` FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `cmi_cross_references` (`cmi_cross_ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `business_rates` (
  `business_rates_id` int NOT NULL,
  `cmi_cross_ref_id` int DEFAULT NULL,
  PRIMARY KEY (`business_rates_id`),
  KEY `cmi_cross_ref_id` (`cmi_cross_ref_id`),
  CONSTRAINT `business_rates_ibfk_1` FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `cmi_cross_references` (`cmi_cross_ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cmi_cross_references` (
  `cmi_cross_ref_id` int NOT NULL,
  `master_customer_id` int DEFAULT NULL,
  `source_system_code` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`cmi_cross_ref_id`),
  KEY `master_customer_id` (`master_customer_id`),
  CONSTRAINT `cmi_cross_references_ibfk_1` FOREIGN KEY (`master_customer_id`) REFERENCES `customer_master_index` (`master_customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `council_tax` (
  `council_tax_id` int NOT NULL,
  `cmi_cross_ref_id` int DEFAULT NULL,
  PRIMARY KEY (`council_tax_id`),
  KEY `cmi_cross_ref_id` (`cmi_cross_ref_id`),
  CONSTRAINT `council_tax_ibfk_1` FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `cmi_cross_references` (`cmi_cross_ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer_master_index` (
  `master_customer_id` int NOT NULL,
  `cmi_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`master_customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `electoral_register` (
  `electoral_register_id` int NOT NULL,
  `cmi_cross_ref_id` int DEFAULT NULL,
  PRIMARY KEY (`electoral_register_id`),
  KEY `cmi_cross_ref_id` (`cmi_cross_ref_id`),
  CONSTRAINT `electoral_register_ibfk_1` FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `cmi_cross_references` (`cmi_cross_ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `parking_fines` (
  `council_tax_id` int NOT NULL,
  `cmi_cross_ref_id` int DEFAULT NULL,
  PRIMARY KEY (`council_tax_id`),
  KEY `cmi_cross_ref_id` (`cmi_cross_ref_id`),
  CONSTRAINT `parking_fines_ibfk_1` FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `cmi_cross_references` (`cmi_cross_ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `rent_arrears` (
  `council_tax_id` int NOT NULL,
  `cmi_cross_ref_id` int DEFAULT NULL,
  PRIMARY KEY (`council_tax_id`),
  KEY `cmi_cross_ref_id` (`cmi_cross_ref_id`),
  CONSTRAINT `rent_arrears_ibfk_1` FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `cmi_cross_references` (`cmi_cross_ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
