CREATE TABLE `camera_lens` (
  `id` int NOT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `focal_length_mm` double DEFAULT NULL,
  `max_aperture` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mountain` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `prominence` double DEFAULT NULL,
  `range` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `photos` (
  `id` int NOT NULL,
  `camera_lens_id` int DEFAULT NULL,
  `mountain_id` int DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mountain_id` (`mountain_id`),
  KEY `camera_lens_id` (`camera_lens_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`mountain_id`) REFERENCES `mountain` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`camera_lens_id`) REFERENCES `camera_lens` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
