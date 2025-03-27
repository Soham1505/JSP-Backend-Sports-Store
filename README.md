JSP Backend Sports Store

📚 Project Overview

JSP Backend Sports Store is a web-based e-commerce platform developed using Java, JSP, and Servlets. The system manages product listings, customer information, billing, and daily sales while maintaining a secure MySQL database.

🚀 Key Features

Admin can manage products, customers, and daily sales.
Customers can view available products and order history.
Billing system integrated with automated calculations.
Secure login and role-based access control.

🛠️ Tech Stack

Backend: Java, JSP, Servlets
Database: MySQL
Build Tool: Apache Ant
Deployment: Apache Tomcat

📊 Database Schema
The project uses a MySQL database sportsstore with the following tables:
billing
customers
daily_sales
products
users

ER Diagram
billing table references customers and products tables.
users table handles admin and customer credentials.

🔗 Project Structure

JSP-Backend-Sports-Store-main/
├── build.xml
├── Database.sql
├── README.md
├── nbproject/
├── src/
│   ├── conf/
│   │   └── MANIFEST.MF
│   ├── java/
│   │   └── database1/
│   │       └── DBConnection.java
│   └── webapp/
│       ├── index.jsp
│       └── WEB-INF/
└── web.xml

📚 Required Libraries
Java Libraries
mysql-connector-java-8.0.23.jar
servlet-api.jar
jsp-api.jar
jakarta.servlet-api-5.0.0.jar
Additional Tools
Apache Ant for building the project
Apache Tomcat for deployment

📊 Database Script

Database Name: sportsstore

CREATE DATABASE sportsstore;
USE sportsstore;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('admin', 'customer') NOT NULL
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT
);

CREATE TABLE billing (
    billing_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE daily_sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    date DATE,
    total_sales DECIMAL(10, 2)
);

⚙️ Setup Instructions
Prerequisites
Java JDK 11 or higher
Apache Tomcat 9.0
MySQL 8.0
Database Setup

Import Database.sql into MySQL.
Update database credentials in DBConnection.java.
Project Deployment

Build the project using Ant:
ant build
Deploy the generated WAR file to Tomcat's webapps directory.
Start Tomcat and access the application at:
http://localhost:8080/SportsStore

🧪 Testing
Unit Testing
JUnit: Run unit tests using JUnit to ensure functionality.
API Testing
Postman: Test REST APIs with Postman to validate endpoints.

📩 Contact
For queries or issues, raise an issue via GitHub Issues.



