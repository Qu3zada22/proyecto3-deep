CREATE TABLE `dorm` (
  `dormid` int DEFAULT NULL,
  `dorm_name` varchar(20) DEFAULT NULL,
  `student_capacity` int DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `dorm_amenity` (
  `amenid` int DEFAULT NULL,
  `amenity_name` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `has_amenity` (
  `dormid` int DEFAULT NULL,
  `amenid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `lives_in` (
  `stuid` int DEFAULT NULL,
  `dormid` int DEFAULT NULL,
  `room_number` int DEFAULT NULL,
  KEY `stuid` (`stuid`),
  CONSTRAINT `lives_in_ibfk_1` FOREIGN KEY (`stuid`) REFERENCES `student` (`stuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `student` (
  `stuid` int NOT NULL,
  `lname` varchar(12) DEFAULT NULL,
  `fname` varchar(12) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `major` int DEFAULT NULL,
  `advisor` int DEFAULT NULL,
  `city_code` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`stuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
