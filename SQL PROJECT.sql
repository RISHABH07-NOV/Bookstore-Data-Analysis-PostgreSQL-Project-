-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'C:\Users\dell\Downloads\Books.csv' 
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'C:\Users\dell\Downloads\Customers.csv' 
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'C:\Users\dell\Downloads\Orders.csv' 
CSV HEADER;
--Basic Query
-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM BOOKS WHERE GENRE = 'Fiction';

-- 2) Find books published after the year 1950:

SELECT * FROM BOOKS WHERE PUBLISHED_YEAR > 1950;

-- 3) List all customers from the Canada:

SELECT * FROM CUSTOMERS WHERE COUNTRY = 'Canada';

-- 4) Show orders placed in November 2023:

SELECT *FROM orders
WHERE EXTRACT(MONTH FROM order_date) = 11
  AND EXTRACT(YEAR FROM order_date) = 2023;

-- 5) Retrieve the total stock of books available:

SELECT SUM(STOCK) AS total_stock
FROM BOOKS;

-- 6) Find the details of the most expensive book:

SELECT * FROM BOOKS
WHERE PRICE = (SELECT MAX(PRICE) FROM BOOKS);

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM ORDERS
WHERE QUANTITY >= 1;

-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM ORDERS
WHERE TOTAL_AMOUNT > 20;

-- 9) List all genres available in the Books table:

SELECT DISTINCT(GENRE) FROM BOOKS;

-- 10) Find the book with the lowest stock:

SELECT * FROM BOOKS
WHERE STOCK = (SELECT MIN(STOCK) FROM BOOKS);

-- 11) Calculate the total revenue generated from all orders:

SELECT SUM(TOTAL_AMOUNT) FROM ORDERS;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

SELECT SUM(O.QUANTITY) AS TOTAL_QUANTITY_SOLD,
       SUM(O.TOTAL_AMOUNT) AS TOTAL_AMOUNT_MADE,
       B.GENRE
FROM ORDERS O
INNER JOIN BOOKS B
ON O.BOOK_ID = B.BOOK_ID
GROUP BY B.GENRE;

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(O.TOTAL_AMOUNT / O.QUANTITY) AS AVERAGE_PRICE
FROM BOOKS B
INNER JOIN ORDERS O
ON O.BOOK_ID = B.BOOK_ID
WHERE GENRE = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:

SELECT C.NAME
FROM CUSTOMERS C
INNER JOIN ORDERS O
ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE O.QUANTITY >= 2;

-- 4) Find the most frequently ordered book:

SELECT o.book_id, 
       b.title, 
       COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT *
FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT DISTINCT(B.AUTHOR), 
       SUM(O.QUANTITY) AS QUANTITY_SOLD
FROM BOOKS B
INNER JOIN ORDERS O
ON O.BOOK_ID = B.BOOK_ID
GROUP BY B.AUTHOR;

-- 7) List the cities where customers who spent over $30 are located:

SELECT C.city,
       SUM(O.total_amount) AS total_spent
FROM customers C
INNER JOIN orders O
ON C.customer_id = O.customer_id
GROUP BY C.city
HAVING SUM(O.total_amount) > 30;

-- 8) Find the customer who spent the most on orders:

SELECT C.name,
       SUM(O.total_amount) AS top_amount
FROM customers C
INNER JOIN orders O
ON C.customer_id = O.customer_id
GROUP BY C.name
ORDER BY top_amount DESC
LIMIT 3;

--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id,
       b.title,
       b.stock,
       COALESCE(SUM(o.quantity), 0) AS Order_Quantity,
       b.stock - COALESCE(SUM(o.quantity), 0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title
ORDER BY b.book_id;

-- 10) Monthly revenue trend

SELECT DATE_TRUNC('month', Order_Date) AS Month,
       SUM(Total_Amount) AS Monthly_Revenue
FROM Orders
GROUP BY Month
ORDER BY Month;

-- 11) Top-selling genre by revenue
SELECT B.Genre, SUM(O.Total_Amount) AS Genre_Revenue
FROM Books B
JOIN Orders O ON B.Book_ID = O.Book_ID
GROUP BY B.Genre
ORDER BY Genre_Revenue DESC
LIMIT 1;

-- 12) Customer lifetime value (CLV)
SELECT C.Customer_ID, C.Name, SUM(O.Total_Amount) AS Lifetime_Value
FROM Customers C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
GROUP BY C.Customer_ID, C.Name
ORDER BY Lifetime_Value DESC;

-- 13) Books never ordered
SELECT Title FROM Books
WHERE Book_ID NOT IN (SELECT Book_ID FROM Orders);


