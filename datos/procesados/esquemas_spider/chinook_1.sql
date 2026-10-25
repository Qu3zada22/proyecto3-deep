CREATE TABLE `album` (
  `albumid` int NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `artistid` int DEFAULT NULL,
  PRIMARY KEY (`albumid`),
  KEY `artistid` (`artistid`),
  CONSTRAINT `album_ibfk_1` FOREIGN KEY (`artistid`) REFERENCES `artist` (`artistid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `artist` (
  `artistid` int NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`artistid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer` (
  `customerid` int NOT NULL,
  `firstname` varchar(40) DEFAULT NULL,
  `lastname` varchar(20) DEFAULT NULL,
  `company` varchar(80) DEFAULT NULL,
  `address` varchar(70) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `state` varchar(40) DEFAULT NULL,
  `country` varchar(40) DEFAULT NULL,
  `postalcode` varchar(10) DEFAULT NULL,
  `phone` varchar(24) DEFAULT NULL,
  `fax` varchar(24) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `supportrepid` int DEFAULT NULL,
  PRIMARY KEY (`customerid`),
  KEY `supportrepid` (`supportrepid`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`supportrepid`) REFERENCES `employee` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employee` (
  `employeeid` int NOT NULL,
  `lastname` varchar(20) DEFAULT NULL,
  `firstname` varchar(20) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  `reportsto` int DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  `hiredate` datetime DEFAULT NULL,
  `address` varchar(70) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `state` varchar(40) DEFAULT NULL,
  `country` varchar(40) DEFAULT NULL,
  `postalcode` varchar(10) DEFAULT NULL,
  `phone` varchar(24) DEFAULT NULL,
  `fax` varchar(24) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`employeeid`),
  KEY `reportsto` (`reportsto`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`reportsto`) REFERENCES `employee` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `genre` (
  `genreid` int NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`genreid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `invoice` (
  `invoiceid` int NOT NULL,
  `customerid` int DEFAULT NULL,
  `invoicedate` datetime DEFAULT NULL,
  `billingaddress` varchar(70) DEFAULT NULL,
  `billingcity` varchar(40) DEFAULT NULL,
  `billingstate` varchar(40) DEFAULT NULL,
  `billingcountry` varchar(40) DEFAULT NULL,
  `billingpostalcode` varchar(10) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`invoiceid`),
  KEY `customerid` (`customerid`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`customerid`) REFERENCES `customer` (`customerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `invoiceline` (
  `invoicelineid` int NOT NULL,
  `invoiceid` int DEFAULT NULL,
  `trackid` int DEFAULT NULL,
  `unitprice` decimal(10,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`invoicelineid`),
  KEY `trackid` (`trackid`),
  KEY `invoiceid` (`invoiceid`),
  CONSTRAINT `invoiceline_ibfk_1` FOREIGN KEY (`trackid`) REFERENCES `track` (`trackid`),
  CONSTRAINT `invoiceline_ibfk_2` FOREIGN KEY (`invoiceid`) REFERENCES `invoice` (`invoiceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `mediatype` (
  `mediatypeid` int NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`mediatypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `playlist` (
  `playlistid` int NOT NULL,
  `name` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`playlistid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `playlisttrack` (
  `playlistid` int NOT NULL,
  `trackid` int NOT NULL,
  PRIMARY KEY (`playlistid`,`trackid`),
  KEY `trackid` (`trackid`),
  CONSTRAINT `playlisttrack_ibfk_1` FOREIGN KEY (`trackid`) REFERENCES `track` (`trackid`),
  CONSTRAINT `playlisttrack_ibfk_2` FOREIGN KEY (`playlistid`) REFERENCES `playlist` (`playlistid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `track` (
  `trackid` int NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `albumid` int DEFAULT NULL,
  `mediatypeid` int DEFAULT NULL,
  `genreid` int DEFAULT NULL,
  `composer` varchar(220) DEFAULT NULL,
  `milliseconds` int DEFAULT NULL,
  `bytes` int DEFAULT NULL,
  `unitprice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`trackid`),
  KEY `mediatypeid` (`mediatypeid`),
  KEY `genreid` (`genreid`),
  KEY `albumid` (`albumid`),
  CONSTRAINT `track_ibfk_1` FOREIGN KEY (`mediatypeid`) REFERENCES `mediatype` (`mediatypeid`),
  CONSTRAINT `track_ibfk_2` FOREIGN KEY (`genreid`) REFERENCES `genre` (`genreid`),
  CONSTRAINT `track_ibfk_3` FOREIGN KEY (`albumid`) REFERENCES `album` (`albumid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
