CREATE TABLE `business` (
  `bid` int NOT NULL,
  `business_id` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `full_address` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `review_count` int DEFAULT NULL,
  `is_open` int DEFAULT NULL,
  `rating` double DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `category` (
  `id` int NOT NULL,
  `business_id` varchar(50) DEFAULT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `checkin` (
  `cid` int NOT NULL,
  `business_id` varchar(50) DEFAULT NULL,
  `count` int DEFAULT NULL,
  `day` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `neighbourhood` (
  `id` int NOT NULL,
  `business_id` varchar(50) DEFAULT NULL,
  `neighbourhood_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `review` (
  `rid` int NOT NULL,
  `business_id` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `rating` double DEFAULT NULL,
  `text` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tip` (
  `tip_id` int NOT NULL,
  `business_id` varchar(50) DEFAULT NULL,
  `text` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `likes` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `uid` int NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
