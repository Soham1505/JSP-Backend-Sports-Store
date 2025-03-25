-- Database: sportsstore

-- Table: billing
CREATE TABLE `billing` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customerId` INT NOT NULL,
  `productId` INT NOT NULL,
  `quantity` INT NOT NULL,
  `totalAmount` DECIMAL(10,2) NOT NULL,
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`productId`) REFERENCES `products` (`productId`)
);

-- Table: customers
CREATE TABLE `customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `adress` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  UNIQUE KEY `email_UNIQUE` (`email`)
);
INSERT INTO `customers` VALUES (1, 'sairaj', '1122334455', 'sai@gmail.com', 'nerul');
INSERT INTO `customers` VALUES (2, 'sonu', '1122534455', 'sonu@gmail.com', 'mumbai');

-- Table: products
CREATE TABLE `products` (
  `productId` INT NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(100) NOT NULL,
  `price` INT NOT NULL,
  `description` TEXT,
  PRIMARY KEY (`productId`)
);
INSERT INTO `products` VALUES (3, 'Jersey', 350, 'Sports store');

-- Table: users
CREATE TABLE `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
);
INSERT INTO `users` VALUES
(14, 'soham', 'soham'),
(15, 'admin', 'admin');
