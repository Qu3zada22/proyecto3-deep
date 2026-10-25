CREATE TABLE `building` (
  `building_id` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `street_address` varchar(50) DEFAULT NULL,
  `years_as_tallest` varchar(50) DEFAULT NULL,
  `height_feet` int DEFAULT NULL,
  `floors` int DEFAULT NULL,
  PRIMARY KEY (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `institution` (
  `institution_id` varchar(50) NOT NULL,
  `institution` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `founded` double DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `enrollment` int DEFAULT NULL,
  `team` varchar(50) DEFAULT NULL,
  `primary_conference` varchar(50) DEFAULT NULL,
  `building_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`institution_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `institution_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `protein` (
  `common_name` varchar(50) NOT NULL,
  `protein_name` varchar(50) DEFAULT NULL,
  `divergence_from_human_lineage` double DEFAULT NULL,
  `accession_number` varchar(50) DEFAULT NULL,
  `sequence_length` double DEFAULT NULL,
  `sequence_identity_to_human_protein` varchar(50) DEFAULT NULL,
  `institution_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`common_name`),
  KEY `institution_id` (`institution_id`),
  CONSTRAINT `protein_ibfk_1` FOREIGN KEY (`institution_id`) REFERENCES `institution` (`institution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
