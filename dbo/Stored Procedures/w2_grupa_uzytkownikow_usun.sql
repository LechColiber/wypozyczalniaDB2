-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_grupa_uzytkownikow_usun]
	-- Add the parameters for the stored procedure here
	@p_grupaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.w2_zamowienia SET grupa_id = NULL WHERE grupa_id = @p_grupaId;
	UPDATE dbo.w2_uzytkownicy SET grupa_id = NULL WHERE grupa_id = @p_grupaId;
	DELETE FROM dbo.w2_prawa_grupy_u WHERE grupa_id = @p_grupaId;	
	DELETE FROM dbo.w2_grupy_u WHERE grupa_id = @p_grupaId;
END
