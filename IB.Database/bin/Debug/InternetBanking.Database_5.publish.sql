﻿/*
Deployment script for InternetBanking

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "InternetBanking"
:setvar DefaultFilePrefix "InternetBanking"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"

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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [IBUser]...';


GO
CREATE USER [IBUser] FOR LOGIN [IBLogin];


GO
PRINT N'Creating <unnamed>...';


GO
EXECUTE sp_addrolemember @rolename = N'db_owner', @membername = N'IBUser';


GO
PRINT N'Creating [dbo].[BankAccount]...';


GO
CREATE TABLE [dbo].[BankAccount] (
    [Id]      UNIQUEIDENTIFIER NOT NULL,
    [UserId]  UNIQUEIDENTIFIER NULL,
    [Number]  NUMERIC (20)     NOT NULL,
    [EndDate] DATE             NOT NULL,
    [Active]  BIT              NOT NULL,
    CONSTRAINT [PK_dbo_BankAccount] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK_dbo_BankAccount_Number] UNIQUE NONCLUSTERED ([Number] ASC)
);


GO
PRINT N'Creating [dbo].[BankCard]...';


GO
CREATE TABLE [dbo].[BankCard] (
    [Id]               UNIQUEIDENTIFIER NOT NULL,
    [UserId]           UNIQUEIDENTIFIER NULL,
    [BankAccountId]    UNIQUEIDENTIFIER NULL,
    [Number]           NUMERIC (16)     NOT NULL,
    [VerificationCode] CHAR (32)        NOT NULL,
    [PinCode]          CHAR (32)        NOT NULL,
    [Validity]         DATE             NOT NULL,
    [Active]           BIT              NOT NULL,
    CONSTRAINT [PK_dbo_BankCard] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK_dbo_BankCard_Number] UNIQUE NONCLUSTERED ([Number] ASC)
);


GO
PRINT N'Creating [dbo].[Role]...';


GO
CREATE TABLE [dbo].[Role] (
    [Id]   UNIQUEIDENTIFIER NOT NULL,
    [Name] NVARCHAR (32)    NOT NULL,
    CONSTRAINT [PK_dbo_Role] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK_dbo_Role_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [Id]           UNIQUEIDENTIFIER NOT NULL,
    [Login]        NVARCHAR (128)   NOT NULL,
    [FirstName]    NVARCHAR (128)   NOT NULL,
    [LastName]     NVARCHAR (128)   NOT NULL,
    [Inactive]     BIT              NOT NULL,
    [Email]        NVARCHAR (128)   NOT NULL,
    [PasswordHash] NVARCHAR (128)   NOT NULL,
    [PasswordSalt] NVARCHAR (128)   NOT NULL,
    CONSTRAINT [PK_dbo_User] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK_dbo_User_Email] UNIQUE NONCLUSTERED ([Email] ASC),
    CONSTRAINT [UK_dbo_User_Login] UNIQUE NONCLUSTERED ([Login] ASC)
);


GO
PRINT N'Creating [dbo].[User].[IX_dbo_User_FirstName_LastName]...';


GO
CREATE NONCLUSTERED INDEX [IX_dbo_User_FirstName_LastName]
    ON [dbo].[User]([FirstName] ASC, [LastName] ASC);


GO
PRINT N'Creating [dbo].[UserRole]...';


GO
CREATE TABLE [dbo].[UserRole] (
    [UserId] UNIQUEIDENTIFIER NOT NULL,
    [RoleId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_dbo_RoleUser] PRIMARY KEY CLUSTERED ([RoleId] ASC, [UserId] ASC)
);


GO
PRINT N'Creating [dbo].[FK_dbo_BankAccount_User_Id]...';


GO
ALTER TABLE [dbo].[BankAccount]
    ADD CONSTRAINT [FK_dbo_BankAccount_User_Id] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([Id]);


GO
PRINT N'Creating [dbo].[FK_dbo_BankCard_User_Id]...';


GO
ALTER TABLE [dbo].[BankCard]
    ADD CONSTRAINT [FK_dbo_BankCard_User_Id] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([Id]);


GO
PRINT N'Creating [dbo].[FK_dbo_BankCard_BankAccount_Id]...';


GO
ALTER TABLE [dbo].[BankCard]
    ADD CONSTRAINT [FK_dbo_BankCard_BankAccount_Id] FOREIGN KEY ([BankAccountId]) REFERENCES [dbo].[BankAccount] ([Id]);


GO
PRINT N'Creating [dbo].[FK_dbo_RoleUser_UserId_User_Id]...';


GO
ALTER TABLE [dbo].[UserRole]
    ADD CONSTRAINT [FK_dbo_RoleUser_UserId_User_Id] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_dbo_RoleUser_RoleId_Role_Id]...';


GO
ALTER TABLE [dbo].[UserRole]
    ADD CONSTRAINT [FK_dbo_RoleUser_RoleId_Role_Id] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[CHK_BankAccount_Number_LEN]...';


GO
ALTER TABLE [dbo].[BankAccount]
    ADD CONSTRAINT [CHK_BankAccount_Number_LEN] CHECK (LEN(Number) = 20);


GO
PRINT N'Creating [dbo].[CHK_BankCard_Number_LEN]...';


GO
ALTER TABLE [dbo].[BankCard]
    ADD CONSTRAINT [CHK_BankCard_Number_LEN] CHECK (LEN(Number) = 16);


GO
PRINT N'Creating Permission...';


GO
GRANT CONNECT TO [IBUser];


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
INSERT INTO [dbo].[Role]([Id], [Name])
VALUES
	('122cca70-4224-4e4a-ab8d-c380c9fcf2b5', 'admin'),
	('891a5ff3-409c-44d7-94b7-19af3563e060', 'user');

INSERT INTO [dbo].[User]([Id], [Login], [FirstName], [LastName], [Inactive], [Email], [PasswordHash], [PasswordSalt])
VALUES
	('0a82c892-9ac6-4929-86ea-08fa11e50be3', 'admin', 'admin', 'admin', 0, 'admin.admin@mail.ru', N'柒⍦괟勹ī㉞︂텋�揕퇭͹ꭌ㛿䩕㦓锉䈴邑禅軐麿崨ᓄద❆䤱驥栖ꜻ', N'眡䏿圔쎣穤⸊鉜뷮㑃쮺䭊䧣՜쎫鮯䗎䑙ᷘ攋ᅭ섦楂憢�胔贛Ⴜ槒ᕎ἟铱⭏뇚禎�࠯쥤쓩₳绣䟉଩覟溳'),
	('2803991e-264f-47dd-9614-b4909291e7cc', 'user', 'user', 'user', 0, 'user.user@mail.ru', N'✅Იᐴዲ癷ል늿틂�䤺捞䕮䔎덜ⳡ⋸俓鄴戮퇘㵶젮㎼㔪兔┛ཕ醠͟', N'┿盪￱㖾릛욚錉릗䈶�䯽⦺䄼ꋶ�ꌦꈘⴶ퇗硿㟓묺䓠却颵ᇔ㗘№࢛놐饤埀屒薰㢕׼ℱ麢养踅乛瀵旯䜿');

INSERT INTO [dbo].[UserRole]([UserId], [RoleId])
VALUES
	('0a82c892-9ac6-4929-86ea-08fa11e50be3', '122cca70-4224-4e4a-ab8d-c380c9fcf2b5'),
	('2803991e-264f-47dd-9614-b4909291e7cc', '891a5ff3-409c-44d7-94b7-19af3563e060'),
	('f9629128-cc13-4026-9ef8-8509979cc95a', '891a5ff3-409c-44d7-94b7-19af3563e060'),
	('db6913c5-28cd-4272-a51f-1f4b43c92cb2', '891a5ff3-409c-44d7-94b7-19af3563e060')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
