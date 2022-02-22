-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownicy_wypozyczenia_raport]
	-- Add the parameters for the stored procedure here
	@p_isStartDate bit,
	@p_startDate datetime,
	@p_isEndDate bit,
	@p_endDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT /*CAST(ROW_NUMBER() OVER (order by data_wypoz) AS varchar) + '. ' + */
	ISNULL(autor + ' : ', '') + opis AS opis, numer_inw, syg, uzytkownik,
	CASE WHEN @p_isStartDate = 0 THEN
		(SELECT TOP 1 CONVERT(varchar(10), data_wypoz, 105) FROM dbo.v_wypozyczenia WHERE uzytk_id = dbo.v_wypozyczenia.uzytk_id AND data_zwrot IS NOT NULL ORDER BY data_wypoz) 
	ELSE
		CONVERT(varchar(10), @p_startDate, 105)
	END AS data_min,

	CASE WHEN @p_isEndDate = 0 THEN
			CONVERT(varchar(10), GETDATE(), 105)
		ELSE
			CONVERT(varchar(10), @p_endDate, 105)
	END AS data_max,
	CONVERT(varchar(10), data_wypoz, 105) AS data_wypoz,
	CONVERT(varchar(10), GETDATE(), 105) AS data_aktualna, CONVERT(varchar, DATEADD(dd, limit_czasu, dbo.v_wypozyczenia.data_wypoz), 105) termin,
	grupa_id, (SELECT UPPER(LTRIM(RTRIM(nazwa))) FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.v_wypozyczenia.grupa_id) AS nazwa_grupy
	--,(SELECT COUNT(*) FROM dbo.v_wypozyczenia w WHERE w.uzytk_id = dbo.v_wypozyczenia.uzytk_id AND data_zwrot IS NULL)
	FROM dbo.v_wypozyczenia
	WHERE data_zwrot IS NULL
	AND (@p_isStartDate = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) >= @p_startDate OR (@p_isStartDate = 0))
	AND (@p_isEndDate = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) <= @p_endDate OR (@p_isEndDate = 0))
	ORDER BY grupa_id, dbo.v_wypozyczenia.data_wypoz;
END
