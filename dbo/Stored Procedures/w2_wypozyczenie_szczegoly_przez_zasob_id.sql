-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_wypozyczenie_szczegoly_przez_zasob_id]
	-- Add the parameters for the stored procedure here
	@p_zasob_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT wypoz_id, 
	(SELECT LTRIM(RTRIM(dbo.w2_uzytkownicy.nazwa)) FROM dbo.w2_uzytkownicy WHERE dbo. w2_uzytkownicy.uzytk_id = dbo.w2_wypozyczenia.uzytk_id) AS uzytkownik
	FROM dbo.w2_wypozyczenia
	INNER JOIN w2v_zasoby_syg ON w2v_zasoby_syg.zasob_id = w2_wypozyczenia.zasob_id
	WHERE dbo.w2_wypozyczenia.zasob_id = @p_zasob_id AND data_zwrot IS NULL;
END
