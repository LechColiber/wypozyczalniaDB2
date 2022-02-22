-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_grupa_uzytkownikow_prawa_usun]
	-- Add the parameters for the stored procedure here
	@p_grupa_id int,
	@p_prawa_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM dbo.w2_prawa_grupy_u WHERE grupa_id = @p_grupa_id AND prawa_id = @p_prawa_id;

	DELETE FROM dbo.w2_uprawnienia_u WHERE prawa_id = @p_prawa_id AND uzytk_id IN
	(
		SELECT uzytk_id
		FROM dbo.w2_uzytkownicy
		WHERE grupa_id = @p_grupa_id
	);
END
