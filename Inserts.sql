INSERT INTO [User].[Users] (
	 Email
	,Password
	,LastSuccessfulLogin
	,IsEnabled
	)
VALUES (
	 'admin@admin.pl'
	,CONVERT(VARCHAR(32), HashBytes('MD5', 'admin'), 2)
	,NULL
	,1
)
,(
	 'nauczyciel1@m.com'
	,CONVERT(VARCHAR(32), HashBytes('MD5', 'nauczyciel1'), 2)
	,NULL
	,1
)
,(
	 'rodzic1@m.com'
	,CONVERT(VARCHAR(32), HashBytes('MD5', 'rodzic1'), 2)
	,NULL
	,1
)
,(
	 'uczen1@m.com'
	,CONVERT(VARCHAR(32), HashBytes('MD5', 'uczen1'), 2)
	,NULL
	,1
)
,(
	 'uczen2@m.com'
	,CONVERT(VARCHAR(32), HashBytes('MD5', 'uczen2'), 2)
	,NULL
	,1
)
,(
	 'uczen3@m.com'
	,CONVERT(VARCHAR(32), HashBytes('MD5', 'uczen3'), 2)
	,NULL
	,1
)

INSERT INTO [User].[Permissions] (
	 Name
	,Description
	,IsEnabled
)
VALUES (
	 'user_administration'
	,'Uprawenie do panelu administracji użytkownikami.'
	,1
),
(
	 'teacher'
	,'Uprawnienie nauczyciela'
	,1
),
(
	 'parent'
	,'Uprawnienie opiekuna'
	,1
),
(
	 'student'
	,'Uprawnienie studenta'
	,1
)

INSERT INTO [User].[Roles] (
	 Name
	,Description
	,IsEnabled
)
VALUES (
	 'admin'
	,'Administrator'
	,1
),
(
	 'teacher'
	,'Nauczyciel'
	,1
),
(
	 'parent'
	,'Opiekun'
	,1
),
(
	 'student'
	,'Uczeń'
	,1
)

INSERT INTO [User].[RolePermissions] (
	 RoleId
	,PermissionId
	,CreationTime
	,ModificationTime
	,UserModificatedid
	,IsEnabled
)
VALUES (
	 1
	,1
	,GETDATE()
	,GETDATE()
	,1
	,1
),
(
	 2
	,2
	,GETDATE()
	,GETDATE()
	,1
	,1
),
(
	 3
	,3
	,GETDATE()
	,GETDATE()
	,1
	,1
),
(
	 4
	,4
	,GETDATE()
	,GETDATE()
	,1
	,1
)

INSERT INTO [User].[UserRoles] (
	 UserId
	,RoleId
	,CreationTime
	,ModificationTime
	,UserModificatedId
	,IsEnabled
)
VALUES (
	 1
	,1
	,GETDATE()
	,GETDATE()
	,1
	,1
)
,(
	 1
	,2
	,GETDATE()
	,GETDATE()
	,1
	,1
)
,(
	 2
	,2
	,GETDATE()
	,GETDATE()
	,1
	,1
)
,(
	 4
	,4
	,GETDATE()
	,GETDATE()
	,1
	,1
)
,(
	 5
	,4
	,GETDATE()
	,GETDATE()
	,1
	,1
)
,(
	 6
	,4
	,GETDATE()
	,GETDATE()
	,1
	,1
)
,(
	 3
	,3
	,GETDATE()
	,GETDATE()
	,1
	,1
)

INSERT INTO [User].[Addresses](
	 Place
	,Prefix
	,Street
	,HouseNumber
	,ApartmentNumber
	,PostalCode
	,PostOfficePlace
)
VALUES(
	 'Testowa Mieścina'
	,'ul.'
	,'testowa'
	,'3'
	,'23'
	,'11-111'
	,'testowa'
)
,(
	 'Niedzórz'
	,null
	,null
	,'35'
	,null
	,'06-111'
	,'Niedzbórz'
)
,(
	 'Niedzórz'
	,null
	,null
	,'99'
	,null
	,'06-111'
	,'Niedzbórz'
)
,(
	 'Niedzórz'
	,null
	,null
	,'87'
	,null
	,'06-111'
	,'Niedzbórz'
)

INSERT INTO [User].[UserDetails](
	 UserId
	,FirstName
	,SecondName
	,Surname
	,PESEL
	,ContactNumber
	,AddressId
	,ParentId
	,CreationTime
	,ModificationTime
	,UserModificatedId
	,IsConfirmed
	,IsEnabled
)
VALUES(
	 1
	,'Imię'
	,'DrugieImię'
	,'Nazwisko'
	,'11111111111'
	,'123123123'
	,1
	,null
	,GETDATE()
	,GETDATE()
	,1
	,1
	,1
)
,(
	 2
	,'Paweł'
	,null
	,'Gawarecki'
	,null
	,'515515515'
	,2
	,null
	,GETDATE()
	,GETDATE()
	,1
	,1
	,1
)
,(
	 3
	,'Piotr'
	,'Janusz'
	,'Łęcki'
	,null
	,'888888888'
	,3
	,null
	,GETDATE()
	,GETDATE()
	,1
	,1
	,1
)
,(
	 4
	,'Marcin'
	,null
	,'Łęcki'
	,'12345678902'
	,'456456456'
	,3
	,3
	,GETDATE()
	,GETDATE()
	,1
	,1
	,1
)
,(
	 5
	,'Agnieszka'
	,null
	,'Łęcka'
	,'12345678903'
	,'789789789'
	,3
	,3
	,GETDATE()
	,GETDATE()
	,1
	,1
	,1
)
,(
	 6
	,'Karol'
	,null
	,'Wolski'
	,'12345678904'
	,'132123123'
	,4
	,3
	,GETDATE()
	,GETDATE()
	,1
	,1
	,1
)

INSERT INTO [School].[Classes] (
	 Name
	,MainTeacherId
	,StartYear
)
VALUES (
	 'III A'
	,1
	,2020
)

INSERT INTO [School].[ClassStudents] (
	 UserId
	,ClassId
)
VALUES (
	 4
	,1
)
,(
	 5
	,1
)
,(
	 6
	,1
)