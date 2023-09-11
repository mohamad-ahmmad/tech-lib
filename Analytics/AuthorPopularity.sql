
WITH count_books as
(
	SELECT BookID, count('*') as Count
	FROM Loans
	GROUP BY BookID
)
SELECT Author, b.Title, cb.Count
FROM Books as b
JOIN count_books as cb
ON b.BookID = cb.BookID
ORDER BY cb.Count DESC;
