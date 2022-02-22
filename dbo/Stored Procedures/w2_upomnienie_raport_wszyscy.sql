-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_upomnienie_raport_wszyscy]
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
	SELECT CAST(ROW_NUMBER() OVER (partition by uzytk_id order by data_wypoz) AS varchar) + '. ' + ISNULL(autor + ' : ', '') + opis AS opis, syg, numer_inw, k_kreskowy, data_wypoz, uzytkownik, pracownik, uzytk_id,
	CONVERT(varchar(10), GETDATE(), 105) AS data, CONVERT(varchar, DATEADD(dd, limit_czasu, dbo.v_wypozyczenia.data_wypoz), 105) termin
	--CASE WHEN CAST(DATEADD(dd, limit_czasu, dbo.v_wypozyczenia.data_wypoz) AS date) < CAST(getdate() AS date) THEN 1 ELSE 0 END AS przedawnione
	FROM dbo.v_wypozyczenia
	WHERE (data_zwrot IS NULL AND CAST(DATEADD(dd, limit_czasu, dbo.v_wypozyczenia.data_wypoz) AS date) < CAST(getdate() AS date))
	AND (@p_isStartDate = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) >= @p_startDate OR (@p_isStartDate = 0))
	AND (@p_isEndDate = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) <= @p_endDate OR (@p_isEndDate = 0))
	ORDER BY data_wypoz;
END
