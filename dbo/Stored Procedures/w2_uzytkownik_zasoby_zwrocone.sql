-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownik_zasoby_zwrocone]
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int,
	@p_grupa_id int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	/*SELECT wypoz_id, LTRIM(RTRIM(opis)) AS opis, LTRIM(RTRIM(syg)) AS syg, 
	CONVERT(varchar, data_wypoz, 105) AS data_wypoz2, limit_czasu,
	CONVERT(varchar, data_zwrot, 105) AS data_zwrot2,
	CONVERT(varchar, data_wypoz + limit_czasu, 105) AS data_przewidywana
	FROM dbo.w2_wypozyczenia
	INNER JOIN dbo.w2v_zasoby_syg ON dbo.w2v_zasoby_syg.zasob_id = dbo.w2_wypozyczenia.zasob_id
	WHERE data_zwrot IS NOT NULL AND uzytk_id = @p_uzytk_id
	ORDER BY data_wypoz, data_zwrot;*/

	SELECT wypoz_id, dbo.v_wypozyczenia.opis, autor, syg, numer_inw, k_kreskowy, limit_czasu,	
	CONVERT(varchar, data_wypoz, 105) AS data_wypoz2, limit_czasu,
	CONVERT(varchar, data_zwrot, 105) AS data_zwrot, 
	--CASE WHEN (data_wypoz + limit_czasu > data_zwrot) THEN 1 ELSE 0 END AS przedawnione
	CASE WHEN (data_zwrot - data_wypoz > limit_czasu) THEN 1 ELSE 0 END AS przedawnione
	FROM dbo.v_wypozyczenia	
	WHERE data_zwrot IS NOT NULL AND uzytk_id = @p_uzytk_id AND (grupa_id = @p_grupa_id OR @p_grupa_id = 0)
	ORDER BY data_wypoz, data_zwrot;
END
