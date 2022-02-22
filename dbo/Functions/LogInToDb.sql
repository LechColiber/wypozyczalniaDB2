-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	Zwraca 1 gdy nazwa użytkownika i hasło są poprawne.
-- =============================================
create FUNCTION [dbo].[LogInToDb]
(
	-- Add the parameters for the function here
	@p_username varchar(15),
	@p_password varchar(42)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	/*IF EXISTS(SELECT id FROM login WHERE nazwa = @p_username AND haslo = CONVERT(VARCHAR(42), HASHBYTES('MD5', @p_password), 2) AND deleted = 0)
		RETURN 1;
	
	RETURN 0;*/
	RETURN ISNULL((SELECT pracown_id FROM dbo.w2_pracownicy WHERE login = @p_username AND haslo = CONVERT(VARCHAR(42), HASHBYTES('MD5', @p_password), 2) AND deleted = 0), -2);
END

