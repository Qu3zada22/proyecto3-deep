CREATE TABLE `gymnast` (
  `gymnast_id` int NOT NULL,
  `floor_exercise_points` double DEFAULT NULL,
  `pommel_horse_points` double DEFAULT NULL,
  `rings_points` double DEFAULT NULL,
  `vault_points` double DEFAULT NULL,
  `parallel_bars_points` double DEFAULT NULL,
  `horizontal_bar_points` double DEFAULT NULL,
  `total_points` double DEFAULT NULL,
  PRIMARY KEY (`gymnast_id`),
  CONSTRAINT `gymnast_ibfk_1` FOREIGN KEY (`gymnast_id`) REFERENCES `people` (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `people` (
  `people_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `hometown` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
