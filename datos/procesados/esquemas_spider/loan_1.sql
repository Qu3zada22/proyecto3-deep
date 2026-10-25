CREATE TABLE `bank` (
  `branch_id` int NOT NULL,
  `bname` varchar(20) DEFAULT NULL,
  `no_of_customers` int DEFAULT NULL,
  `city` varchar(14) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer` (
  `cust_id` varchar(3) NOT NULL,
  `cust_name` varchar(20) DEFAULT NULL,
  `acc_type` varchar(8) DEFAULT NULL,
  `acc_bal` int DEFAULT NULL,
  `no_of_loans` int DEFAULT NULL,
  `credit_score` int DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cust_id`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `bank` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `loan` (
  `loan_id` varchar(3) NOT NULL,
  `loan_type` varchar(15) DEFAULT NULL,
  `cust_id` varchar(3) DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `cust_id` (`cust_id`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`),
  CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `bank` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
