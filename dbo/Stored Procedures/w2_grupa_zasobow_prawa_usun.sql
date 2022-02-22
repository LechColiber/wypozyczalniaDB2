-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_grupa_zasobow_prawa_usun]
	-- Add the parameters for the stored procedure here
	@p_grupa_id int,
	@p_prawa_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM dbo.w2_prawa_grupy_z WHERE grupa_id = @p_grupa_id AND prawa_id = @p_prawa_id;

	DELETE FROM dbo.w2_uprawnienia_z WHERE prawa_id = @p_prawa_id AND zasob_id IN
	(
		SELECT zasob_id
		FROM dbo.w2_zasoby_t
		WHERE grupa_id = @p_grupa_id
	);
END
