CREATE TABLE `book` (
  `book_id` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `issues` double DEFAULT NULL,
  `writer` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `publication` (
  `publication_id` int NOT NULL,
  `book_id` int DEFAULT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  `publication_date` varchar(50) DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`publication_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `publication_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
