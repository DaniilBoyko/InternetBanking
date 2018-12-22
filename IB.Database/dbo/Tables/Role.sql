﻿CREATE TABLE [dbo].[Role]
(
    [Id] UNIQUEIDENTIFIER CONSTRAINT [PK_dbo_Role] PRIMARY KEY,
    [Name] NVARCHAR(32) NOT NULL CONSTRAINT [UK_dbo_Role_Name] UNIQUE
)