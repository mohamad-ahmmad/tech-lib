

CREATE PROC sp_AddNewBorrower 
	@fname NVARCHAR(64),
	@lname NVARCHAR(64),
	@email NVARCHAR(256),
	@birthdate DATE,
	@membershipDate Date
AS
BEGIN

	IF EXISTS (SELECT '*' FROM BORROWERS WHERE Email = @email)
	BEGIN
		RAISERROR('The email already exists', 16, 1);
	END
	
	INSERT INTO Borrowers (FName, LName, email, Birthdate, MembershipDate) VALUES (@fname, @lname, @email, @birthdate, @membershipDate);
	
END


