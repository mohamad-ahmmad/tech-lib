
CREATE OR ALTER PROC sp_StoreAllOvedueBorrowersTempTable
AS
BEGIN
	DROP TABLE IF EXISTS #temp_OverdueBorrowers;
	CREATE TABLE #temp_OverdueBorrowers
	(
		OverdueID bigint identity (1,1) primary key,
		BorrowerID bigint not null,
		LoanID bigint not null,
	);
	
	INSERT INTO #temp_OverdueBorrowers (BorrowerID, LoanID)
	SELECT BorrowerID, LoanID
	FROM Loans as l
	WHERE l.DateReturned IS NULL AND GETDATE() > l.DueDate;

	SELECT t.BorrowerID, l.BookID, l.DueDate
	FROM #temp_OverdueBorrowers as t
	JOIN Loans as l
	ON l.LoanID = t.LoanID;

END;

--EXEC sp_StoreAllOvedueBorrowersTempTable;

