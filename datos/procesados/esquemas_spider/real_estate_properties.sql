CREATE TABLE `other_available_features` (
  `feature_id` int NOT NULL,
  `feature_type_code` varchar(20) DEFAULT NULL,
  `feature_name` varchar(80) DEFAULT NULL,
  `feature_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`feature_id`),
  KEY `feature_type_code` (`feature_type_code`),
  CONSTRAINT `other_available_features_ibfk_1` FOREIGN KEY (`feature_type_code`) REFERENCES `ref_feature_types` (`feature_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `other_property_features` (
  `property_id` int DEFAULT NULL,
  `feature_id` int DEFAULT NULL,
  `property_feature_description` varchar(80) DEFAULT NULL,
  KEY `property_id` (`property_id`),
  KEY `feature_id` (`feature_id`),
  CONSTRAINT `other_property_features_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`),
  CONSTRAINT `other_property_features_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `other_available_features` (`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `properties` (
  `property_id` int NOT NULL,
  `property_type_code` varchar(20) DEFAULT NULL,
  `date_on_market` datetime DEFAULT NULL,
  `date_sold` datetime DEFAULT NULL,
  `property_name` varchar(80) DEFAULT NULL,
  `property_address` varchar(255) DEFAULT NULL,
  `room_count` int DEFAULT NULL,
  `vendor_requested_price` decimal(19,4) DEFAULT NULL,
  `buyer_offered_price` decimal(19,4) DEFAULT NULL,
  `agreed_selling_price` decimal(19,4) DEFAULT NULL,
  `apt_feature_1` varchar(255) DEFAULT NULL,
  `apt_feature_2` varchar(255) DEFAULT NULL,
  `apt_feature_3` varchar(255) DEFAULT NULL,
  `fld_feature_1` varchar(255) DEFAULT NULL,
  `fld_feature_2` varchar(255) DEFAULT NULL,
  `fld_feature_3` varchar(255) DEFAULT NULL,
  `hse_feature_1` varchar(255) DEFAULT NULL,
  `hse_feature_2` varchar(255) DEFAULT NULL,
  `hse_feature_3` varchar(255) DEFAULT NULL,
  `oth_feature_1` varchar(255) DEFAULT NULL,
  `oth_feature_2` varchar(255) DEFAULT NULL,
  `oth_feature_3` varchar(255) DEFAULT NULL,
  `shp_feature_1` varchar(255) DEFAULT NULL,
  `shp_feature_2` varchar(255) DEFAULT NULL,
  `shp_feature_3` varchar(255) DEFAULT NULL,
  `other_property_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`property_id`),
  KEY `property_type_code` (`property_type_code`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`property_type_code`) REFERENCES `ref_property_types` (`property_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_feature_types` (
  `feature_type_code` varchar(20) NOT NULL,
  `feature_type_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`feature_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ref_property_types` (
  `property_type_code` varchar(20) NOT NULL,
  `property_type_description` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`property_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
