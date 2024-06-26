CREATE DATABASE Kitabxana

USE Kitabxana

CREATE TABLE Authors
(
Id INT PRIMARY KEY IDENTITY (1,1),
Name NVARCHAR(100) NOT NULL DEFAULT 'Author Name',
Surname NVARCHAR(100) NOT NULL DEFAULT 'Author Surname',
)

CREATE TABLE Books
(
Id INT PRIMARY KEY,
Name NVARCHAR(100),
AuthorId INT,
PageCount INT NOT NULL CHECK (PageCount >= 0),
CostPrice DECIMAL(10, 2) CHECK (CostPrice >= 0),
SalePrice DECIMAL(10, 2) CHECK (SalePrice >=0),
FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
)

CREATE TABLE Tags
(
Id INT PRIMARY KEY IDENTITY (1,1),
Name NVARCHAR(50)
)

CREATE TABLE BookTags
(
BookId INT IDENTITY,
TagId INT IDENTITY,
PRIMARY KEY  (BookId, TagId),
FOREIGN KEY (BookId) REFERENCES Books(Id),
FOREIGN KEY (TagId) REFERENCES Tags(Id)
)

INSERT INTO Authors
VALUES 
('Coşqun', 'Kərimov'),
('Yusif', 'Quluzadə')

INSERT INTO Books
VALUES 
(1, 'Harry Potter', 5, 652, 10, 17.50),
(2, 'Suç Ve Ceza', 6, 150, 17.50, 25),
(3,'Programming' , 5, 240, 25.00,50),
(4,'Design', 6,150, 30, 50)

INSERT INTO Tags
VALUES 
(1, 'BestSeller'),
(2, 'Featured'),
(3, 'Newest')

INSERT INTO BookTags (BookId, TagId)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 2),
(2, 3)

SELECT
B.Id AS BookId,
a.Name + '' + a.Surname AS AuthorFullName,
b.Name AS BookName,
b.SalePrice AS BookPrice,
b.PageCount,
t.Name AS TagName
FROM
Books b
INNER JOIN Authors a ON b.AuthorId = a.Id
LEFT JOIN BookTags bt ON b.Id = bt.BookId
LEFT JOIN Tags t ON bt.TagId = t.Id
