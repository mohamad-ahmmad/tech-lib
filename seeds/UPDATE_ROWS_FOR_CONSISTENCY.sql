
with availableBooks as
(
	select BookID from Loans where DateReturned is null
)
UPDATE Books
SET CurrentStatus = CASE 
						WHEN BookID in	(select BookID from availableBooks) THEN 0
						ELSE 1
					END;

