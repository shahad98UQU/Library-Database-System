 Use library;
 
-- Request 4 --
DELETE FROM Employees WHERE EmployeeNo = 10;

-- Request 5 --
DELETE FROM Customers WHERE CustomerNo IN (209, 210);

-- Request 6 --
SELECT * FROM Books WHERE AvailableBooks > 0;

 -- Request 7 --
SELECT * FROM LibraryLoan;

-- Request 8 --
SELECT * FROM LibraryLoans WHERE RentalOutDated = TRUE;

 -- Request 9 --
SELECT Customers.CustomerNo, Customers.FirstName, Customers.LastName, 
       Customers.PhoneNo, LibraryLoans.BookNo, LibraryLoans.RentalDate, LibraryLoans.ReturnDate
FROM Customers
JOIN LibraryLoans ON Customers.CustomerNo = LibraryLoans.CustomerNo;

-- Request 10 --
SELECT Employees.EmployeeNo, Employees.FirstName, Employees.LastName, 
       Employees.PhoneNo, LibraryLoans.BookNo, LibraryLoans.RentalDate, LibraryLoans.ReturnDate
FROM Employees
JOIN LibraryLoans ON Employees.EmployeeNo = LibraryLoans.EmployeeNo;

-- Request 11 --
CREATE VIEW info AS
SELECT Books.BookName, 
       Customers.FirstName AS CustomerFirstName, Customers.LastName AS CustomerLastName,
       Employees.FirstName AS EmployeeFirstName, Employees.LastName AS EmployeeLastName,
       LibraryLoans.ReturnDate
FROM LibraryLoans
JOIN Books ON LibraryLoans.BookNo = Books.BookNo
JOIN Customers ON LibraryLoans.CustomerNo = Customers.CustomerNo
JOIN Employees ON LibraryLoans.EmployeeNo = Employees.EmployeeNo;

-- Request 12 --
SELECT COUNT(*) AS TotalRentedBooks
FROM LibraryLoans;

-- Request 13 --
SELECT SUM(AvailableBooks) AS TotalAvailableBooks
FROM Books;

-- Request 14 --
UPDATE Employees
SET Salary = Salary * 1.10;
SELECT EmployeeNo, FirstName, Salary FROM Employees;

-- Request 15 --
SELECT * 
FROM Employees
WHERE EmployeeNo = 7;

-- Request 16 --
SELECT MAX(RentalDate) AS LatestRentalDate
FROM LibraryLoans;


-- Request 17 --
select min(rentaldate)
from LibraryLoans;

-- Request 18 --


-- Request 19 --
DROP Table missingbooks;

-- Request 20 --
CREATE TABLE Blacklist (
    BlacklistID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerNo INT UNIQUE,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PhoneNo VARCHAR(20),
    Reason VARCHAR(255) DEFAULT 'Did not return a book',
    FOREIGN KEY (CustomerNo) REFERENCES Customers(CustomerNo) ON DELETE CASCADE
);

-- Request 21 --
CREATE TABLE RequestedBooks (
    RequestID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    CustomerContactInfo VARCHAR(50) NOT NULL,
    BookInfo VARCHAR(255) NOT NULL
);
INSERT INTO RequestedBooks (CustomerName, CustomerContactInfo, BookInfo)
VALUES 
('Fatima Zahra', '0534445556', 'The Great Gatsby by F. Scott Fitzgerald'),
('Omar Salem', ' ', '1984 by George Orwell'); 


select * from RequestedBooks;

-- Request 22 --
-- TRIGGER2--
DELIMITER //

CREATE TRIGGER PreventEmptyBookInfo
BEFORE UPDATE ON RequestedBooks
FOR EACH ROW
BEGIN
    IF NEW.BookInfo = '' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Book information cannot be empty!';
    END IF;
END //

DELIMITER ;
-- to check from trigger 1 --
UPDATE RequestedBooks
SET BookInfo = ''
WHERE RequestID = 2;

-- trigger 2--
DELIMITER //
CREATE TRIGGER PreventDeleteWithoutContact
BEFORE DELETE ON RequestedBooks
FOR EACH ROW
BEGIN
  IF OLD.CustomerContactInfo IS NULL OR OLD.CustomerContactInfo = '' THEN
    SIGNAL SQLSTATE '45000'  
    SET MESSAGE_TEXT = 'Cannot delete a record without customer contact info!';
  END IF;
END//

-- TO CHECK FROM TRIGGER 2--
DELETE FROM RequestedBooks
WHERE requestID=3 AND CustomerName = 'Omar Salem';

-- Request 23 --
CREATE VIEW BestRentedBooks 
AS
SELECT b.BookName, COUNT(r.CustomerNO) AS NumberOfRentals, r.RentalDate, r.ReturnDate,
DATEDIFF(r.ReturnDate, r.RentalDate) AS RentalDays
FROM LibraryLoans r JOIN Books b ON r.BookNO = b.BookNO
GROUP BY b.BookName, r.RentalDate, r.ReturnDate;

select * from BestRentedBooks;

