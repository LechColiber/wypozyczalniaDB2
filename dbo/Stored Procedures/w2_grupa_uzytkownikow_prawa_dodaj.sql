-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_grupa_uzytkownikow_prawa_dodaj]
	-- Add the parameters for the stored procedure here
	@p_grupa_id int,
	@p_prawa_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT 1 FROM dbo.w2_prawa_grupy_u WHERE grupa_id = @p_grupa_id AND prawa_id = @p_prawa_id)
		INSERT INTO dbo.w2_prawa_grupy_u (grupa_id, prawa_id) VALUES (@p_grupa_id, @p_prawa_id);

	INSERT INTO dbo.w2_uprawnienia_u (uzytk_id, prawa_id, data_od, data_do, zablokowane) 
	--VALUES (@p_uzytk_id, @p_prawa_id, @p_data_od, @p_data_do, @p_zablokowane);
	SELECT uzytk_id, @p_prawa_id, GETDATE(), DATEADD(yyyy, 25, GETDATE()), 0
	FROM dbo.w2_uzytkownicy WHERE grupa_id = @p_grupa_id AND data_wyrejestr IS NULL
	AND uzytk_id NOT IN (SELECT uzytk_id FROM dbo.w2_uprawnienia_u WHERE prawa_id = @p_prawa_id);
END
