CREATE PROCEDURE [dbo].[spPerson_FilterByLastName]
	@LastName nvarchar(50)
AS
BEGIN
	SELECT [Id], [FirstName], [LastName]
	from dbo.Person 
	where LastName = @LastName;
END
