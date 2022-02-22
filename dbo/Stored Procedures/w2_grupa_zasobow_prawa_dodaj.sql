-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_grupa_zasobow_prawa_dodaj]
	-- Add the parameters for the stored procedure here
	@p_grupa_id int,
	@p_prawa_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT 1 FROM dbo.w2_prawa_grupy_z WHERE grupa_id = @p_grupa_id AND prawa_id = @p_prawa_id)
		INSERT INTO dbo.w2_prawa_grupy_z (grupa_id, prawa_id) VALUES (@p_grupa_id, @p_prawa_id);

	INSERT INTO dbo.w2_uprawnienia_z (zasob_id, prawa_id, data_od, data_do, zablokowane) 	
	SELECT zasob_id, @p_prawa_id, GETDATE(), DATEADD(yyyy, 25, GETDATE()), 0
	FROM dbo.w2_zasoby_t WHERE grupa_id = @p_grupa_id AND deleted = 0 
	AND zasob_id NOT IN (SELECT zasob_id FROM dbo.w2_uprawnienia_z WHERE prawa_id = @p_prawa_id);
END
