
CREATE OR ALTER TRIGGER books_status_changed_trigger
ON Books
AFTER UPDATE
AS
BEGIN
	INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
	SELECT i.BookID, i.CurrentStatus as StatusChange, GETDATE() as ChangeDate
	FROM INSERTED as i
	JOIN DELETED as d
	ON i.BookID = d.BookID
	WHERE i.CurrentStatus <> d.CurrentStatus;
END;


--UPDATE Books
--SET CurrentStatus = 0
--WHERE BookID = 1001;
--SELECT * FROM AuditLog

