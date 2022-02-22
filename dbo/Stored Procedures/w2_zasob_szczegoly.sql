-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_zasob_szczegoly]
	-- Add the parameters for the stored procedure here
	@p_zasob_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT zasob_id, LTRIM(RTRIM(opis)) AS opis, limit_czas, wypozyczony, uwagi, numer_inw, grupa_id,
	CASE WHEN LTRIM(RTRIM(kod_kresk)) = '0' THEN '' ELSE kod_kresk END AS kod_kresk,
	(SELECT LTRIM(RTRIM(nazwa)) FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.w2_zasoby_t.grupa_id) AS grupa
	FROM dbo.w2_zasoby_t
	WHERE zasob_id = @p_zasob_id;
END
