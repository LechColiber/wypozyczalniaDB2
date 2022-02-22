-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_rewers]
	-- Add the parameters for the stored procedure here
	@p_wypoz_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SELECT LTRIM(RTRIM(opis)) AS opis, LTRIM(RTRIM(autor)) AS autor, LTRIM(RTRIM(syg)) AS syg, CONVERT(varchar(10), data_wypoz, 105) AS data_wypoz, uzytkownik,
	CONVERT(varchar, data_wypoz + limit_czasu, 105) AS data_przewidywana, 	
	(
		(SELECT ISNULL(LTRIM(RTRIM(wart_c)) + CHAR(10), '')
		FROM dbo.w2_konfig 
		WHERE nazwa IN ('biblioteka_nazwa'))
		+
		(SELECT ISNULL(LTRIM(RTRIM(wart_c)) + CHAR(10), '')
		FROM dbo.w2_konfig 
		WHERE nazwa IN ('biblioteka_ulica'))
		+
		(SELECT ISNULL(LTRIM(RTRIM(wart_c)) + ' ', '')
		FROM dbo.w2_konfig 
		WHERE nazwa IN ('biblioteka_miasto'))
		+
		(SELECT ISNULL(LTRIM(RTRIM(wart_c)) + CHAR(10), '')
		FROM dbo.w2_konfig 
		WHERE nazwa IN ('biblioteka_kod'))
		+
		(SELECT ISNULL(LTRIM(RTRIM(wart_c)) + CHAR(10), '')
		FROM dbo.w2_konfig 
		WHERE nazwa IN ('biblioteka_numer_telefonu'))
	) AS biblioteka

	FROM dbo.v_wypozyczenia
	WHERE wypoz_id = @p_wypoz_id;
END
