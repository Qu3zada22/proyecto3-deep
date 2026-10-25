CREATE TABLE `reservations` (
  `code` int NOT NULL,
  `room` varchar(50) DEFAULT NULL,
  `checkin` varchar(50) DEFAULT NULL,
  `checkout` varchar(50) DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `adults` int DEFAULT NULL,
  `kids` int DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `room` (`room`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`room`) REFERENCES `rooms` (`roomid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `rooms` (
  `roomid` varchar(50) NOT NULL,
  `roomname` varchar(50) DEFAULT NULL,
  `beds` int DEFAULT NULL,
  `bedtype` varchar(50) DEFAULT NULL,
  `maxoccupancy` int DEFAULT NULL,
  `baseprice` int DEFAULT NULL,
  `decor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`roomid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
