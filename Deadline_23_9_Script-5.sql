CREATE DATABASE muaban;
USE muaban;

DROP database muaban;
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Country VARCHAR(50)
);

-- Tạo bảng Suppliers
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactName VARCHAR(100),
    Country VARCHAR(50)
);

-- Tạo bảng Categories
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

-- Tạo bảng Products với các khóa ngoại
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    SupplierID INT,
    CategoryID INT,
    Unit VARCHAR(50),
    Price DECIMAL(10, 2),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Tạo bảng Orders với khóa ngoại
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ShipperID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Tạo bảng OrderDetails với các khóa ngoại
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (CustomerName, ContactName, Country)
VALUES
('Around the Horn', 'Thomas Hardy', 'UK'),
('Berglunds snabbköp', 'Christina Berglund', 'Sweden'),
('Blauer See Delikatessen', 'Hanna Moos', 'Germany'),
('Blondel père et fils', 'Frédérique Citeaux', 'France'),
('Bólido Comidas preparadas', 'Martín Sommer', 'Spain'),
('Bon app''', 'Laurence Lebihan', 'France'),
('Bottom-Dollar Markets', 'Elizabeth Lincoln', 'Canada'),
('Cactus Comidas para llevar', 'Patricio Simpson', 'Argentina'),
('Centro comercial Moctezuma', 'Francisco Chang', 'Mexico'),
('Chop-suey Chinese', 'Yang Wang', 'Switzerland');

INSERT INTO Suppliers (SupplierName, ContactName, Country)
VALUES
('Grandma Kelly''s Homestead', 'Regina Murphy', 'USA'),
('Tokyo Traders', 'Yoshi Nagase', 'Japan'),
('Cooperativa de Quesos ''Las Cabras''', 'Antonio del Valle Saavedra', 'Spain'),
('Mayumi''s', 'Mayumi Ohno', 'Japan'),
('Pavlova, Ltd.', 'Ian Devling', 'Australia'),
('Specialty Biscuits, Ltd.', 'Peter Wilson', 'UK'),
('PB Knäckebröd AB', 'Lars Peterson', 'Sweden'),
('Refrescos Americanas LTDA', 'Carlos Diaz', 'Brazil'),
('Heli Süßwaren GmbH & Co. KG', 'Petra Winkler', 'Germany'),
('Plutzer Lebensmittelgroßmärkte AG', 'Martin Bein', 'Germany');


INSERT INTO Products (ProductName, SupplierID, CategoryID, Unit, Price)
VALUES
('Chef Anton''s Cajun Seasoning', 2, 2, '48 - 6 oz jars', 22.00),
('Chef Anton''s Gumbo Mix', 2, 2, '36 boxes', 21.35),
('Grandma''s Boysenberry Spread', 3, 2, '12 - 8 oz jars', 25.00),
('Uncle Bob''s Organic Dried Pears', 3, 7, '12 - 1 lb pkgs.', 30.00),
('Northwoods Cranberry Sauce', 3, 2, '12 - 12 oz jars', 40.00),
('Mishi Kobe Niku', 4, 6, '18 - 500 g pkgs.', 97.00),
('Ikura', 4, 8, '12 - 200 ml jars', 31.00),
('Queso Cabrales', 5, 4, '1 kg pkg.', 21.00),
('Queso Manchego La Pastora', 5, 4, '10 - 500 g pkgs.', 38.00),
('Konbu', 6, 8, '2 kg box', 6.00);

INSERT INTO Orders (CustomerID, OrderDate, ShipperID)
VALUES
(4, '2024-05-20', 3),
(5, '2024-05-21', 2),
(6, '2024-05-22', 1),
(7, '2024-05-23', 2),
(8, '2024-05-24', 3),
(9, '2024-05-25', 1),
(10,'2024-05-26', 2),
(1, '2024-05-27', 3),
(2, '2024-05-28', 1),
(3, '2024-05-29', 2);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES
(1, 1, 10),
(1, 2, 5),
(2, 3, 20),
(3, 4, 15),
(4, 5, 12),
(5, 6, 8),
(6, 7, 30),
(7, 8, 25),
(8, 9, 18),
(9, 10, 7);

INSERT INTO Categories (CategoryName)
VALUES
('Grains/Cereals'),
('Condiments'),
('Confections'),
('Dairy Products'),
('Seafood'),
('Beverages'),
('Produce'),
('Meat/Poultry');




-- 1) Liệt kê tên sản phẩm và tên nhà cung cấp cho tất cả các sản phẩm có giá lớn hơn 15.00
SELECT p.ProductName, s.SupplierName, p.Price
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.Price > 15.00;

-- 2) Tìm tất cả các đơn hàng được thực hiện bởi khách hàng ở "Mexico"
SELECT c.CustomerName, COUNT(o.OrderID) 
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Mexico'
GROUP BY c.CustomerName;

-- 3) Tìm số lượng đơn hàng được thực hiện trong mỗi quốc gia
SELECT c.Country,COUNT(o.OrderID) 
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Country;

-- 4) Liệt kê tất cả các nhà cung cấp và số lượng sản phẩm mà họ cung cấp
SELECT s.SupplierName, COUNT(p.ProductID) Quantity 
FROM Suppliers s
LEFT JOIN Products p ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierName;


-- 5) Liệt kê tên sản phẩm và giá của các sản phẩm đắt hơn sản phẩm "Chang"
SELECT p.ProductName, p.Price
FROM Products p
WHERE p.Price > (SELECT p1.Price 
                 FROM Products  p1 
				 WHERE p1.ProductName = 'Chang');


-- 6) Tìm tổng số lượng sản phẩm bán ra trong tháng 5 năm 2024
SELECT p.ProductName, SUM(od.Quantity) as totalQuantity 
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE MONTH(o.OrderDate) = 5 AND YEAR(o.OrderDate) = 2024
GROUP BY p.ProductName;

-- 7) Tìm tên của các khách hàng chưa từng đặt hàng
SELECT c.CustomerName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerName
HAVING COUNT(o.OrderID) = 0;


-- 8) Liệt kê các đơn hàng với tổng số tiền lớn hơn 200.00
SELECT o.OrderID, SUM(od.Quantity * p.Price) AS TotalAmount
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY o.OrderID
HAVING SUM(od.Quantity * p.Price) > 200.00;


-- 9) Tìm tên sản phẩm và số lượng trung bình được đặt hàng cho mỗi đơn hàng
SELECT o.OrderID, p.ProductName, AVG(od.Quantity) AS AverageQuantity
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY o.OrderID, p.ProductName;

-- 10) Tìm khách hàng có tổng giá trị đơn hàng cao nhất
SELECT c.CustomerName, SUM(od.Quantity * p.Price) AS TotalAmount
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY TotalAmount DESC
LIMIT 1;

-- 11) Tìm các đơn hàng có tổng giá trị nằm trong top 10 cao nhất
SELECT o.OrderID, SUM(od.Quantity * p.Price) AS TotalValue
FROM  Orders o
JOIN  OrderDetails od ON o.OrderID = od.OrderID
JOIN  Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID
ORDER BY TotalValue DESC
LIMIT 10;



-- 12) Tìm tên khách hàng và số lượng đơn hàng của họ, chỉ bao gồm các khách hàng có số lượng đơn hàng lớn hơn mức trung bình
SELECT c.CustomerName,  COUNT(o.OrderID) AS OrderCount
FROM  Customers c
JOIN  Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
HAVING  OrderCount > (
        SELECT AVG(OrderCount)
        FROM (
            SELECT COUNT(o2.OrderID) AS OrderCount
            FROM  Orders o2
            GROUP BY o2.CustomerID) AS AvgOrderCount
    );
   
   
 -- 13) Tìm sản phẩm có giá trị đơn hàng trung bình cao nhất (dựa trên giá sản phẩm và số lượng).
SELECT p.ProductName, AVG(od.Quantity * p.Price) AS AverageOrderValue
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID
ORDER BY AverageOrderValue DESC
LIMIT 1;


-- 14) Liệt kê các sản phẩm chưa bao giờ được đặt hàng bởi khách hàng đến từ "USA"
SELECT p.ProductName
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
LEFT JOIN Orders o ON od.OrderID = o.OrderID
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA'OR c.Country IS NULL AND p.ProductID NOT IN (
        SELECT DISTINCT od2.ProductID
        FROM OrderDetails od2
        JOIN Orders o2 ON od2.OrderID = o2.OrderID
        JOIN Customers c2 ON o2.CustomerID = c2.CustomerID
        WHERE c2.Country = 'USA'
    );

-- 15)Tìm nhà cung cấp có số lượng sản phẩm cung cấp nhiều nhất.
SELECT s.SupplierName, COUNT(p.ProductID) AS ProductCount
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID
ORDER BY ProductCount DESC
LIMIT 1;
