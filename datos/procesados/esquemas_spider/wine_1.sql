CREATE TABLE `appellations` (
  `no` int NOT NULL,
  `appelation` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `isava` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `grapes` (
  `id` int NOT NULL,
  `grape` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `wine` (
  `no` int DEFAULT NULL,
  `grape` varchar(50) DEFAULT NULL,
  `winery` varchar(50) DEFAULT NULL,
  `appelation` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  `cases` int DEFAULT NULL,
  `drink` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
