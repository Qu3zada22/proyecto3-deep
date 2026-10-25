CREATE TABLE `problem_category_codes` (
  `problem_category_code` varchar(20) NOT NULL,
  `problem_category_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`problem_category_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `problem_log` (
  `problem_log_id` int NOT NULL,
  `assigned_to_staff_id` int DEFAULT NULL,
  `problem_id` int DEFAULT NULL,
  `problem_category_code` varchar(20) DEFAULT NULL,
  `problem_status_code` varchar(20) DEFAULT NULL,
  `log_entry_date` datetime DEFAULT NULL,
  `log_entry_description` varchar(255) DEFAULT NULL,
  `log_entry_fix` varchar(255) DEFAULT NULL,
  `other_log_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`problem_log_id`),
  KEY `problem_status_code` (`problem_status_code`),
  KEY `problem_id` (`problem_id`),
  KEY `assigned_to_staff_id` (`assigned_to_staff_id`),
  KEY `problem_category_code` (`problem_category_code`),
  CONSTRAINT `problem_log_ibfk_1` FOREIGN KEY (`problem_status_code`) REFERENCES `problem_status_codes` (`problem_status_code`),
  CONSTRAINT `problem_log_ibfk_2` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`problem_id`),
  CONSTRAINT `problem_log_ibfk_3` FOREIGN KEY (`assigned_to_staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `problem_log_ibfk_4` FOREIGN KEY (`problem_category_code`) REFERENCES `problem_category_codes` (`problem_category_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `problem_status_codes` (
  `problem_status_code` varchar(20) NOT NULL,
  `problem_status_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`problem_status_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `problems` (
  `problem_id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `closure_authorised_by_staff_id` int DEFAULT NULL,
  `reported_by_staff_id` int DEFAULT NULL,
  `date_problem_reported` datetime DEFAULT NULL,
  `date_problem_closed` datetime DEFAULT NULL,
  `problem_description` varchar(255) DEFAULT NULL,
  `other_problem_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`problem_id`),
  KEY `reported_by_staff_id` (`reported_by_staff_id`),
  KEY `product_id` (`product_id`),
  KEY `closure_authorised_by_staff_id` (`closure_authorised_by_staff_id`),
  CONSTRAINT `problems_ibfk_1` FOREIGN KEY (`reported_by_staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `problems_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `problems_ibfk_3` FOREIGN KEY (`closure_authorised_by_staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product` (
  `product_id` int NOT NULL,
  `product_name` varchar(80) DEFAULT NULL,
  `product_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `staff_first_name` varchar(80) DEFAULT NULL,
  `staff_last_name` varchar(80) DEFAULT NULL,
  `other_staff_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
