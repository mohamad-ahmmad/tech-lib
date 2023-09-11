
CREATE PROC sp_BorrowedBooksReport
	@start_date Date,
	@end_date Date
AS
BEGIN
	SELECT b.Title as BookTitle, l.BorrowedDate, (bo.FName + ' ' + bo.LName) as BorrowerFullName
	FROM Loans as l
	JOIN Books as b
	ON l.BookID = b.BookID
	JOIN Borrowers as bo
	ON bo.BorrowerID = l.BorrowerID
	WHERE
		l.BorrowedDate >= @start_date AND l.BorrowedDate <= @end_date
END

--EXEC sp_BorrowedBooksReport  @start_date = '2020-09-01' , @end_date = '2023-09-01';
