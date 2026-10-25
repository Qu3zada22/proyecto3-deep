CREATE TABLE `cartoon` (
  `id` double NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `directed_by` varchar(50) DEFAULT NULL,
  `written_by` varchar(50) DEFAULT NULL,
  `original_air_date` varchar(50) DEFAULT NULL,
  `production_code` double DEFAULT NULL,
  `channel` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channel` (`channel`),
  CONSTRAINT `cartoon_ibfk_1` FOREIGN KEY (`channel`) REFERENCES `tv_channel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tv_channel` (
  `id` varchar(50) NOT NULL,
  `series_name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `language` varchar(50) DEFAULT NULL,
  `content` varchar(50) DEFAULT NULL,
  `pixel_aspect_ratio_par` varchar(50) DEFAULT NULL,
  `hight_definition_tv` varchar(50) DEFAULT NULL,
  `pay_per_view_ppv` varchar(50) DEFAULT NULL,
  `package_option` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tv_series` (
  `id` double NOT NULL,
  `episode` varchar(50) DEFAULT NULL,
  `air_date` varchar(50) DEFAULT NULL,
  `rating` varchar(50) DEFAULT NULL,
  `share` double DEFAULT NULL,
  `18_49_rating_share` varchar(50) DEFAULT NULL,
  `viewers_m` varchar(50) DEFAULT NULL,
  `weekly_rank` double DEFAULT NULL,
  `channel` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channel` (`channel`),
  CONSTRAINT `tv_series_ibfk_1` FOREIGN KEY (`channel`) REFERENCES `tv_channel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
