
use tech_lib;

CREATE FUNCTION fn_GetActiveBorrowers()
RETURNS TABLE
AS
RETURN
WITH BorrowersCounts AS
(
	SELECT BorrowerID ,count('*') AS Times 
	FROM Loans 
	WHERE DateReturned IS NULL
	GROUP BY BorrowerID
)
SELECT * 
FROM BorrowersCounts
WHERE Times >= 2;
