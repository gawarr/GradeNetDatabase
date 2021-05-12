USE GradeNet_PROD
------------------------------------
GO

CREATE TABLE [dbo].[Configuration](
	ConfigId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Key] VARCHAR(30) UNIQUE NOT NULL,
	Value VARCHAR(30) NOT NULL,
	Description VARCHAR(100),
)
------------------------------------
GO
CREATE SCHEMA [Log]

CREATE TABLE [Log].[Logs](
	LogId BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Note VARCHAR(255) NOT NULL,
	CreationTime DATETIME NOT NULL
)
------------------------------------
GO
CREATE SCHEMA [User]

CREATE TABLE [User].[Addresses](
	AddressId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Place VARCHAR(30) NOT NULL,
	Prefix VARCHAR(8),
	Street VARCHAR(30),
	HouseNumber VARCHAR(8) NOT NULL,
	ApartmentNumber VARCHAR(8),
	PostalCode VARCHAR(6) NOT NULL,
	PostOfficePlace VARCHAR(30) NOT NULL
)
CREATE TABLE [User].[Users](
	UserId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Email VARCHAR(50) UNIQUE NOT NULL,
	Password VARCHAR(32) NOT NULL,
    LastSuccessfulLogin DATETIME,
	IsEnabled BIT NOT NULL
)
CREATE TABLE [User].[UserDetails](
	UserDetailsId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	UserId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
    FirstName VARCHAR(30) NOT NULL,
	SecondName VARCHAR(30),
	Surname VARCHAR(60) NOT NULL,
	PESEL VARCHAR(11) UNIQUE,
    ContactNumber VARCHAR(15) NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES [User].[Addresses](AddressId),
	ParentId INT FOREIGN KEY REFERENCES [User].[Users](UserId),
	CreationTime DATETIME NOT NULL,
	ModificationTime DATETIME NOT NULL,
	UserModificatedId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	IsEnabled BIT NOT NULL
)
CREATE TABLE [User].[Permissions](
	PermissionId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(50) UNIQUE NOT NULL,
	[Description] VARCHAR(100) UNIQUE NOT NULL,
	IsEnabled BIT NOT NULL
)
CREATE TABLE [User].[Roles](
	RoleId TINYINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(50) UNIQUE NOT NULL,
	[Description] VARCHAR(100) UNIQUE NOT NULL,
	IsEnabled BIT NOT NULL
)
CREATE TABLE [User].[RolePermissions](
	RolePermissionId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	RoleId TINYINT NOT NULL FOREIGN KEY REFERENCES [User].[Roles](RoleId),    
	PermissionId INT NOT NULL FOREIGN KEY REFERENCES [User].[Permissions](PermissionId), 
	CreationTime DATETIME NOT NULL,
	ModificationTime DATETIME NOT NULL,
	UserModificatedId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	IsEnabled BIT NOT NULL
)
CREATE TABLE [User].[UserRoles](
	UserRoleId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	UserId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	RoleId TINYINT NOT NULL FOREIGN KEY REFERENCES [User].[Roles](RoleId),
	CreationTime DATETIME NOT NULL,
	ModificationTime DATETIME NOT NULL,
	UserModificatedId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	IsEnabled BIT NOT NULL
)
------------------------------------
GO
CREATE SCHEMA [School]

CREATE TABLE [School].[Classes](
	ClassId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(7) NOT NULL,
	MainTeacherId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	[StartYear] INT NOT NULL
)
CREATE TABLE [School].[ClassStudents](
	ClassStudentId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	StudentId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	ClassId INT NOT NULL FOREIGN KEY REFERENCES [School].[Classes](ClassId)
)
CREATE TABLE [School].[LessonTypes](
	LessonTypeId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(31) UNIQUE NOT NULL,
    IsEnabled BIT NOT NULL
)
CREATE TABLE [School].[Lessons](
	LessonId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	LessonTypeId INT NOT NULL FOREIGN KEY REFERENCES [School].[LessonTypes](LessonTypeId),
	TeacherId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId)
)
------------------------------------
CREATE TABLE [School].[GradeStyles](
	GradeStyleId TINYINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Style VARCHAR(255) UNIQUE NOT NULL
)
CREATE TABLE [School].[Grades](
	GradeId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Grade VARCHAR(3) NOT NULL,
	GradeStyleId TINYINT NOT NULL FOREIGN KEY REFERENCES [School].[GradeStyles](GradeStyleId)
)	
CREATE TABLE [School].[StudentGrades](
	StudentGradeId BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	StudentId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	GradeId INT NOT NULL FOREIGN KEY REFERENCES [School].[Grades](GradeId),
	LessonId INT NOT NULL FOREIGN KEY REFERENCES [School].[Lessons](LessonId),
	CreationTime DATETIME NOT NULL,
	ModificationTime DATETIME NOT NULL,
	UserModificatedId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	IsEnabled BIT NOT NULL
)
CREATE TABLE [School].[ClassLessons](
	ClassLessonId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	ClassId INT NOT NULL FOREIGN KEY REFERENCES [School].[Classes](ClassId),
	LessonId INT NOT NULL FOREIGN KEY REFERENCES [School].[Lessons](LessonId)
)	
CREATE TABLE [School].[PresentTypes](
	PresentTypeId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(30) UNIQUE NOT NULL,
	[Shortcut] VARCHAR(2) UNIQUE NOT NULL
)
CREATE TABLE [School].[Frequency](
	FrequencyId BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Date] DATE NOT NULL,
	LessonNumber TINYINT NOT NULL,
	StudentId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	PresentTypeId INT NOT NULL FOREIGN KEY REFERENCES [School].[PresentTypes](PresentTypeId)
)
CREATE TABLE [School].[StudentsComments](
	CommentId BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	StudentId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	TeacherId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	Content VARCHAR(250) NOT NULL,
	CreationTime DATETIME NOT NULL,
	ModificationTime DATETIME NOT NULL,
	UserModificatedId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	IsEnabled BIT NOT NULL
)
CREATE TABLE [School].[Subjects](
	SubjectId BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	LessonId INT NOT NULL FOREIGN KEY REFERENCES [School].[Lessons](LessonId),
	CreationTime DATETIME NOT NULL,
	ModificationTime DATETIME NOT NULL,
	UserModificatedId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	IsEnabled BIT NOT NULL
)
CREATE TABLE [School].[Events](
	EventId BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	EventDate DATETIME NOT NULL,
	[Description] VARCHAR(100) NOT NULL,
	TeacherId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	ClassId INT NOT NULL FOREIGN KEY REFERENCES [School].[Classes](ClassId),
	CreationTime DATETIME NOT NULL,
	ModificationTime DATETIME NOT NULL,
	UserModificatedId INT NOT NULL FOREIGN KEY REFERENCES [User].[Users](UserId),
	IsEnabled BIT NOT NULL
)