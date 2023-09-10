
CREATE FUNCTION fn_CalculateOverdueFees(@loan_id BIGINT)
RETURNS INT
AS
BEGIN

IF NOT EXISTS (SELECT '*' FROM Loans WHERE LoanID = @loan_id)
BEGIN
	--NULL indicate an error
	RETURN NULL;
END

--Get returned day of the book
DECLARE @returned_date DATE;
SELECT @returned_date = DateReturned 
FROM Loans
WHERE LoanID = @loan_id;

IF @returned_date IS NULL 
BEGIN
	SET @returned_date = GETDATE();
END


--Get due date of the book
DECLARE @due_date DATE;
SELECT @due_date = DueDate 
FROM Loans
WHERE LoanID= @loan_id;

--Calculate the number of dates using DATEDIFF(type {day,month,year}, @date1 Date, @date2 Date) function
DECLARE @days_between_borrowed_and_returned INT;
SET @days_between_borrowed_and_returned = DATEDIFF(day, @due_date, @returned_date);

--Calculate the fee:
DECLARE @fee INT = 0;
IF @days_between_borrowed_and_returned > 30
BEGIN
	SET @days_between_borrowed_and_returned = @days_between_borrowed_and_returned - 30;
	SET @fee = 30 + (@days_between_borrowed_and_returned * 2);

END
ELSE IF @days_between_borrowed_and_returned < 30 AND @days_between_borrowed_and_returned > 0
BEGIN
	SET @fee = @days_between_borrowed_and_returned;
END

RETURN @fee;
END

