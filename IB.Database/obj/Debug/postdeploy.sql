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

INSERT INTO [dbo].[User]([Id], [Login], [FirstName], [LastName], [Inactive], [Email], [IsEmailConfirmed], [PasswordHash], [PasswordSalt])
VALUES
	('db6913c5-28cd-4272-a51f-1f4b43c92cb2', 'Daniil97', 'Daniil', 'Boyko', 0, 'daniil.boyko.2000.@mail.ru', 0, 'asdfa', 'asdf'),
	('f9629128-cc13-4026-9ef8-8509979cc95a', 'Kostya21', 'Kostya', 'Trush', 1, 'kostya.trush.1999.@mail.ru', 0, 'asdfa', 'asdf'),
	('0a82c892-9ac6-4929-86ea-08fa11e50be3', 'admin', 'admin', 'admin', 0, 'admin.admin@mail.ru', 0, N'柒⍦괟勹ī㉞︂텋�揕퇭͹ꭌ㛿䩕㦓锉䈴邑禅軐麿崨ᓄద❆䤱驥栖ꜻ', N'眡䏿圔쎣穤⸊鉜뷮㑃쮺䭊䧣՜쎫鮯䗎䑙ᷘ攋ᅭ섦楂憢�胔贛Ⴜ槒ᕎ἟铱⭏뇚禎�࠯쥤쓩₳绣䟉଩覟溳'),
	('2803991e-264f-47dd-9614-b4909291e7cc', 'user', 'user', 'user', 0, 'user.user@mail.ru', 0, N'✅Იᐴዲ癷ል늿틂�䤺捞䕮䔎덜ⳡ⋸俓鄴戮퇘㵶젮㎼㔪兔┛ཕ醠͟', N'┿盪￱㖾릛욚錉릗䈶�䯽⦺䄼ꋶ�ꌦꈘⴶ퇗硿㟓묺䓠却颵ᇔ㗘№࢛놐饤埀屒薰㢕׼ℱ麢养踅乛瀵旯䜿');

INSERT INTO [dbo].[UserRole]([UserId], [RoleId])
VALUES
	('0a82c892-9ac6-4929-86ea-08fa11e50be3', '122cca70-4224-4e4a-ab8d-c380c9fcf2b5'),
	('2803991e-264f-47dd-9614-b4909291e7cc', '891a5ff3-409c-44d7-94b7-19af3563e060'),
	('f9629128-cc13-4026-9ef8-8509979cc95a', '891a5ff3-409c-44d7-94b7-19af3563e060'),
	('db6913c5-28cd-4272-a51f-1f4b43c92cb2', '891a5ff3-409c-44d7-94b7-19af3563e060')

INSERT INTO [dbo].[Permission] ([Id], [Name], [Description])
VALUES
    (1, 'Add Bank Account', NULL),
    (2, 'Get Users', NULL),
    (3, 'Admin Functionality', NULL)

INSERT INTO [dbo].[UserPermission] ([UserId], [PermissionId])
VALUES
    ('0a82c892-9ac6-4929-86ea-08fa11e50be3', 1),
    ('0a82c892-9ac6-4929-86ea-08fa11e50be3', 2),
    ('0a82c892-9ac6-4929-86ea-08fa11e50be3', 3)

INSERT INTO [dbo].[BankAccount] ([Id], [UserId], [Number], [Money], [EndDate], [Active])
VALUES
	('5db58cf4-d54c-4341-bfe9-446fb09581b5', '2803991e-264f-47dd-9614-b4909291e7cc', 543268975346875437, 120, '20190701', 1)

INSERT INTO [dbo].[BankCard] ([Id], [UserId], [BankAccountId], [Number], [VerificationCode], [PinCode], [Validity], [Active])
VALUES
	('0920ec93-794b-4f4c-85ac-8551f05cb47b', '2803991e-264f-47dd-9614-b4909291e7cc', '5db58cf4-d54c-4341-bfe9-446fb09581b5', 
			4325623457850856, N'칮핏섛鐓鈦絣䮝\u0e86', N'귾⸅�ㇻ鯄酪�⓭', '20190601', 1)

GO
