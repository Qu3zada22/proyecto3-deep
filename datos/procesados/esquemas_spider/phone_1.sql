CREATE TABLE `chip_model` (
  `model_name` varchar(50) NOT NULL,
  `launch_year` double DEFAULT NULL,
  `ram_mib` double DEFAULT NULL,
  `rom_mib` double DEFAULT NULL,
  `slots` varchar(50) DEFAULT NULL,
  `wifi` varchar(50) DEFAULT NULL,
  `bluetooth` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`model_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `phone` (
  `company_name` varchar(50) DEFAULT NULL,
  `hardware_model_name` varchar(50) NOT NULL,
  `accreditation_type` varchar(50) DEFAULT NULL,
  `accreditation_level` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `chip_model` varchar(50) DEFAULT NULL,
  `screen_mode` double DEFAULT NULL,
  PRIMARY KEY (`hardware_model_name`),
  KEY `chip_model` (`chip_model`),
  KEY `screen_mode` (`screen_mode`),
  CONSTRAINT `phone_ibfk_1` FOREIGN KEY (`chip_model`) REFERENCES `chip_model` (`model_name`),
  CONSTRAINT `phone_ibfk_2` FOREIGN KEY (`screen_mode`) REFERENCES `screen_mode` (`graphics_mode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `screen_mode` (
  `graphics_mode` double NOT NULL,
  `char_cells` varchar(50) DEFAULT NULL,
  `pixels` varchar(50) DEFAULT NULL,
  `hardware_colours` double DEFAULT NULL,
  `used_kb` double DEFAULT NULL,
  `map` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`graphics_mode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
