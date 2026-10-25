CREATE TABLE `artist` (
  `artist_id` int NOT NULL,
  `artist` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `famous_title` varchar(50) DEFAULT NULL,
  `famous_release_date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `music_festival` (
  `id` int NOT NULL,
  `music_festival` varchar(50) DEFAULT NULL,
  `date_of_ceremony` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `volume` int DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `volume` (`volume`),
  CONSTRAINT `music_festival_ibfk_1` FOREIGN KEY (`volume`) REFERENCES `volume` (`volume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `volume` (
  `volume_id` int NOT NULL,
  `volume_issue` varchar(50) DEFAULT NULL,
  `issue_date` varchar(50) DEFAULT NULL,
  `weeks_on_top` double DEFAULT NULL,
  `song` varchar(50) DEFAULT NULL,
  `artist_id` int DEFAULT NULL,
  PRIMARY KEY (`volume_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `volume_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
