INSERT INTO [User].[Users]
 (Email				 , Password												   , LastSuccessfulLogin, IsEnabled)
VALUES 
 ('admin@admin.pl'   , CONVERT(VARCHAR(32), HashBytes('MD5', 'admin'), 2)      , NULL				, 1)
,('nauczyciel1@m.com', CONVERT(VARCHAR(32), HashBytes('MD5', 'nauczyciel1'), 2), NULL				, 1)
,('rodzic1@m.com'	 , CONVERT(VARCHAR(32), HashBytes('MD5', 'rodzic1'), 2)    , NULL				, 1)
,('uczen1@m.com'	 , CONVERT(VARCHAR(32), HashBytes('MD5', 'uczen1'), 2)	   , NULL				, 1)

INSERT INTO [User].[Permissions] 
 (Name				   , Description									   , IsEnabled)
VALUES 
 ('user_administration', 'Uprawenie do panelu administracji użytkownikami.', 1)
,('teacher'			   , 'Uprawnienie nauczyciela'						   , 1)
,('parent' 			   , 'Uprawnienie opiekuna'	  						   , 1)
,('student'			   , 'Uprawnienie studenta'	  						   , 1)

INSERT INTO [User].[Roles]
 (Name	   , Description	, IsEnabled)
VALUES
 ('admin'  , 'Administrator', 1)
,('teacher', 'Nauczyciel'	, 1)
,('parent' , 'Opiekun'   	, 1)
,('student', 'Uczeń'     	, 1)

INSERT INTO [User].[RolePermissions]
 (RoleId, PermissionId, CreationTime, ModificationTime, UserModificatedId, IsEnabled)
VALUES 
 (1     , 1			 , GETDATE()    , GETDATE()		  , 1				 , 1)
,(2     , 2			 , GETDATE()    , GETDATE()		  , 1				 , 1)
,(3     , 3			 , GETDATE()    , GETDATE()		  , 1				 , 1)
,(4     , 4			 , GETDATE()    , GETDATE()		  , 1				 , 1)

INSERT INTO [User].[UserRoles]
(UserId, RoleId, CreationTime, ModificationTime, UserModificatedId, IsEnabled)
VALUES
 (1	   , 1	   , GETDATE()	 , GETDATE()	   , 1				  , 1)
,(1	   , 2	   , GETDATE()	 , GETDATE()	   , 1				  , 1)
,(2	   , 2	   , GETDATE()	 , GETDATE()	   , 1				  , 1)
,(3	   , 3	   , GETDATE()	 , GETDATE()	   , 1				  , 1)
,(4	   , 4	   , GETDATE()	 , GETDATE()	   , 1				  , 1)

INSERT INTO [User].[Addresses]
 (Place				, Prefix, 	 Street, HouseNumber, ApartmentNumber, PostalCode, PostOfficePlace)
VALUES
 ('Testowa Mieścina', 'ul.' , 'testowa', '3' 		, '23'			 , '11-111'	 , 'testowa'  )
,('Niedzórz'		, null  , null	   , '35'		, null			 , '06-111'	 , 'Niedzbórz')
,('Niedzórz'		, null  , null	   , '99'		, null			 , '06-111'	 , 'Niedzbórz')

INSERT INTO [User].[UserDetails]
 (UserId, FirstName, SecondName   , Surname    , PESEL		  , ContactNumber, AddressId, ParentId, CreationTime, ModificationTime, UserModificatedId, IsConfirmed, IsEnabled)
VALUES
 (1		, 'Imię'   , 'DrugieImię' , 'Nazwisko' , '11111111111', '123123123'  , 1		, null	  , GETDATE(), GETDATE(), 1, 1, 1) 
,(2		, 'Paweł'  , null	  	  , 'Oski'	   , null		  , '515515515'  , 2		, null	  , GETDATE(), GETDATE(), 1, 1, 1)   
,(3		, 'Piotr'  , 'Janusz'	  , 'Łęcki'    , null		  , '888888888'  , 3		, null	  , GETDATE(), GETDATE(), 1, 1, 1)   
,(4		, 'Marcin' , null	  	  , 'Łęcki'    , '12345678902', '456456456'  , 3		, 3	  	  , GETDATE(), GETDATE(), 1, 1, 1)

INSERT INTO [School].[Classes]
 (Name   , MainTeacherId, StartYear)
VALUES 
 ('III A', 1			, 2020)

INSERT INTO [School].[ClassStudents]
 (UserId, ClassId)
VALUES 
 (4		, 1)

INSERT INTO [School].[StudentsComments]
 (StudentId, TeacherId, [Content]				, CreationTime, ModificationTime, UserModificatedId, IsEnabled)
VALUES
 (1		   , 2		  , 'Rozmawianie na lekcji' , GETDATE()	  , GETDATE()		, 1				   , 1)
 
INSERT INTO [School].[LessonTypes]
 (Name		  , IsEnabled)
VALUES
 ('Matematyka', 1)

INSERT INTO [School].[Lessons]
 (ClassId, LessonTypeId, TeacherId)
VALUES
 (1		 , 1		   , 2)

INSERT INTO [School].[GradeStyles]
 (Style)
VALUES
 ('black')
,('red'  )
,('green')

INSERT INTO [School].[Grades]
 (Grade, GradeStyleId)
VALUES
 ('5' , 1)
,('3+', 3)

INSERT INTO [School].[StudentGrades]
 (StudentId, GradeId, LessonId, CreationTime, ModificationTime, UserModificatedId, IsEnabled)
VALUES
 (1 	   , 	   1, 		 1, GETDATE()	, GETDATE()		  , 1				 , 1)
,(1 	   , 	   2, 		 1, GETDATE()	, GETDATE()		  , 1				 , 1)

INSERT INTO [School].[PresentTypes]
 (Name		 		, Shortcut)
VALUES
 ('Obecny'	 		, 'O' )
,('Nieobecny'		, 'No')
,('Usprawiedliwiony', 'U' )
,('Spóźniony'		, 'Sp')
,('Zwolniony'		, 'Z' )

INSERT INTO [School].[Frequency]
 (LessonId, LessonNumber, [Date]      , StudentId, PresentTypeId, CreationTime, ModificationTime, UserModificatedId, IsEnabled)
VALUES
 (1  	  , 1  		    , GETDATE()   ,1  		 , 1  		  	, GETDATE(), GETDATE(), 1 , 1)
,(1  	  , 2  		    , GETDATE()   ,1  		 , 2  		  	, GETDATE(), GETDATE(), 1 , 1)

INSERT INTO [School].[EventTypes]
 (EventType   , Shortcut, IsEnabled)
VALUES
 ('Sprawdzian', 'S'      ,1)
,('Kartkówka' , 'K'      ,1)
,('Wycieczka' , 'W'      ,1)

INSERT INTO [School].[Events]
 (EventTypeId, EventDate   , Description				, TeacherId, ClassId, CreationTime, ModificationTime, UserModificatedId, IsEnabled)
VALUES
 (1 		 , GETDATE()   , 'Sprawdzian z matematyki', 2		   , 1		, GETDATE(), GETDATE(), 1, 1)
,(2 		 , GETDATE()   , 'Kartkówka z matematyki' , 2		   , 1		, GETDATE(), GETDATE(), 1, 1)

INSERT INTO [School].[Subjects]
 ([Subject]					, LessonId, SubjectDate , CreationTime, ModificationTime, UserModificatedId, IsEnabled)
VALUES
 ('Równia i nierówności'	, 1		  , GETDATE()   , GETDATE(), GETDATE(), 1, 1)