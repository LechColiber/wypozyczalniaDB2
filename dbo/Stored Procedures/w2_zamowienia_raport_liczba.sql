-- =============================================
-- Author:		Piotr Zawistowski
-- ALTER  date: 20.08.2008
-- Description:	Procedura zwraca raport zamówień zasobów
-- =============================================
create PROCEDURE [dbo].[w2_zamowienia_raport_liczba]
	@p_isStartDate bit,
	@p_startDate datetime,
	@p_isEndDate bit,
	@p_endDate datetime
AS
BEGIN

	SET NOCOUNT ON;

	SELECT COUNT(*) AS liczba
	FROM dbo.w2_zamowienia
	INNER JOIN dbo.w2v_zasoby_syg ON dbo.w2v_zasoby_syg.zasob_id = dbo.w2_zamowienia.zasob_id
	WHERE 
		(@p_isStartDate = 1 AND CAST(dbo.w2_zamowienia.data_zamow AS date) >= @p_startDate OR (@p_isStartDate = 0))
		AND (@p_isEndDate = 1 AND CAST(dbo.w2_zamowienia.data_zamow AS date) <= @p_endDate OR (@p_isEndDate = 0));
END
