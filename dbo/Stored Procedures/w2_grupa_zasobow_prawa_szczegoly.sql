-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_grupa_zasobow_prawa_szczegoly]
	-- Add the parameters for the stored procedure here
	@p_grupa_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT prawa_id,
	(SELECT LTRIM(RTRIM(nazwa)) AS nazwa FROM dbo.w2_prawa WHERE dbo.w2_prawa.prawa_id = dbo.w2_prawa_grupy_z.prawa_id) AS nazwa
	FROM dbo.w2_prawa_grupy_z
	WHERE grupa_id = @p_grupa_id
	ORDER BY nazwa;
END
