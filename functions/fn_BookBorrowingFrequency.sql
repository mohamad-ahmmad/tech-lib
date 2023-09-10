

CREATE FUNCTION fn_BookBorrowingFrequency(@book_id BIGINT)
RETURNS INT
AS
BEGIN
    DECLARE @BorrowingCount INT;

    SELECT @BorrowingCount = COUNT('*')
    FROM Loans
    WHERE BookID = @book_id;

    RETURN @BorrowingCount;
END