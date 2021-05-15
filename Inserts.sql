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
),
(
	 1
	,2
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