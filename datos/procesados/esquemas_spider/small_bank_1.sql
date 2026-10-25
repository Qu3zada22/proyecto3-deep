CREATE TABLE `accounts` (
  `custid` int NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`custid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `checking` (
  `custid` int NOT NULL,
  `balance` double DEFAULT NULL,
  PRIMARY KEY (`custid`),
  CONSTRAINT `checking_ibfk_1` FOREIGN KEY (`custid`) REFERENCES `accounts` (`custid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `savings` (
  `custid` int NOT NULL,
  `balance` double DEFAULT NULL,
  PRIMARY KEY (`custid`),
  CONSTRAINT `savings_ibfk_1` FOREIGN KEY (`custid`) REFERENCES `accounts` (`custid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
