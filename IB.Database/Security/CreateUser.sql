CREATE USER [IBUser] FOR LOGIN [IBLogin];
GO

GRANT CONNECT TO [IBUser];
GO

EXEC sp_addrolemember N'db_owner', N'IBUser'
GO
                                                                                       