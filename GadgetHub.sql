
CREATE DATABASE GadgetHubDB;

USE GadgetHubDB;

CREATE TABLE Products(
    ProductId INT PRIMARY KEY,
    Name NVARCHAR(100),
    Description NVARCHAR(MAX),
    ImageUrl NVARCHAR(MAX),
    Category NVARCHAR(50)
);

CREATE TABLE Orders(
    OrderId INT PRIMARY KEY,
    OrderDate DATETIME,
    ProductId INT,
    Quantity INT,
    Status NVARCHAR(50),
    CreatedAt DATETIME, 
    DistributorName NVARCHAR(100),
    ConfirmedPrice DECIMAL(10,2),
    ConfirmedDeliveryDays INT,
    QuotationCount INT,
    UserId INT,
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);


CREATE TABLE DistributorQuotations(
    Id INT PRIMARY KEY,
    OrderId INT,
    DistributorName NVARCHAR(100),
    PricePerUnit DECIMAL(10,2),
    DeliveryDays INT,
    SubmittedAt DATETIME,
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);


CREATE TABLE ClientUsers(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);



INSERT INTO Products(Name, Description, ImageUrl, Category)
VALUES
-- 10
('Smart Air Purifier', 'HEPA filter air purifier with real-time air quality monitoring', 'https://lifemobile.lk/wp-content/uploads/2025/07/elite.jpg', 'Home Appliances'),

-- 11
('Electric Kettle', '1.7L stainless steel electric kettle with auto shut-off', 'https://singerwebcdn.azureedge.net/resources/products/normal/KA-PRISMA12-01-01.webp', 'Home Appliances'),

-- 12
('Drone with Camera', 'Foldable drone with 4K camera and GPS return-to-home function', 'https://usadronetampa.com/wp-content/uploads/2024/03/Mini4-Pro-RCN2.png.webp', 'Electronics'),

-- 13
('Mini Projector', 'Portable LED projector for home theater and presentations', 'https://www.laptop.lk/wp-content/uploads/2024/04/Anker-Nebula-Capsule-720p-II-Smart-Mini-Projector-02.jpg', 'Electronics'),

-- 14
('Electric Standing Desk', 'Height-adjustable electric desk with memory presets', 'https://m.media-amazon.com/images/I/414WiS2hKVL._AC_US750_.jpg', 'Furniture'),

-- 15
('Smart Plant Pot', 'Self-watering plant pot with moisture sensors and app alerts', 'https://m.media-amazon.com/images/I/61p1ro5x6CL._AC_SL1500_.jpg', 'Home & Garden');

SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM DistributorQuotations;
SELECT * FROM ClientUsers;


DROP TABLE Products;
DROP TABLE Orders;
DROP TABLE DistributorQuotations;
DROP TABLE ClientUsers;