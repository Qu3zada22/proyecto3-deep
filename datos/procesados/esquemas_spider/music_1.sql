CREATE TABLE `artist` (
  `artist_name` varchar(50) NOT NULL,
  `country` varchar(20) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `preferred_genre` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`artist_name`),
  KEY `preferred_genre` (`preferred_genre`),
  CONSTRAINT `artist_ibfk_1` FOREIGN KEY (`preferred_genre`) REFERENCES `genre` (`g_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `files` (
  `f_id` int NOT NULL,
  `artist_name` varchar(50) DEFAULT NULL,
  `file_size` varchar(20) DEFAULT NULL,
  `duration` varchar(20) DEFAULT NULL,
  `formats` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`f_id`),
  KEY `artist_name` (`artist_name`),
  CONSTRAINT `files_ibfk_1` FOREIGN KEY (`artist_name`) REFERENCES `artist` (`artist_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `genre` (
  `g_name` varchar(20) NOT NULL,
  `rating` varchar(10) DEFAULT NULL,
  `most_popular_in` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`g_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `song` (
  `song_name` varchar(50) NOT NULL,
  `artist_name` varchar(50) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `f_id` int DEFAULT NULL,
  `genre_is` varchar(20) DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `languages` varchar(20) DEFAULT NULL,
  `releasedate` varchar(50) DEFAULT NULL,
  `resolution` int DEFAULT NULL,
  PRIMARY KEY (`song_name`),
  KEY `genre_is` (`genre_is`),
  KEY `f_id` (`f_id`),
  KEY `artist_name` (`artist_name`),
  CONSTRAINT `song_ibfk_1` FOREIGN KEY (`genre_is`) REFERENCES `genre` (`g_name`),
  CONSTRAINT `song_ibfk_2` FOREIGN KEY (`f_id`) REFERENCES `files` (`f_id`),
  CONSTRAINT `song_ibfk_3` FOREIGN KEY (`artist_name`) REFERENCES `artist` (`artist_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
