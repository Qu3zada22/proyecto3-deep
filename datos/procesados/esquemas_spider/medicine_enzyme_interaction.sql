CREATE TABLE `enzyme` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `product` varchar(50) DEFAULT NULL,
  `chromosome` varchar(50) DEFAULT NULL,
  `omim` int DEFAULT NULL,
  `porphyria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `medicine` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `trade_name` varchar(50) DEFAULT NULL,
  `fda_approved` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `medicine_enzyme_interaction` (
  `enzyme_id` int NOT NULL,
  `medicine_id` int NOT NULL,
  `interaction_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`enzyme_id`,`medicine_id`),
  KEY `medicine_id` (`medicine_id`),
  CONSTRAINT `medicine_enzyme_interaction_ibfk_1` FOREIGN KEY (`medicine_id`) REFERENCES `medicine` (`id`),
  CONSTRAINT `medicine_enzyme_interaction_ibfk_2` FOREIGN KEY (`enzyme_id`) REFERENCES `enzyme` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
