-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_zasob_zamowienia]
	-- Add the parameters for the stored procedure here
	@p_zasob_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- 0 - oczekuje
	-- 1 - zrealizowany
	-- 2 - rezygnacja
	-- 3 - przygotowane

    -- Insert statements for procedure here
	SELECT 
	CONVERT(varchar(10), data_zamow, 105) AS data_zamow,
	CONVERT(varchar(10), data_realiz, 105) AS data_realiz,
	(SELECT LTRIM(RTRIM(nazwa)) AS nazwa FROM dbo.w2_uzytkownicy WHERE dbo.w2_uzytkownicy.uzytk_id = dbo.w2_zamowienia.uzytk_id) AS uzytkownik,
	(SELECT LTRIM(RTRIM(LTRIM(RTRIM(nazwisko)) + ' ' + LTRIM(RTRIM(imie)))) AS nazwa FROM dbo.w2_pracownicy WHERE dbo.w2_pracownicy.pracown_id = dbo.w2_zamowienia.pracown_id_realiz) AS pracownik,
	CASE 
		WHEN stan_zamow = '0' THEN 'Oczekuje'
		WHEN stan_zamow = '1' THEN 'Zrealizowane'
		WHEN stan_zamow = '2' THEN 'Rezygnacja'
		WHEN stan_zamow = '3' THEN 'Przygotowane'
	END AS stan

	FROM dbo.w2_zamowienia
	WHERE zasob_id = @p_zasob_id
	ORDER BY 
		CASE WHEN stan_zamow = '0' THEN 0 ELSE 1 END,
		dbo.w2_zamowienia.data_zamow DESC;
END
