-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownik_zasoby_niezwrocone]
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int,
	@p_grupa_id int = 0,
	@p_order_asc bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT wypoz_id, dbo.v_wypozyczenia.opis, autor, syg, numer_inw, k_kreskowy, limit_czasu,	
	CONVERT(varchar, data_wypoz, 105) AS data_wypoz2, limit_czasu,
	CONVERT(varchar, data_wypoz + limit_czasu, 105) AS data_przewidywana, 	
	CASE WHEN CAST(DATEADD(dd, limit_czasu, dbo.v_wypozyczenia.data_wypoz) AS date) < CAST(getdate() AS date) THEN 1 ELSE 0 END AS przedawnione
	FROM dbo.v_wypozyczenia	
	WHERE data_zwrot IS NULL AND uzytk_id = @p_uzytk_id AND (grupa_id = @p_grupa_id OR @p_grupa_id = 0)
	ORDER BY		 
		 CASE WHEN @p_order_asc = 1 THEN CAST(dbo.v_wypozyczenia.data_wypoz AS date) END ASC,
		 CASE WHEN @p_order_asc = 0 THEN CAST(dbo.v_wypozyczenia.data_wypoz AS date) END DESC,
		 wypoz_id DESC;
END
