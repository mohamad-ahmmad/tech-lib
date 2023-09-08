

CREATE FUNCTION fn_PopularGenre(@month int)
RETURNS NVARCHAR(128)
AS
BEGIN

	DECLARE @popularGenre NVARCHAR(128);

	DECLARE curs CURSOR FOR
	WITH PopularBooks as
	(
		SELECT BookID ,dense_rank() over (order by count('*') desc) as Rank 
		FROM Loans 
		WHERE MONTH(BorrowedDate) = @month
		GROUP BY BookID
	)
	, MostPopularBook as
	(
		SELECT TOP 1 * FROM PopularBooks
	)
	SELECT g.Name
	FROM PopularBooks as pb
	JOIN Books as b 
	ON b.BookID = pb.BookID
	JOIN Genres as g
	ON b.GenreID = g.GenreID;

	OPEN curs;

	FETCH NEXT FROM curs INTO @popularGenre

	return @popularGenre;
END

