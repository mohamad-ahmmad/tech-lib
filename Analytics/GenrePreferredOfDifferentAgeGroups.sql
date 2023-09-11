
WITH UsersAgeIntervalWithBookBorrowed as
(
SELECT CASE
		WHEN dbo.GetAge(b.BorrowerID) > 0 AND dbo.GetAge(b.BorrowerID) <= 10 THEN '0-10'
		WHEN dbo.GetAge(b.BorrowerID) > 10 AND dbo.GetAge(b.BorrowerID) <= 20 THEN '11-20'
		WHEN dbo.GetAge(b.BorrowerID) > 20 AND dbo.GetAge(b.BorrowerID) <= 30 THEN '21-30'
		WHEN dbo.GetAge(b.BorrowerID) > 30 AND dbo.GetAge(b.BorrowerID) <= 40 THEN '31-40'
		WHEN dbo.GetAge(b.BorrowerID) > 40 AND dbo.GetAge(b.BorrowerID) <= 50 THEN '41-50'
		WHEN dbo.GetAge(b.BorrowerID) > 50 AND dbo.GetAge(b.BorrowerID) <= 60 THEN '51-60'
		WHEN dbo.GetAge(b.BorrowerID) > 60 AND dbo.GetAge(b.BorrowerID) <= 70 THEN '61-70'
		WHEN dbo.GetAge(b.BorrowerID) > 70 AND dbo.GetAge(b.BorrowerID) <= 80 THEN '71-80'
	   END as AgeInterval,
	   l.BookID
		FROM Loans as l
		JOIN Borrowers as b
		ON l.BorrowerID = b.BorrowerID
)
, AgeIntervalWithGenreCount
as
(
	SELECT AgeInterval, g.Name ,count(g.Name) as Count
	FROM UsersAgeIntervalWithBookBorrowed as u
	JOIN Books as b
	ON u.BookID = B.BookID
	JOIN Genres as g
	ON g.GenreID = b.GenreID
	GROUP BY u.AgeInterval, g.Name
), MaxCountGroupedByAgeInterval as
(
	SELECT AgeInterval ,max(Count) as Max From AgeIntervalWithGenreCount as ai Group By AgeInterval
)
SELECT a.AgeInterval, a.Name, a.Count 
FROM AgeIntervalWithGenreCount as a
JOIN MaxCountGroupedByAgeInterval as m
ON a.AgeInterval = m.AgeInterval 
WHERE a.Count = m.Max;