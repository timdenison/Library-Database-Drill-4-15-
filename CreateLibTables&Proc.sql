USE master
GO

IF EXISTS(SELECT * FROM sys.sysdatabases WHERE [name]='dbLibrary')
alter database dbLibrary set single_user with rollback immediate
DROP DATABASE dbLibrary
GO

CREATE DATABASE dbLibrary
GO

USE dbLibrary
GO


CREATE TABLE books (
BookID INT IDENTITY (001,1) NOT NULL primary key,
Title varchar(100) NOT NULL,
PublisherName varchar(50) NOT NULL
)
GO

CREATE TABLE publishers (
Publisher varchar(50) NOT NULL,
[Address] varchar(30) NULL,
Phone varchar (20) NULL
)
GO

CREATE PROC AddBook @booktitle varchar(100),@publisher varchar(50)
AS
INSERT INTO books (books.Title, books.PublisherName)
VALUES (@booktitle,@publisher)
GO

SELECT * from books
--Add books to the books table--
EXEC AddBook 'This is Just a test','BadAss Publishing'
EXEC AddBook 'Second Chances','Pinkman-White Books'
EXEC AddBook 'Weeping Edge','Wrecked Meridian Publishers'
EXEC AddBook 'The Five People You Meet at Starbucks','Pinkman-White Books'
EXEC AddBook 'Way of Flight','Pollyanna Productions'
EXEC AddBook 'The Elven Theft','Pollyanna Productions'
EXEC AddBook 'The Shores of the Serpents','Marvelous Entertainment'
EXEC AddBook 'Tears of the Savior','BadAss Publishing'
EXEC AddBook 'How to Lose a Job in 30 Seconds','Wrecked Meridian Publishers'
EXEC AddBook 'Dark Forest Reckoning','Pinkman-White Books'
EXEC AddBook 'Playing by the Rules','Pollyanna Productions'
EXEC AddBook 'The Lost Tribe','Pinkman-White Books'
EXEC AddBook 'Back to the Future 4','Wrecked Meridian Publishers'
EXEC AddBook 'The Sword of Truth','Marvelous Entertainment'
EXEC AddBook 'The Marked Ones','Pinkman-White Books'
EXEC AddBook 'Cry me a River','Pollyanna Productions'
EXEC AddBook 'Bone','Pinkman-White Books'
EXEC AddBook 'Trolls Abundant','Wrecked Meridian Publishers'
EXEC AddBook 'Lydia','Pinkman-White Books'
EXEC AddBook 'The Rise and Fall of the American Dream','Pollyanna Productions'
SELECT * FROM books

--Populate publishers table with distinct PublisherNames
INSERT INTO publishers (Publisher)
SELECT DISTINCT PublisherName FROM books


--Add Addresses and Phone numbers to Publisher Table
UPDATE publishers 
SET [Address] = '1255 Bollux Ave', Phone = '123-456-7890' WHERE Publisher = 'BadAss Publishing';
UPDATE publishers 
SET [Address] = '6790 Wall St.', Phone = '222-333-4444' WHERE Publisher = 'Marvelous Entertainment';
UPDATE publishers 
SET [Address] = '420 Blue Ice Rd.', Phone = '321-654-0987' WHERE Publisher = 'Pinkman-White Books';
UPDATE publishers 
SET [Address] = '123 Nostalgia Ln.', Phone = '444-777-9999' WHERE Publisher = 'Pollyanna Productions';
UPDATE publishers 
SET [Address] = '2012 Fantasia Way', Phone = '800-215-3298' WHERE Publisher = 'Wrecked Meridian Publishers';

SELECT * FROM publishers

--create book_authors table, tie AuthorBookIDs to BookIDs in books table


CREATE TABLE book_authors (
AuthorBookID int IDENTITY(001,1) NOT NULL,
AuthorName varchar(50),
CONSTRAINT AuthorBookID FOREIGN KEY (AuthorBookID) REFERENCES books(BookID)
)
insert into book_authors (AuthorName)
VALUES ('Jay Hunt'),('Marty Ellis'),('Jerry Fernandez'),
('Jorge Rogers'),('Tricia Maxwell'),('Stephen King'),
('Geraldine Greene'),('Doyle Fowler'),('Darrel Pierce'),
('Joanne Ruiz'),('Cornelius Larson'),('Emmett Henry'),
('Paulette Washington'),('Rolando Crawford'),('Stephen King'),
('Jay Hunt'),('Geraldine Greene'),('Doyle Fowler'),
('Wilbur Sims'),('Phillip Hicks')

--Create library_branch table

CREATE TABLE library_branches (
BranchID INT IDENTITY (5000,1) primary key,
BranchName varchar(20),
BranchAddress varchar(50)
)

INSERT INTO library_branches (BranchName,BranchAddress)
VALUES ('Hobbiton','111 South Farthing Way'),
		('Sharpstown','983 Foregone Rd.'),
		('Central','6 Fringe Avenue'),
		('South','505 Red Car Place')
		
--Create book_copies table, constrain BookID and BranchID to their 
--originators

CREATE TABLE book_copies (
BookID INT FOREIGN KEY REFERENCES books(BookID),
BranchID INT FOREIGN KEY REFERENCES library_branches(BranchID),
Copies INT
)

--Populate the book copies table in possibly the least efficient
--manner possible
INSERT INTO book_copies
VALUES (1,5000,3),(2,5000,0),(3,5000,3),(4,5000,0),(5,5000,3),
	(6,5000,0),(7,5000,4),(8,5000,0),(9,5000,5),(10,5000,0),
	(11,5000,3),(12,5000,0),(13,5000,5),(14,5000,2),(15,5000,3),
	(16,5000,0),(17,5000,2),(18,5000,0),(19,5000,3),(20,5000,0),
	(1,5001,0),(2,5001,2),(3,5001,0),(4,5001,4),(5,5001,0),
	(6,5001,2),(7,5001,0),(8,5001,3),(9,5001,0),(10,5001,6),
	(11,5001,0),(12,5001,3),(13,5001,0),(14,5001,4),(15,5001,0),
	(16,5001,2),(17,5001,0),(18,5001,3),(19,5001,0),(20,5001,5),
	(1,5002,2),(2,5002,0),(3,5002,0),(4,5002,3),(5,5002,0),
	(6,5002,3),(7,5002,4),(8,5002,0),(9,5002,0),(10,5002,5),
	(11,5002,0),(12,5002,0),(13,5002,2),(14,5002,0),(15,5002,4),
	(16,5002,3),(17,5002,2),(18,5002,4),(19,5002,3),(20,5002,2),
	(1,5003,0),(2,5003,2),(3,5003,3),(4,5003,0),(5,5003,4),
	(6,5003,5),(7,5003,0),(8,5003,2),(9,5003,2),(10,5003,0),
	(11,5003,4),(12,5003,2),(13,5003,2),(14,5003,2),(15,5003,3),
	(16,5003,3),(17,5003,2),(18,5003,4),(19,5003,3),(20,5003,2)
	select * from book_copies

--Create Borrower table

CREATE TABLE borrowers (
CardNo INT IDENTITY (10000000,1000) primary key,
Name varchar (50),
[Address] varchar (30),
Phone varchar (20)
)

INSERT INTO borrowers
VALUES ('Tim Denison','123 Address Way','555-333-1212'),
	('Kyle McLachlan','456 Please Rd.','555-385-2424'),
	('Prince Fielder','789 Enough Place','555-284-3535'),
	('Andrew Jackson','147 Repetitive St.','555-946-4646'),
	('Finneas McDonald','258 Busy Bee Ave.','555-258-5757'),
	('Tre Blaupunkt','369 Done Circle','555-742-6868'),
	('Tracy Jordan','357 A Street','555-532-7979'),
	('Lisa Stansfield','468 B Blvd.','555-532-8080'),
	('Monica Potter','579 C St.','555-212-2929')

select * from borrowers

--Create book_loans table

CREATE TABLE book_loans(
BookID INT FOREIGN KEY REFERENCES books(BookID),
BranchID INT FOREIGN KEY REFERENCES library_branches(BranchID),
CardNo INT FOREIGN KEY REFERENCES borrowers(CardNo),
DateOut DATE,
DateDue AS DATEADD(week,3,DateOut)
)
GO

CREATE PROC CheckOut @CardNum INT, @BookID INT, @BranchID INT, @DateOut DATE
AS
INSERT INTO book_loans
VALUES (@BookID,@BranchID,@CardNum,@DateOut)
GO

EXEC CheckOut 10000000,1,5000,'2015-04-08'
EXEC CheckOut 10000000,14,5000,'2015-03-05'
EXEC CheckOut 10000000,11,5000,'2015-03-17'
EXEC CheckOut 10000000,17,5002,'2015-03-20'
EXEC CheckOut 10000000,18,5002,'2015-04-02'
EXEC CheckOut 10000000,7,5002,'2015-03-19'
EXEC CheckOut 10000000,12,5003,'2015-02-28'
EXEC CheckOut 10000000,5,5003,'2015-02-28'
EXEC CheckOut 10000000,3,5003,'2015-02-28'
EXEC CheckOut 10000000,15,5003,'2015-02-28'
EXEC CheckOut 10001000,2,5003,'2015-01-15'
EXEC CheckOut 10002000,14,5003,'2015-02-07'
EXEC CheckOut 10002000,2,5001,'2015-04-01'
EXEC CheckOut 10002000,4,5001,'2015-04-01'
EXEC CheckOut 10002000,8,5001,'2015-04-01'
EXEC CheckOut 10002000,6,5001,'2015-04-01'
EXEC CheckOut 10002000,10,5002,'2015-04-05'
EXEC CheckOut 10002000,7,5002,'2015-04-05'
EXEC CheckOut 10002000,16,5002,'2015-04-05'
EXEC CheckOut 10003000,6,5002,'2015-03-15'
EXEC CheckOut 10003000,10,5001,'2015-03-27'
EXEC CheckOut 10003000,12,5001,'2015-03-20'
EXEC CheckOut 10003000,12,5001,'2015-03-27'
EXEC CheckOut 10003000,16,5001,'2015-03-27'
EXEC CheckOut 10003000,18,5001,'2015-03-20'
EXEC CheckOut 10003000,20,5001,'2015-03-20'
EXEC CheckOut 10003000,3,5000,'2015-03-01'
EXEC CheckOut 10003000,19,5000,'2015-03-01'
EXEC CheckOut 10003000,17,5000,'2015-03-01'
EXEC CheckOut 10003000,5,5000,'2015-03-01'
EXEC CheckOut 10003000,9,5000,'2015-03-01'
EXEC CheckOut 10005000,1,5000,'2014-11-05'
EXEC CheckOut 10005000,9,5000,'2014-11-05'
EXEC CheckOut 10005000,19,5000,'2014-11-05'
EXEC CheckOut 10005000,8,5001,'2014-12-25'
EXEC CheckOut 10007000,20,5001,'2015-04-03'
EXEC CheckOut 10007000,18,5001,'2015-03-20'
EXEC CheckOut 10007000,10,5001,'2015-03-20'
EXEC CheckOut 10007000,14,5001,'2015-04-03'
EXEC CheckOut 10007000,6,5003,'2015-03-15'
EXEC CheckOut 10007000,3,5003,'2015-03-15'
EXEC CheckOut 10007000,5,5003,'2015-03-15'
EXEC CheckOut 10007000,11,5003,'2015-03-15'
EXEC CheckOut 10008000,18,5002,'2015-04-02'
EXEC CheckOut 10008000,10,5002,'2015-04-02'
EXEC CheckOut 10008000,19,5002,'2015-04-02'
EXEC CheckOut 10008000,6,5002,'2015-04-02'
EXEC CheckOut 10008000,4,5002,'2015-04-02'
EXEC CheckOut 10008000,7,5002,'2015-04-02'
EXEC CheckOut 10008000,15,5002,'2015-04-02'

