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
	FROM [User].[Users]
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
		u.Email = @Email					AND p.IsEnabled = 1
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
	WHERE 
		u.Email = @Email
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.05.2021
-- Description:	Procedura pobiera dostępne roczniki
-- =============================================
CREATE PROCEDURE [School].[YearsGet]
AS
BEGIN
	SELECT DISTINCT 
		StartYear
	FROM [School].[Classes]
	ORDER BY 1 DESC
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.05.2021
-- Description:	Procedura pobiera klasy z danego rocznika
-- =============================================
CREATE PROCEDURE [School].[ClassesGet_ForYear]
	@Year INT
AS
BEGIN
	SELECT
		 ClassId 
		,Name
	FROM [School].[Classes]
	WHERE
		StartYear = @Year
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.05.2021
-- Description:	Procedura pobiera zdarzenia dla klasy
-- =============================================
CREATE PROCEDURE [School].[EventsGet_ForClass]
	@ClassId INT
AS
BEGIN
	SELECT
		 EventId
		,EventType
		,Shortcut
		,EventDate
		,Description
	FROM [School].[Events] E
	JOIN [School].[EventTypes] ET
		ON ET.EventTypeId = E.EventTypeId
	WHERE
		E.ClassId = @ClassId
	AND E.IsEnabled = 1
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.05.2021
-- Description:	Procedura pobiera lekcje danej klasy
-- =============================================
CREATE PROCEDURE [School].[LessonsGet_ForClass]
	@ClassId INT
AS
BEGIN
	SELECT
		 L.LessonId 
		,LT.Name
	FROM [School].[Lessons] L
	JOIN [School].[LessonTypes] LT
		ON LT.LessonTypeId = L.LessonTypeId
	WHERE
		ClassId = @ClassId
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.05.2021
-- Description:	Procedura pobiera tematy dla danej lekcji
-- =============================================
CREATE PROCEDURE [School].[SubjectsGet]
	@LessonId INT
AS
BEGIN
	SELECT
		 SubjectId
		,Subject
		,SubjectDate
	FROM [School].[Subjects]
	WHERE
		LessonId = @LessonId
	AND IsEnabled = 1
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.05.2021
-- Description:	Procedura pobiera uczniów klasy
-- =============================================
CREATE PROCEDURE [School].[StudentsGet]
	@ClassId INT
AS
BEGIN
	SELECT
		 S.StudentId
		,UD.FirstName
		,UD.SecondName
		,UD.Surname
	FROM [School].[ClassStudents] S
	JOIN [User].[UserDetails] UD 
		ON UD.UserId = S.UserId AND UD.IsEnabled = 1
	WHERE
		S.ClassId = @ClassId
	ORDER BY 4, 2, 3 ASC
END

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.05.2021
-- Description:	Procedura pobiera frekfencję danego ucznia z wybranej lekcji
-- =============================================
CREATE PROCEDURE [School].[FrequencyGet_ForStudent]
	@StudentId INT,
	@LessonId INT
AS
BEGIN
	SELECT
		 F.FrequencyId
		,F.Date
		,PT.Name
		,PT.Shortcut
	FROM [School].[Frequency] F
	JOIN [School].[PresentTypes] PT 
		ON PT.PresentTypeId = F.PresentTypeId
	WHERE
		F.StudentId = @StudentId
	AND F.IsEnabled = 1
	AND LessonId = @LessonId
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.05.2021
-- Description:	Procedura pobiera uwagi podanego ucznia
-- =============================================
CREATE PROCEDURE [School].[StudentsCommentsGet]
	@StudentId INT
AS
BEGIN
	SELECT
		 SC.CommentId
		,SC.Content
		,SD.FirstName AS StudentFirstName
		,SD.SecondName AS StudentSecondName
		,SD.Surname AS StudentSurname
		,TD.FirstName AS TeacherFirstName
		,TD.SecondName AS TeacherSecondName
		,TD.Surname AS TeacherSurname
	FROM [School].[StudentsComments] SC
	JOIN [School].[ClassStudents] CS
		ON CS.StudentId = SC.StudentId
	JOIN [User].[UserDetails] SD
		ON SD.UserId = CS.UserId
	JOIN [User].[UserDetails] TD
		ON TD.UserId = SC.TeacherId
	WHERE
		SC.StudentId = @StudentId
	AND SC.IsEnabled = 1
	AND SD.IsEnabled = 1
	AND TD.IsEnabled = 1
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.05.2021
-- Description:	Procedura pobiera oceny podanego ucznia z wybranej lekcji
-- =============================================
CREATE PROCEDURE [School].[StudentGradesGet_ForStudent]
	@StudentId INT,
	@LessonId INT
AS
BEGIN
	SELECT
		 SG.StudentGradeId
		,G.Grade
		,GS.Style
	FROM [School].[StudentGrades] SG
	JOIN [School].[Grades] G
		ON G.GradeId = SG.GradeId
	JOIN [School].[GradeStyles] GS
		ON GS.GradeStyleId = G.GradeStyleId
	WHERE
		SG.StudentId = @StudentId
	AND SG.IsEnabled = 1
	AND SG.LessonId = @LessonId
END
GO

-- =============================================
-- Author:		Paweł Gawarecki
-- Create date: 22.05.2021
-- Description:	Procedura pobiera ocen dla klasy z wybranej lekcji
-- =============================================
CREATE PROCEDURE [School].[StudentGradesGet_ForLesson]
	@LessonId INT
AS
BEGIN
	SELECT
		 SG.StudentGradeId
		,G.Grade
		,GS.Style
		,SG.StudentId
	FROM [School].[StudentGrades] SG
	JOIN [School].[Grades] G
		ON G.GradeId = SG.GradeId
	JOIN [School].[GradeStyles] GS
		ON GS.GradeStyleId = G.GradeStyleId
	WHERE
		SG.IsEnabled = 1
	AND SG.LessonId = @LessonId
END
GO
