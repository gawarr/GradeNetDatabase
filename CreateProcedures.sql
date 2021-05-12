-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 18.04.2021
-- Description:	Procedura pobierająca uzytkownika.
-- =============================================
CREATE PROCEDURE [User].[UserGet]
	@UserId INT
AS
BEGIN
	SELECT 
		 UserId
		,Password
        ,Email
	FROM 
		[User].[Users]
	WHERE
		UserId = @UserId
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.04.2021
-- Description:	Procedura sprawdzająca podane dane przy logowaniu
-- =============================================
CREATE PROCEDURE [User].[CheckLoginDetails]
	@Email VARCHAR(50),
	@Password VARCHAR(32)
AS
BEGIN
	SELECT IsCorrent = 
		CASE
			WHEN Count(0) > 0 THEN 1
			WHEN Count(0) = 0 THEN 0
		END
	FROM [User].[Users]
	WHERE
		Email = @Email
	AND Password = @Password
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.04.2021
-- Description:	Procedura pobiera uprawnienia użytkownika
-- =============================================
CREATE PROCEDURE [User].[PermisionsOfUserGet]
	@Email VARCHAR(50)
AS
BEGIN
	SELECT 
		 p.Name
	FROM [User].[Permissions] p 
	JOIN [User].[RolePermissions] rp
	ON rp.PermissionId = p.PermissionId AND rp.IsEnabled = 1
	JOIN [User].[Roles] r
	ON r.RoleId = rp.RoleId				AND r.IsEnabled = 1
	JOIN [User].[UserRoles] ur
	ON ur.RoleId = r.RoleId				AND ur.IsEnabled = 1
	JOIN [User].[Users] u
	ON u.UserId = ur.UserId				AND u.IsEnabled = 1
	WHERE
		u.Email = @Email				AND p.IsEnabled = 1
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.04.2021
-- Description:	Procedura aktualizująca datę ostatniego zalogowania
-- =============================================
CREATE PROCEDURE [User].[LastSuccessfulLoginSet]
	@Email VARCHAR(50)
AS
BEGIN
	UPDATE [User].[Users] 
	SET LastSuccessfulLogin = GETDATE() 
	WHERE Email = @Email
END
GO

--  -- =============================================
--  -- Author:		Paweł Gawarecki
--  -- Create date: 23.04.2021
--  -- Description:	Procedura pobiera główne role użytkownika
--  -- =============================================
--  CREATE PROCEDURE [User].[MainRolesOfUserGet]
--  	@Email VARCHAR(50)
--  AS
--  BEGIN
--  	SELECT 
--  		 r.Name
--  	FROM [User].[Roles] r
--  	JOIN [User].[UserRoles] ur
--  	ON ur.RoleId = r.RoleId				AND ur.IsEnabled = 1
--  	JOIN [User].[Users] u
--  	ON u.UserId = ur.UserId				AND u.IsEnabled = 1
--  	WHERE
--  		u.Email = @Email				AND r.IsEnabled = 1
--  	AND r.Name IN ('student', 'parent', 'teacher')
--  END
--  GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 23.04.2021
-- Description:	Procedura pobiera szczegóły użytkownika
-- =============================================
CREATE PROCEDURE [User].[UserDetailsGet]
	@Email VARCHAR(50)
AS
BEGIN
	SELECT
		 ud.FirstName
		,ud.SecondName
		,ud.Surname
		,ud.ContactNumber
		,ud.PESEL
		,ud.IsConfirmed
		,a.Place
		,a.Prefix
		,a.Street
		,a.HouseNumber
		,a.ApartmentNumber
		,a.PostalCode
		,a.PostOfficePlace
	FROM [User].[Users] u
	JOIN [User].[UserDetails] ud
	ON ud.UserId = u.UserId
	JOIN [User].[Addresses] a
	ON a.AddressId = ud.AddressId
END
GO