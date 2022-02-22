-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownik_szczegoly]
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT typuzytk_id, grupa_id, LTRIM(RTRIM(kod_kresk)) AS kod_kresk, LTRIM(RTRIM(nazwa)) AS nazwa, 
	data_urodz, plec, uwagi, limit_czasu, limit_ilosci, zablokowany, LTRIM(RTRIM(nr_legitym)) AS nr_legitym, 
	LTRIM(RTRIM(domena_nazwa)) AS domena_nazwa, LTRIM(RTRIM(dzial)) AS dzial,
	CASE WHEN data_wyrejestr IS NOT NULL THEN 1 ELSE 0 END AS usuniety
	FROM dbo.w2_uzytkownicy
	WHERE uzytk_id = @p_uzytk_id;
END
