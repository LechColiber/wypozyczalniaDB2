-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_upomnienie_raport]
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int,
	@p_wypoz_id int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CAST(ROW_NUMBER() OVER (order by data_wypoz) AS varchar) + '. ' + ISNULL(autor + ' : ', '') + opis AS opis, syg, numer_inw, k_kreskowy, data_wypoz, uzytkownik, pracownik,
	CONVERT(varchar(10), GETDATE(), 105) AS data, CONVERT(varchar, DATEADD(dd, limit_czasu, dbo.v_wypozyczenia.data_wypoz), 105) termin
	--CASE WHEN CAST(DATEADD(dd, limit_czasu, dbo.v_wypozyczenia.data_wypoz) AS date) < CAST(getdate() AS date) THEN 1 ELSE 0 END AS przedawnione
	FROM dbo.v_wypozyczenia
	WHERE uzytk_id = @p_uzytk_id 
	--AND (@p_wypoz_id = wypoz_id OR @p_wypoz_id IS NULL OR @p_wypoz_id = -1) AND data_zwrot IS NULL AND CAST(DATEADD(dd, limit_czasu, dbo.v_wypozyczenia.data_wypoz) AS date) < CAST(getdate() AS date) 
	AND (@p_wypoz_id = wypoz_id OR ((@p_wypoz_id IS NULL OR @p_wypoz_id = -1) AND data_zwrot IS NULL AND CAST(DATEADD(dd, limit_czasu, dbo.v_wypozyczenia.data_wypoz) AS date) < CAST(getdate() AS date)))
	ORDER BY data_wypoz;
END
