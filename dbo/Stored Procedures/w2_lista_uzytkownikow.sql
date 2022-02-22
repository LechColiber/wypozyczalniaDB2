-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_lista_uzytkownikow]
	-- Add the parameters for the stored procedure here
	@p_grupa_id int = -1,
	@p_nazwa_uzytkownika varchar(50) = NULL,
	@p_posiada_niezwrocone bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT uzytk_id, LTRIM(RTRIM(nazwa)) AS nazwa, zablokowany
	FROM dbo.w2_uzytkownicy
	WHERE data_wyrejestr IS NULL AND ((@p_grupa_id IS NULL AND grupa_id IS NULL) OR grupa_id = @p_grupa_id OR @p_grupa_id = -1) AND (nazwa like @p_nazwa_uzytkownika + '%' OR @p_nazwa_uzytkownika IS NULL) 
	AND (@p_posiada_niezwrocone = 0 OR EXISTS(SELECT 1 FROM w2_wypozyczenia WHERE w2_wypozyczenia.uzytk_id = w2_uzytkownicy.uzytk_id AND data_zwrot IS NULL))
	ORDER BY nazwa;
END
