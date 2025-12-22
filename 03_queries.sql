BASIC QUERIES

-- 1. Retrieve all books
SELECT * FROM Books;

-- 2. Retrieve all customers
SELECT * FROM Customers;

-- 3. Retrieve all orders
SELECT * FROM Orders;

-- 4. Books in Fiction genre
SELECT * FROM Books
WHERE Genre = 'Fiction';

-- 5. Books published after 1950
SELECT * FROM Books
WHERE Published_Year > 1950
ORDER BY Published_Year;

-- 6. Customers from Canada
SELECT * FROM Customers
WHERE Country = 'Canada';

-- 7. Orders placed in November 2023
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 8. Total stock of books
SELECT SUM(Stock) AS Total_Stock
FROM Books;

-- 9. Most expensive book
SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

-- 10. Book with lowest stock
SELECT * FROM Books
ORDER BY Stock ASC
LIMIT 1;


INTERMEDIATE QUERIES

-- 11. Total revenue from all orders
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Orders;

-- 12. Customers who ordered more than 1 quantity
SELECT * FROM Orders
WHERE Quantity > 1;

-- 13. List all available genres
SELECT DISTINCT Genre FROM Books;

-- 14. Average price of Fantasy books
SELECT AVG(Price) AS Avg_Fantasy_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 15. Top 3 most expensive Fantasy books
SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;


ADVANCED QUERIES

-- 16. Total books sold by each genre
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre;

-- 17. Customers with at least 2 orders
SELECT c.Customer_ID, c.Name, COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- 18. Most frequently ordered book
SELECT b.Title, COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Title
ORDER BY Order_Count DESC
LIMIT 1;

-- 19. Total quantity sold by each author
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author
ORDER BY Total_Books_Sold DESC;

-- 20. Customer who spent the most
SELECT c.Name, SUM(o.Total_Amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Name
ORDER BY Total_Spent DESC
LIMIT 1;

-- 21. Remaining stock after fulfilling orders
SELECT b.Title,
       b.Stock,
       COALESCE(SUM(o.Quantity),0) AS Sold_Quantity,
       b.Stock - COALESCE(SUM(o.Quantity),0) AS Remaining_Stock
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Title, b.Stock;
