# Bookstore-Data-Analysis-PostgreSQL-Project-
Overview
This project demonstrates how to design and analyze a relational database for a bookstore using PostgreSQL. It includes schema creation and a collection of SQL queries ranging from basic retrievals to advanced analytical queries.
The goal is to showcase how SQL can be used for data analysis, covering customer insights, sales trends, and inventory management.
Dataset used
- order.csv:-[View Orders.csv](https://github.com/RISHABH07-NOV/Bookstore-Data-Analysis-PostgreSQL-Project-/blob/main/Orders.csv)
- customer.csv:-[View Customers.csv](https://github.com/RISHABH07-NOV/Bookstore-Data-Analysis-PostgreSQL-Project-/blob/main/Customers.csv)
- books.csv:-[View Books.csv](https://github.com/RISHABH07-NOV/Bookstore-Data-Analysis-PostgreSQL-Project-/blob/main/Books.csv)
SQL FILE:-[View SQL PROJECT.sql](https://github.com/RISHABH07-NOV/Bookstore-Data-Analysis-PostgreSQL-Project-/blob/main/SQL%20PROJECT.sql)
Database Schema
The project consists of three main tables:
1. Books
- Book_ID (Primary Key)
- Title
- Author
- Genre
- Published_Year
- Price
- Stock
2. Customers
- Customer_ID (Primary Key)
- Name
- Email
- Phone
- City
- Country
3. Orders
- Order_ID (Primary Key)
- Customer_ID (Foreign Key → Customers)
- Book_ID (Foreign Key → Books)
- Order_Date
- Quantity
- Total_Amount
#🧩 Basic Queries
    1. Retrieve all books in the Fiction genre
    2. Find books published after the year 1950
    3. List all customers from Canada
    4. Show orders placed in November 2023
    5. Retrieve the total stock of books available
    6. Find the details of the most expensive book
    7. Show all customers who ordered more than 1 quantity of a book
    8. Retrieve all orders where the total amount exceeds $20
    9. List all genres available in the Books table
    10. Find the book with the lowest stock
    11. Calculate the total revenue generated from all orders
#🚀 Advanced Queries
    1. Retrieve the total number of books sold per genre
    2. Find the average price of books in the Fantasy genre
    3. List customers who have placed at least 2 orders
    4. Find the most frequently ordered book
    5. Show the top 3 most expensive Fantasy books
    6. Retrieve the total quantity of books sold by each author
    7. List the cities where customers who spent over $30 are located
    8. Find the customer who spent the most on orders
    9. Calculate the stock remaining after fulfilling all orders
    10.Monthly revenue trend 
    11.Top-selling genre by revenue
    12.Customer lifetime value (CLV) 
    13. Books never ordered
#Purpose of the Project
The purpose of this project is to:
- Model a bookstore database using PostgreSQL with normalized tables for books, customers, and orders.
- Practice SQL fundamentals through basic queries (retrieving records, filtering, aggregations).
- Showcase analytical skills with advanced queries (joins, grouping, window functions, CTEs).
- Provide business insights such as:
- Identifying top customers and bestselling books
- Tracking revenue trends and customer lifetime value
- Monitoring inventory levels and stock utilization
- Analyzing genre‑wise and author‑wise performance

🔎 Analytical Enhancements
    • Window Functions: Ranking customers by spending
    • CTEs: Modular queries for genre-based revenue analysis
