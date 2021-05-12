INSERT INTO [User].[Users] (
	 Email
	,Password
	,CreationTime
	,ModificationTime
	,UserModificated
	,LastSuccessfulLogin
	,IsEnabled
	)
VALUES (
	 'admin@admin.pl'
	,CONVERT(VARCHAR(32), HashBytes('MD5', 'admin'), 2)
	,GETDATE()
	,GETDATE()
	,1
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
	,'Rola nauczyciela'
	,1
),
(
	 'parent'
	,'Rola opiekuna'
	,1
),
(
	 'student'
	,'Rola studenta'
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
	,UserModificated
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
	,UserModificated
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

INSERT INTO [User].[UserDetails](
	 UserId
	,FirstName
	,SecondName
	,Surname
	,ContactNumber
	,PESEL
	,ParentId
	,AddressId
	,IsConfirmed
)
VALUES(
	 1
	,'Imię'
	,'DrugieImię'
	,'Nazwisko'
	,'111111111'
	,'12121212121'
	,NULL
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