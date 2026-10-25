CREATE TABLE `countries` (
  `country_id` varchar(2) NOT NULL,
  `country_name` varchar(40) DEFAULT NULL,
  `region_id` decimal(5,0) DEFAULT NULL,
  PRIMARY KEY (`country_id`),
  KEY `region_id` (`region_id`),
  CONSTRAINT `countries_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `regions` (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `departments` (
  `department_id` decimal(4,0) NOT NULL,
  `department_name` varchar(30) DEFAULT NULL,
  `manager_id` decimal(6,0) DEFAULT NULL,
  `location_id` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employees` (
  `employee_id` decimal(6,0) NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(25) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `job_id` varchar(10) DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  `commission_pct` decimal(2,2) DEFAULT NULL,
  `manager_id` decimal(6,0) DEFAULT NULL,
  `department_id` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `job_id` (`job_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`),
  CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `job_history` (
  `employee_id` decimal(6,0) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `job_id` varchar(10) DEFAULT NULL,
  `department_id` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`employee_id`,`start_date`),
  KEY `job_id` (`job_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `job_history_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`),
  CONSTRAINT `job_history_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `job_history_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `jobs` (
  `job_id` varchar(10) NOT NULL,
  `job_title` varchar(35) DEFAULT NULL,
  `min_salary` decimal(6,0) DEFAULT NULL,
  `max_salary` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `locations` (
  `location_id` decimal(4,0) NOT NULL,
  `street_address` varchar(40) DEFAULT NULL,
  `postal_code` varchar(12) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state_province` varchar(25) DEFAULT NULL,
  `country_id` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `regions` (
  `region_id` decimal(5,0) NOT NULL,
  `region_name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
