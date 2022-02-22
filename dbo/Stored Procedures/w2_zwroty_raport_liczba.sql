-- =============================================
-- Author:		Piotr Zawistowski
-- ALTER  date: 20.08.2008
-- Description:	Procedura zwraca raport zwrotów zasobów
-- =============================================
create PROCEDURE [dbo].[w2_zwroty_raport_liczba]
	@p_isStartDate bit,
	@p_startDate datetime,
	@p_isEndDate bit,
	@p_endDate datetime
AS
BEGIN

	SET NOCOUNT ON;


	SELECT COUNT(*) AS liczba
	FROM dbo.w2_zasoby_t
	INNER JOIN dbo.v_wypozyczenia ON dbo.v_wypozyczenia.zasob_id = dbo.w2_zasoby_t.zasob_id AND data_zwrot IS NOT NULL
	WHERE deleted = 0 AND wypozyczony = 0 
	AND (@p_isStartDate = 1 AND CAST(dbo.v_wypozyczenia.data_zwrot AS date) >= @p_startDate OR (@p_isStartDate = 0))
	AND (@p_isEndDate = 1 AND CAST(dbo.v_wypozyczenia.data_zwrot AS date) <= @p_endDate OR (@p_isEndDate = 0));
END
