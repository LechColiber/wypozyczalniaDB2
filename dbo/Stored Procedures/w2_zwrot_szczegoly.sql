-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_zwrot_szczegoly]
	-- Add the parameters for the stored procedure here
	@p_wypoz_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT wypoz_id, LTRIM(RTRIM(opis)) AS opis,
	CASE WHEN LTRIM(RTRIM(k_kreskowy)) != 0 THEN LTRIM(RTRIM(k_kreskowy)) ELSE '' END AS kod_kresk, 	
	(SELECT LTRIM(RTRIM(dbo.w2_grupy_z.nazwa)) FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.w2v_zasoby_syg.grupa_id) AS grupa,	
	(SELECT LTRIM(RTRIM(nazwisko)) + ' ' + LTRIM(RTRIM(imie)) FROM dbo.w2_pracownicy WHERE dbo.w2_pracownicy.pracown_id = dbo.w2_wypozyczenia.pracown_id_wypoz) AS wypozyczajacy,
	CONVERT(varchar, data_wypoz, 105) AS data_wypoz, 
	CONVERT(varchar, data_wypoz + w2_wypozyczenia.limit_czasu, 105) AS data_przewidywana,
	(SELECT LTRIM(RTRIM(dbo.w2_uzytkownicy.nazwa)) FROM dbo.w2_uzytkownicy WHERE dbo. w2_uzytkownicy.uzytk_id = dbo.w2_wypozyczenia.uzytk_id) AS uzytkownik
	FROM w2_wypozyczenia
	INNER JOIN w2v_zasoby_syg ON w2v_zasoby_syg.zasob_id = w2_wypozyczenia.zasob_id
	WHERE wypoz_id = @p_wypoz_id;
END
