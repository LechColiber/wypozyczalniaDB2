-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownik_wypozyczenia_raport]
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT /*CAST(ROW_NUMBER() OVER (order by data_wypoz) AS varchar) + '. ' + */
	ISNULL(autor + ' : ', '') + opis AS opis, numer_inw, syg, uzytkownik,
	(SELECT TOP 1 CONVERT(varchar(10), data_wypoz, 105) FROM dbo.v_wypozyczenia WHERE uzytk_id = @p_uzytk_id AND data_zwrot IS NOT NULL) AS data_min,	
	CONVERT(varchar(10), data_wypoz, 105) AS data_wypoz,
	CONVERT(varchar(10), GETDATE(), 105) AS data_aktualna, CONVERT(varchar, DATEADD(dd, limit_czasu, dbo.v_wypozyczenia.data_wypoz), 105) termin,
	grupa_id, (SELECT UPPER(LTRIM(RTRIM(nazwa))) FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.v_wypozyczenia.grupa_id) AS nazwa_grupy
	FROM dbo.v_wypozyczenia
	WHERE uzytk_id = @p_uzytk_id AND data_zwrot IS NULL
	ORDER BY grupa_id, dbo.v_wypozyczenia.data_wypoz;
END
