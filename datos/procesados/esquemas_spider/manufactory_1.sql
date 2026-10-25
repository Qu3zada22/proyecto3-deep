CREATE TABLE `manufacturers` (
  `code` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `headquarter` varchar(255) DEFAULT NULL,
  `founder` varchar(255) DEFAULT NULL,
  `revenue` double DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `code` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `manufacturer` int DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `manufacturer` (`manufacturer`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`manufacturer`) REFERENCES `manufacturers` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
