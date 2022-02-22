-- =============================================
-- Author:		Piotr Zawistowski
-- ALTER  date: 20.08.2008
-- Description:	Procedura zwraca raport zwrotów zasobów
-- =============================================
CREATE PROCEDURE [dbo].[w2_zwroty_raport]
	@p_isStartDate bit,
	@p_startDate datetime,
	@p_isEndDate bit,
	@p_endDate datetime
AS
BEGIN

	SET NOCOUNT ON;


	SELECT /*ISNULL(autor, '') AS autor, dbo.v_wypozyczenia.opis AS opis,*/
	ISNULL(autor + ' : ', '') + dbo.v_wypozyczenia.opis AS opis, dbo.v_wypozyczenia.numer_inw, syg,
	CASE WHEN @p_isStartDate = 0 THEN
			(SELECT TOP 1 CONVERT(varchar(10), data_zwrot, 105) FROM dbo.v_wypozyczenia WHERE data_zwrot IS NOT NULL ORDER BY data_zwrot) 
		ELSE
			CONVERT(varchar(10), @p_startDate, 105)
	END AS data_min,

	CASE WHEN @p_isEndDate = 0 THEN
			CONVERT(varchar(10), GETDATE(), 105)
		ELSE
			CONVERT(varchar(10), @p_endDate, 105)
	END AS data_max,
	CONVERT(varchar(10), data_zwrot, 105) AS data_zwrot,
	CONVERT(varchar(10), GETDATE(), 105) AS data_aktualna,
	dbo.w2_zasoby_t.grupa_id, (SELECT UPPER(LTRIM(RTRIM(nazwa))) FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.w2_zasoby_t.grupa_id) AS nazwa_grupy,
	(SELECT sort_order FROM dbo.w2v_zasoby_syg WHERE dbo.w2v_zasoby_syg.zasob_id = dbo.w2_zasoby_t.zasob_id) AS sort_order
	FROM dbo.w2_zasoby_t
	INNER JOIN dbo.v_wypozyczenia ON dbo.v_wypozyczenia.zasob_id = dbo.w2_zasoby_t.zasob_id AND data_zwrot IS NOT NULL
	WHERE deleted = 0 AND wypozyczony = 0 
	AND (@p_isStartDate = 1 AND CAST(dbo.v_wypozyczenia.data_zwrot AS date) >= @p_startDate OR (@p_isStartDate = 0))
	AND (@p_isEndDate = 1 AND CAST(dbo.v_wypozyczenia.data_zwrot AS date) <= @p_endDate OR (@p_isEndDate = 0))
	ORDER BY dbo.v_wypozyczenia.data_zwrot, sort_order, syg_expand;
END
