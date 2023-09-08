use tech_lib;

CREATE FUNCTION fn_RetriveAllBooksByBorrowerID(@borrower_id bigint)
RETURNS TABLE
AS
RETURN
WITH AllBooksBorrowed AS
(
	SELECT BookID FROM Loans WHERE BorrowerID = @borrower_id
)
SELECT b.* 
FROM Books AS b
JOIN AllBooksBorrowed AS abb
ON abb.BookID = b.BookID;

