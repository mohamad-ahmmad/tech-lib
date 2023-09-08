
<<<<<<< HEAD
use tech_lib;

=======
>>>>>>> 9159c266675ba024a3021aa48f1119ebf7338098
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
