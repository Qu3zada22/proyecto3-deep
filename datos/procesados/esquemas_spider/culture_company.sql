CREATE TABLE `book_club` (
  `book_club_id` int NOT NULL,
  `year` int DEFAULT NULL,
  `author_or_editor` varchar(50) DEFAULT NULL,
  `book_title` varchar(50) DEFAULT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`book_club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `culture_company` (
  `company_name` varchar(50) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `incorporated_in` varchar(50) DEFAULT NULL,
  `group_equity_shareholding` double DEFAULT NULL,
  `book_club_id` int DEFAULT NULL,
  `movie_id` int DEFAULT NULL,
  PRIMARY KEY (`company_name`),
  KEY `movie_id` (`movie_id`),
  KEY `book_club_id` (`book_club_id`),
  CONSTRAINT `culture_company_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`),
  CONSTRAINT `culture_company_ibfk_2` FOREIGN KEY (`book_club_id`) REFERENCES `book_club` (`book_club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `movie` (
  `movie_id` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `director` varchar(50) DEFAULT NULL,
  `budget_million` double DEFAULT NULL,
  `gross_worldwide` int DEFAULT NULL,
  PRIMARY KEY (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
