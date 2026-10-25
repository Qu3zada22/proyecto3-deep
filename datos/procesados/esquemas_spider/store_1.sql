CREATE TABLE `albums` (
  `id` int NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `artist_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `albums_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `artists` (
  `id` int NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `id` int NOT NULL,
  `first_name` varchar(40) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `company` varchar(80) DEFAULT NULL,
  `address` varchar(70) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `state` varchar(40) DEFAULT NULL,
  `country` varchar(40) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(24) DEFAULT NULL,
  `fax` varchar(24) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `support_rep_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `support_rep_id` (`support_rep_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`support_rep_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employees` (
  `id` int NOT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  `reports_to` int DEFAULT NULL,
  `birth_date` datetime DEFAULT NULL,
  `hire_date` datetime DEFAULT NULL,
  `address` varchar(70) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `state` varchar(40) DEFAULT NULL,
  `country` varchar(40) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(24) DEFAULT NULL,
  `fax` varchar(24) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_to` (`reports_to`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`reports_to`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `genres` (
  `id` int NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `invoice_lines` (
  `id` int NOT NULL,
  `invoice_id` int DEFAULT NULL,
  `track_id` int DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `track_id` (`track_id`),
  KEY `invoice_id` (`invoice_id`),
  CONSTRAINT `invoice_lines_ibfk_1` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`),
  CONSTRAINT `invoice_lines_ibfk_2` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `invoices` (
  `id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `billing_address` varchar(70) DEFAULT NULL,
  `billing_city` varchar(40) DEFAULT NULL,
  `billing_state` varchar(40) DEFAULT NULL,
  `billing_country` varchar(40) DEFAULT NULL,
  `billing_postal_code` varchar(10) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `media_types` (
  `id` int NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `playlist_tracks` (
  `playlist_id` int NOT NULL,
  `track_id` int NOT NULL,
  PRIMARY KEY (`playlist_id`,`track_id`),
  KEY `track_id` (`track_id`),
  CONSTRAINT `playlist_tracks_ibfk_1` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`id`),
  CONSTRAINT `playlist_tracks_ibfk_2` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `playlists` (
  `id` int NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tracks` (
  `id` int NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `album_id` int DEFAULT NULL,
  `media_type_id` int DEFAULT NULL,
  `genre_id` int DEFAULT NULL,
  `composer` varchar(220) DEFAULT NULL,
  `milliseconds` int DEFAULT NULL,
  `bytes` int DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_type_id` (`media_type_id`),
  KEY `genre_id` (`genre_id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `tracks_ibfk_1` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`),
  CONSTRAINT `tracks_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`),
  CONSTRAINT `tracks_ibfk_3` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
