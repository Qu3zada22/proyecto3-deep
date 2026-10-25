CREATE TABLE `affiliated_with` (
  `physician` int NOT NULL,
  `department` int NOT NULL,
  `primaryaffiliation` int DEFAULT NULL,
  PRIMARY KEY (`physician`,`department`),
  KEY `department` (`department`),
  CONSTRAINT `affiliated_with_ibfk_1` FOREIGN KEY (`department`) REFERENCES `department` (`departmentid`),
  CONSTRAINT `affiliated_with_ibfk_2` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `appointment` (
  `appointmentid` int NOT NULL,
  `patient` int DEFAULT NULL,
  `prepnurse` int DEFAULT NULL,
  `physician` int DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `examinationroom` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`appointmentid`),
  KEY `physician` (`physician`),
  KEY `prepnurse` (`prepnurse`),
  KEY `patient` (`patient`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`prepnurse`) REFERENCES `nurse` (`employeeid`),
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `block` (
  `blockfloor` int NOT NULL,
  `blockcode` int NOT NULL,
  PRIMARY KEY (`blockfloor`,`blockcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `department` (
  `departmentid` int NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `head` int DEFAULT NULL,
  PRIMARY KEY (`departmentid`),
  KEY `head` (`head`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`head`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `medication` (
  `code` int NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `brand` varchar(30) DEFAULT NULL,
  `description` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `nurse` (
  `employeeid` int NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `position` varchar(30) DEFAULT NULL,
  `registered` int DEFAULT NULL,
  `ssn` int DEFAULT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `on_call` (
  `nurse` int NOT NULL,
  `blockfloor` int NOT NULL,
  `blockcode` int NOT NULL,
  `oncallstart` datetime NOT NULL,
  `oncallend` datetime NOT NULL,
  PRIMARY KEY (`nurse`,`blockfloor`,`blockcode`,`oncallstart`,`oncallend`),
  CONSTRAINT `on_call_ibfk_1` FOREIGN KEY (`nurse`) REFERENCES `nurse` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `patient` (
  `ssn` int NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `insuranceid` int DEFAULT NULL,
  `pcp` int DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  KEY `pcp` (`pcp`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`pcp`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `physician` (
  `employeeid` int NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `position` varchar(30) DEFAULT NULL,
  `ssn` int DEFAULT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `prescribes` (
  `physician` int NOT NULL,
  `patient` int NOT NULL,
  `medication` int NOT NULL,
  `date` datetime NOT NULL,
  `appointment` int DEFAULT NULL,
  `dose` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`physician`,`patient`,`medication`,`date`),
  KEY `appointment` (`appointment`),
  KEY `medication` (`medication`),
  KEY `patient` (`patient`),
  CONSTRAINT `prescribes_ibfk_1` FOREIGN KEY (`appointment`) REFERENCES `appointment` (`appointmentid`),
  CONSTRAINT `prescribes_ibfk_2` FOREIGN KEY (`medication`) REFERENCES `medication` (`code`),
  CONSTRAINT `prescribes_ibfk_3` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`),
  CONSTRAINT `prescribes_ibfk_4` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `procedures` (
  `code` int NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `cost` double DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `room` (
  `roomnumber` int NOT NULL,
  `roomtype` varchar(30) DEFAULT NULL,
  `blockfloor` int DEFAULT NULL,
  `blockcode` int DEFAULT NULL,
  `unavailable` int DEFAULT NULL,
  PRIMARY KEY (`roomnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `stay` (
  `stayid` int NOT NULL,
  `patient` int DEFAULT NULL,
  `room` int DEFAULT NULL,
  `staystart` date DEFAULT NULL,
  `stayend` date DEFAULT NULL,
  PRIMARY KEY (`stayid`),
  KEY `room` (`room`),
  KEY `patient` (`patient`),
  CONSTRAINT `stay_ibfk_1` FOREIGN KEY (`room`) REFERENCES `room` (`roomnumber`),
  CONSTRAINT `stay_ibfk_2` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `trained_in` (
  `physician` int NOT NULL,
  `treatment` int NOT NULL,
  `certificationdate` date DEFAULT NULL,
  `certificationexpires` date DEFAULT NULL,
  PRIMARY KEY (`physician`,`treatment`),
  KEY `treatment` (`treatment`),
  CONSTRAINT `trained_in_ibfk_1` FOREIGN KEY (`treatment`) REFERENCES `procedures` (`code`),
  CONSTRAINT `trained_in_ibfk_2` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `undergoes` (
  `patient` int NOT NULL,
  `procedures` int NOT NULL,
  `stay` int NOT NULL,
  `dateundergoes` date NOT NULL,
  `physician` int DEFAULT NULL,
  `assistingnurse` int DEFAULT NULL,
  PRIMARY KEY (`patient`,`procedures`,`stay`,`dateundergoes`),
  KEY `assistingnurse` (`assistingnurse`),
  KEY `physician` (`physician`),
  KEY `stay` (`stay`),
  KEY `procedures` (`procedures`),
  CONSTRAINT `undergoes_ibfk_1` FOREIGN KEY (`assistingnurse`) REFERENCES `nurse` (`employeeid`),
  CONSTRAINT `undergoes_ibfk_2` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`),
  CONSTRAINT `undergoes_ibfk_3` FOREIGN KEY (`stay`) REFERENCES `stay` (`stayid`),
  CONSTRAINT `undergoes_ibfk_4` FOREIGN KEY (`procedures`) REFERENCES `procedures` (`code`),
  CONSTRAINT `undergoes_ibfk_5` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
