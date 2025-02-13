CREATE DATABASE LibrarySystem;
USE LibrarySystem;

CREATE TABLE Books
(
  ID_Book INT NOT NULL PRIMARY KEY,
  Title VARCHAR(100) NOT NULL,
  Author VARCHAR(100) NOT NULL,
  Genre VARCHAR(50) NOT NULL,
  Publication_Year INT NOT NULL,
  Status VARCHAR(50) NOT NULL
);

CREATE TABLE Members
(
  ID_Members INT NOT NULL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Contact_Information VARCHAR(50) NOT NULL,
  Membership_Type VARCHAR(50) NOT NULL,
  Registration_Date DATE NOT NULL
);

CREATE TABLE Library_Staff
(
  ID_Staff INT NOT NULL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Contact_Info VARCHAR(50) NOT NULL,
  Assigned_Section VARCHAR(50) NOT NULL,
  Employment_Date DATE NOT NULL
);

CREATE TABLE Categories
(
  ID_Categories INT NOT NULL PRIMARY KEY,
  Name VARCHAR(50) NOT NULL,
  Description VARCHAR(255) NOT NULL
);

CREATE TABLE Reservations
(
  ID_Reservations INT NOT NULL PRIMARY KEY,
  Reservation_Date DATE NOT NULL,
  Status VARCHAR(50) NOT NULL,
  ID_Book INT NOT NULL,
  ID_Members INT NOT NULL,
  FOREIGN KEY (ID_Book) REFERENCES Books(ID_Book),
  FOREIGN KEY (ID_Members) REFERENCES Members(ID_Members)
);

CREATE TABLE Book_Categories
(
  ID_Categories INT NOT NULL,
  ID_Book INT NOT NULL,
  FOREIGN KEY (ID_Categories) REFERENCES Categories(ID_Categories),
  FOREIGN KEY (ID_Book) REFERENCES Books(ID_Book)
);

CREATE TABLE Financial_Fines
(
  ID_Fine INT NOT NULL PRIMARY KEY,
  Amount DECIMAL(10,2) NOT NULL,
  Status VARCHAR(50) NOT NULL
);

CREATE TABLE Book_Member
(
  ID_BM INT NOT NULL PRIMARY KEY,
  Borrowing_Date DATE NOT NULL,
  Due_Date DATE NOT NULL,
  Return_Date DATE NULL,
  ID_Members INT NOT NULL,
  ID_Book INT NOT NULL,
  ID_Fine INT NULL,
  FOREIGN KEY (ID_Members) REFERENCES Members(ID_Members),
  FOREIGN KEY (ID_Book) REFERENCES Books(ID_Book),
  FOREIGN KEY (ID_Fine) REFERENCES Financial_Fines(ID_Fine)
);


INSERT INTO Book_Member (ID_BM, Borrowing_Date, Due_Date, Return_Date, ID_Members, ID_Book, ID_Fine)
VALUES
(1, '2024-01-10', '2024-01-20', '2024-01-19', 101, 1, NULL),
(2, '2024-02-01', '2024-02-10', NULL, 102, 2, NULL),
(3, '2024-03-05', '2024-03-15', '2024-03-12', 103, 3, NULL),
(4, '2024-04-15', '2024-04-25', NULL, 104, 4, NULL),
(5, '2024-05-10', '2024-05-20', '2024-05-18', 105, 5, NULL);


INSERT INTO Books (ID_Book, Title, Author, Genre, Publication_Year, Status) 
VALUES 
(1, 'Database Fundamentals', 'John Smith', 'Technology', 2020, 'Available'),
(2, 'SQL for Beginners', 'Jane Doe', 'Technology', 2019, 'Borrowed'),
(3, 'C# Programming', 'Mark Wilson', 'Programming', 2021, 'Returned'),
(4, 'Science Fiction Guide', 'Alice Brown', 'Science Fiction', 2018, 'Available'),
(5, 'Web Development Basics', 'Emily Davis', 'Technology', 2022, 'Borrowed');

INSERT INTO Members (ID_Members, Name, Contact_Information, Membership_Type, Registration_Date)
VALUES 
(101, 'Ali Ahmed', '1234567890', 'Student', '2024-01-10'),
(102, 'Sara Khalid', '0987654321', 'Regular', '2023-11-15'),
(103, 'Omar Hassan', '9876543210', 'Student', '2024-06-05'),
(104, 'Nour Adel', '4561237890', 'VIP', '2022-09-20'),
(105, 'Mohammed Fawzi', '7418529630', 'Regular', '2023-12-05');

INSERT INTO Library_Staff (ID_Staff, Name, Contact_Info, Assigned_Section, Employment_Date)
VALUES 
(201, 'Khaled Youssef', '111222333', 'Technology', '2020-05-12'),
(202, 'Layla Sami', '444555666', 'Fiction', '2019-08-21'),
(203, 'Mariam Hadi', '777888999', 'Science', '2021-04-10'),
(204, 'Ahmed Tamer', '123987456', 'Programming', '2022-02-17'),
(205, 'Fatima Ibrahim', '369852147', 'History', '2023-06-30');

INSERT INTO Categories (ID_Categories, Name, Description)
VALUES 
(301, 'Technology', 'Books related to tech advancements and computing.'),
(302, 'Programming', 'Books related to coding and software development.'),
(303, 'Science Fiction', 'Fictional books based on scientific concepts.'),
(304, 'History', 'Books about historical events and figures.'),
(305, 'Mathematics', 'Books covering mathematical concepts and research.');

INSERT INTO Reservations (ID_Reservations, Reservation_Date, Status, ID_Book, ID_Members)
VALUES 
(401, '2024-02-01', 'Active', 1, 101),
(402, '2024-02-03', 'Cancelled', 2, 102),
(403, '2024-02-05', 'Completed', 3, 103),
(404, '2024-02-07', 'Active', 4, 104),
(405, '2024-02-10', 'Completed', 5, 105);


SELECT * 
FROM Books
WHERE Title = 'Database Fundamentals';


ALTER TABLE Members
ADD  Email VARCHAR(100);

INSERT INTO Members (ID_Members, Name, Contact_Information, Membership_Type, Registration_Date, Email)
VALUES (106, 'Omar', '9876543210', 'Student', '2024-06-05', 'Omar@gmail.com');


SELECT * 
FROM Members 
JOIN Reservations on Members.ID_Members=Reservations.ID_Members;

SELECT *
FROM Members
JOIN Book_Member ON Members.ID_Members = Book_Member.ID_Members
JOIN Books ON Book_Member.ID_Book = Books.ID_Book
WHERE Books.Title = 'SQL for Beginners';


SELECT Members.Name
FROM Members
JOIN Book_Member ON Members.ID_Members = Book_Member.ID_Members
JOIN Books ON Book_Member.ID_Book = Books.ID_Book
WHERE Books.Title = 'C# Programming' AND Book_Member.return_date IS NOT NULL;


INSERT INTO Book_Member (ID_BM, Borrowing_Date, Due_Date, Return_Date, ID_Members, ID_Book, ID_Fine)
VALUES (10, '2024-01-01', '2024-01-10', '2024-01-15', 101, 1, NULL);
SELECT  *
FROM Members
JOIN Book_Member ON Members.ID_Members = Book_Member.ID_Members
WHERE Book_Member.return_date > Book_Member.due_date;


INSERT INTO Book_Member (ID_BM, Borrowing_Date, Due_Date, Return_Date, ID_Members, ID_Book, ID_Fine)
VALUES 
(6, '2024-06-01', '2024-06-10', NULL, 101, 1, NULL),
(7, '2024-06-11', '2024-06-20', NULL, 102, 2, NULL),
(8, '2024-06-21', '2024-06-30', NULL, 103, 1, NULL),
(9, '2024-07-01', '2024-07-10', NULL, 104, 1, NULL),
(11, '2024-07-11', '2024-07-20', NULL, 105, 1, NULL);

SELECT Title, COUNT(*) AS Borrow_Count
FROM Book_Member 
JOIN Books ON Book_Member.ID_Book = Books.ID_Book
GROUP BY Title
HAVING COUNT(*) > 3;

SELECT * 
FROM Members 
JOIN Book_Member ON Members.ID_Members = Book_Member.ID_Members
WHERE Book_Member.Borrowing_date BETWEEN '2024-01-01' AND '2024-01-10';

SELECT COUNT(*) AS Total_Books FROM Books;


SELECT * 
FROM Members 
JOIN Book_Member ON Members.ID_Members = Book_Member.ID_Members
WHERE Book_Member.return_date IS NULL;




