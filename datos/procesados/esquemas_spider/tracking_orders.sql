CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_name` varchar(80) DEFAULT NULL,
  `customer_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `invoices` (
  `invoice_number` int NOT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `invoice_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`invoice_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `order_item_status` varchar(10) DEFAULT NULL,
  `order_item_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `product_id` (`product_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `order_status` varchar(10) DEFAULT NULL,
  `date_order_placed` datetime DEFAULT NULL,
  `order_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_name` varchar(80) DEFAULT NULL,
  `product_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `shipment_items` (
  `shipment_id` int DEFAULT NULL,
  `order_item_id` int DEFAULT NULL,
  KEY `shipment_id` (`shipment_id`),
  KEY `order_item_id` (`order_item_id`),
  CONSTRAINT `shipment_items_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`shipment_id`),
  CONSTRAINT `shipment_items_ibfk_2` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`order_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `shipments` (
  `shipment_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `invoice_number` int DEFAULT NULL,
  `shipment_tracking_number` varchar(80) DEFAULT NULL,
  `shipment_date` datetime DEFAULT NULL,
  `other_shipment_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`shipment_id`),
  KEY `invoice_number` (`invoice_number`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`invoice_number`) REFERENCES `invoices` (`invoice_number`),
  CONSTRAINT `shipments_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
