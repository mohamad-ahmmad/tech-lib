

SELECT BorrowerID,
DENSE_RANK() OVER (ORDER BY count(BookID) desc) as BorrowingFrequencyRank
FROM Loans 
GROUP BY BorrowerID;
