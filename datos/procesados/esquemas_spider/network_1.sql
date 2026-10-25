CREATE TABLE `friend` (
  `student_id` int NOT NULL,
  `friend_id` int NOT NULL,
  PRIMARY KEY (`student_id`,`friend_id`),
  KEY `friend_id` (`friend_id`),
  CONSTRAINT `friend_ibfk_1` FOREIGN KEY (`friend_id`) REFERENCES `highschooler` (`id`),
  CONSTRAINT `friend_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `highschooler` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `highschooler` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `grade` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `likes` (
  `student_id` int NOT NULL,
  `liked_id` int NOT NULL,
  PRIMARY KEY (`student_id`,`liked_id`),
  KEY `liked_id` (`liked_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `highschooler` (`id`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`liked_id`) REFERENCES `highschooler` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
