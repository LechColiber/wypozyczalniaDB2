-- =============================================
-- Author:		Piotr Zawistowski
-- ALTER  date: 20.08.2008
-- Description:	Procedura zwraca raport zamówień zasobów
-- =============================================
CREATE PROCEDURE [dbo].[w2_zamowienia_raport]
	@p_isStartDate bit,
	@p_startDate datetime,
	@p_isEndDate bit,
	@p_endDate datetime
AS
BEGIN

	SET NOCOUNT ON;

	SELECT ISNULL(autor + ' : ', '') + dbo.w2v_zasoby_syg.opis AS opis, dbo.w2v_zasoby_syg.numer_inw, syg,
	CASE WHEN @p_isStartDate = 0 THEN
			(SELECT TOP 1 CONVERT(varchar(10), data_zamow, 105) FROM dbo.w2_zamowienia ORDER BY data_zamow) 
		ELSE
			CONVERT(varchar(10), @p_startDate, 105)
	END AS data_min,

	CASE WHEN @p_isEndDate = 0 THEN
			CONVERT(varchar(10), GETDATE(), 105)
		ELSE
			CONVERT(varchar(10), @p_endDate, 105)
	END AS data_max,
	CONVERT(varchar(10), data_zamow, 105) AS data_zamow,
	CONVERT(varchar(10), GETDATE(), 105) AS data_aktualna,
	stan_zamow,
	dbo.w2v_zasoby_syg.grupa_id,
	(SELECT UPPER(LTRIM(RTRIM(nazwa))) FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.w2v_zasoby_syg.grupa_id) AS nazwa_grupy,
	CASE 
		WHEN stan_zamow = '0' THEN 'Oczekuje'
		WHEN stan_zamow = '1' THEN 'Zrealizowane'
		WHEN stan_zamow = '2' THEN 'Rezygnacja'
		WHEN stan_zamow = '3' THEN 'Przygotowane'
	END AS stan
	FROM dbo.w2_zamowienia
	INNER JOIN dbo.w2v_zasoby_syg ON dbo.w2v_zasoby_syg.zasob_id = dbo.w2_zamowienia.zasob_id
	WHERE 
		(@p_isStartDate = 1 AND CAST(dbo.w2_zamowienia.data_zamow AS date) >= @p_startDate OR (@p_isStartDate = 0))
		AND (@p_isEndDate = 1 AND CAST(dbo.w2_zamowienia.data_zamow AS date) <= @p_endDate OR (@p_isEndDate = 0))
	ORDER BY dbo.w2_zamowienia.data_zamow;
END
