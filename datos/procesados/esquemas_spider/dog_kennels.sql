CREATE TABLE `breeds` (
  `breed_code` varchar(10) NOT NULL,
  `breed_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`breed_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `charges` (
  `charge_id` int NOT NULL,
  `charge_type` varchar(19) DEFAULT NULL,
  `charge_amount` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`charge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `dogs` (
  `dog_id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `abandoned_yn` varchar(1) DEFAULT NULL,
  `breed_code` varchar(10) DEFAULT NULL,
  `size_code` varchar(10) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` varchar(20) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `weight` varchar(20) DEFAULT NULL,
  `date_arrived` datetime DEFAULT NULL,
  `date_adopted` datetime DEFAULT NULL,
  `date_departed` datetime DEFAULT NULL,
  PRIMARY KEY (`dog_id`),
  KEY `owner_id` (`owner_id`),
  KEY `size_code` (`size_code`),
  KEY `breed_code` (`breed_code`),
  CONSTRAINT `dogs_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`owner_id`),
  CONSTRAINT `dogs_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`owner_id`),
  CONSTRAINT `dogs_ibfk_3` FOREIGN KEY (`size_code`) REFERENCES `sizes` (`size_code`),
  CONSTRAINT `dogs_ibfk_4` FOREIGN KEY (`breed_code`) REFERENCES `breeds` (`breed_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `owners` (
  `owner_id` int NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `home_phone` varchar(20) DEFAULT NULL,
  `cell_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `professionals` (
  `professional_id` int NOT NULL,
  `role_code` varchar(12) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `home_phone` varchar(20) DEFAULT NULL,
  `cell_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`professional_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sizes` (
  `size_code` varchar(10) NOT NULL,
  `size_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`size_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `treatment_types` (
  `treatment_type_code` varchar(10) NOT NULL,
  `treatment_type_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`treatment_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `treatments` (
  `treatment_id` int NOT NULL,
  `dog_id` int DEFAULT NULL,
  `professional_id` int DEFAULT NULL,
  `treatment_type_code` varchar(10) DEFAULT NULL,
  `date_of_treatment` datetime DEFAULT NULL,
  `cost_of_treatment` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`treatment_id`),
  KEY `dog_id` (`dog_id`),
  KEY `professional_id` (`professional_id`),
  KEY `treatment_type_code` (`treatment_type_code`),
  CONSTRAINT `treatments_ibfk_1` FOREIGN KEY (`dog_id`) REFERENCES `dogs` (`dog_id`),
  CONSTRAINT `treatments_ibfk_2` FOREIGN KEY (`professional_id`) REFERENCES `professionals` (`professional_id`),
  CONSTRAINT `treatments_ibfk_3` FOREIGN KEY (`treatment_type_code`) REFERENCES `treatment_types` (`treatment_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
