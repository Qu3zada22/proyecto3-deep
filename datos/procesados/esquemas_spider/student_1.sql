CREATE TABLE `list` (
  `lastname` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `grade` int DEFAULT NULL,
  `classroom` int DEFAULT NULL,
  PRIMARY KEY (`lastname`,`firstname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `teachers` (
  `lastname` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `classroom` int DEFAULT NULL,
  PRIMARY KEY (`lastname`,`firstname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
