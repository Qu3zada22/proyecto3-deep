CREATE TABLE `apartment_bookings` (
  `apt_booking_id` int NOT NULL,
  `apt_id` int DEFAULT NULL,
  `guest_id` int DEFAULT NULL,
  `booking_status_code` varchar(15) DEFAULT NULL,
  `booking_start_date` datetime DEFAULT NULL,
  `booking_end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`apt_booking_id`),
  KEY `guest_id` (`guest_id`),
  KEY `apt_id` (`apt_id`),
  CONSTRAINT `apartment_bookings_ibfk_1` FOREIGN KEY (`guest_id`) REFERENCES `guests` (`guest_id`),
  CONSTRAINT `apartment_bookings_ibfk_2` FOREIGN KEY (`apt_id`) REFERENCES `apartments` (`apt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `apartment_buildings` (
  `building_id` int NOT NULL,
  `building_short_name` varchar(20) DEFAULT NULL,
  `building_full_name` varchar(80) DEFAULT NULL,
  `building_description` varchar(255) DEFAULT NULL,
  `building_address` varchar(255) DEFAULT NULL,
  `building_manager` varchar(50) DEFAULT NULL,
  `building_phone` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `apartment_facilities` (
  `apt_id` int NOT NULL,
  `facility_code` varchar(15) NOT NULL,
  PRIMARY KEY (`apt_id`,`facility_code`),
  CONSTRAINT `apartment_facilities_ibfk_1` FOREIGN KEY (`apt_id`) REFERENCES `apartments` (`apt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `apartments` (
  `apt_id` int NOT NULL,
  `building_id` int DEFAULT NULL,
  `apt_type_code` varchar(15) DEFAULT NULL,
  `apt_number` varchar(10) DEFAULT NULL,
  `bathroom_count` int DEFAULT NULL,
  `bedroom_count` int DEFAULT NULL,
  `room_count` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`apt_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `apartments_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `apartment_buildings` (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `guests` (
  `guest_id` int NOT NULL,
  `gender_code` varchar(7) DEFAULT NULL,
  `guest_first_name` varchar(80) DEFAULT NULL,
  `guest_last_name` varchar(80) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  PRIMARY KEY (`guest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `view_unit_status` (
  `apt_id` int DEFAULT NULL,
  `apt_booking_id` int DEFAULT NULL,
  `status_date` datetime NOT NULL,
  `available_yn` int DEFAULT NULL,
  PRIMARY KEY (`status_date`),
  KEY `apt_booking_id` (`apt_booking_id`),
  KEY `apt_id` (`apt_id`),
  CONSTRAINT `view_unit_status_ibfk_1` FOREIGN KEY (`apt_booking_id`) REFERENCES `apartment_bookings` (`apt_booking_id`),
  CONSTRAINT `view_unit_status_ibfk_2` FOREIGN KEY (`apt_id`) REFERENCES `apartments` (`apt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
