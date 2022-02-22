-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_zasob_historia]
	-- Add the parameters for the stored procedure here
	@p_zasob_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	CONVERT(varchar(10), data_wypoz, 105) AS data_wypoz,
	CONVERT(varchar(10), data_zwrot, 105) AS data_zwrot,
	(SELECT LTRIM(RTRIM(nazwa)) AS nazwa FROM dbo.w2_uzytkownicy WHERE dbo.w2_uzytkownicy.uzytk_id = dbo.w2_wypozyczenia.uzytk_id) AS uzytkownik,
	(SELECT LTRIM(RTRIM(LTRIM(RTRIM(nazwisko)) + ' ' + LTRIM(RTRIM(imie)))) AS nazwa FROM dbo.w2_pracownicy WHERE dbo.w2_pracownicy.pracown_id = dbo.w2_wypozyczenia.pracown_id_wypoz) AS pracownik_wypozyczajacy,
	(SELECT LTRIM(RTRIM(LTRIM(RTRIM(nazwisko)) + ' ' + LTRIM(RTRIM(imie)))) AS nazwa FROM dbo.w2_pracownicy WHERE dbo.w2_pracownicy.pracown_id = dbo.w2_wypozyczenia.pracown_id_zwrot) AS pracownik_zwracajacy,
	
	CASE WHEN (DATEDIFF(dd, data_wypoz, data_zwrot) - limit_czasu) <= 0 THEN
			0
		ELSE 
			(DATEDIFF(dd, data_wypoz, data_zwrot) - limit_czasu)
	END	AS opoznienie
	FROM dbo.w2_wypozyczenia
	WHERE zasob_id = @p_zasob_id
	ORDER BY dbo.w2_wypozyczenia.data_wypoz DESC;
END
