    USE GradeNet_PROD
    GO
    ------------------------------------
    DROP TABLE [dbo].[Configuration]
    ------------------------------------
    DROP TABLE [Log].[Logs]
    DROP SCHEMA [Log]
    ------------------------------------

    DROP TABLE [School].[Events]
    DROP TABLE [School].[Subjects]
    DROP TABLE [School].[StudentsComments]
    DROP TABLE [School].[Frequency]
    DROP TABLE [School].[PresentTypes]
    DROP TABLE [School].[ClassLessons]
    DROP TABLE [School].[StudentGrades]
    DROP TABLE [School].[Grades]
    DROP TABLE [School].[GradeStyles]
    DROP TABLE [School].[Lessons]
    DROP TABLE [School].[LessonTypes]
    DROP TABLE [School].[ClassStudents]
    DROP TABLE [School].[Classes]

    DROP SCHEMA [School]
    ------------------------------------
    DROP TABLE [User].[UserRoles]
    DROP TABLE [User].[RolePermissions]
    DROP TABLE [User].[Roles]
    DROP TABLE [User].[Permissions]
    DROP TABLE [User].[UserDetails]
    DROP TABLE [User].[Users]
    DROP TABLE [User].[Addresses]

    DROP SCHEMA [User]
    ------------------------------------