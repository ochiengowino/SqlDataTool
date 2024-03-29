﻿/*
Deployment script for DatatoolDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DatatoolDB"
:setvar DefaultFilePrefix "DatatoolDB"
:setvar DefaultDataPath "C:\Users\LYN\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\mssqllocaldb\"
:setvar DefaultLogPath "C:\Users\LYN\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\mssqllocaldb\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating View [dbo].[FullPerson]...';


GO
CREATE VIEW [dbo].[FullPerson]
	AS SELECT [p].[Id] As PersonId, [p].[FirstName], [p].[LastName] , 
		[a].[Id] As AddressId, [a].[StreetAddress], [a].[City], [a].[State], [a].[ZipCode] 
		from dbo.Person p left join dbo.Address a on p.Id = a.PersonId
GO
PRINT N'Creating Procedure [dbo].[spPerson_FilterByLastName]...';


GO
CREATE PROCEDURE [dbo].[spPerson_FilterByLastName]
	@LastName nvarchar(50)
AS
BEGIN
	SELECT [Id], [FirstName], [LastName]
	from dbo.Person 
	where LastName = @LastName;
END
GO
PRINT N'Update complete.';


GO
