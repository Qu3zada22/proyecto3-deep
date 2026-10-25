CREATE TABLE `department` (
  `dname` varchar(50) DEFAULT NULL,
  `dnumber` int NOT NULL,
  `mgr_ssn` int DEFAULT NULL,
  `mgr_start_date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `dependent` (
  `essn` int NOT NULL,
  `dependent_name` varchar(50) NOT NULL,
  `sex` varchar(50) DEFAULT NULL,
  `bdate` varchar(50) DEFAULT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`essn`,`dependent_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `dept_locations` (
  `dnumber` int NOT NULL,
  `dlocation` varchar(50) NOT NULL,
  PRIMARY KEY (`dnumber`,`dlocation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employee` (
  `fname` varchar(50) DEFAULT NULL,
  `minit` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `ssn` int NOT NULL,
  `bdate` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `sex` varchar(50) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `super_ssn` int DEFAULT NULL,
  `dno` int DEFAULT NULL,
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `project` (
  `pname` varchar(50) DEFAULT NULL,
  `pnumber` int NOT NULL,
  `plocation` varchar(50) DEFAULT NULL,
  `dnum` int DEFAULT NULL,
  PRIMARY KEY (`pnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `works_on` (
  `essn` int NOT NULL,
  `pno` int NOT NULL,
  `hours` double DEFAULT NULL,
  PRIMARY KEY (`essn`,`pno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
