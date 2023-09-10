
SELECT b.*
FROM Loans as l
JOIN Books as b
ON b.BookID = l.BookID
WHERE DateReturned IS NOT NULL AND DATEDIFF(day,  l.DueDate, l.DateReturned) > 30;
