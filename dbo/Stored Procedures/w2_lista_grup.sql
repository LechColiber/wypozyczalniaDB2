-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_lista_grup]
	-- Add the parameters for the stored procedure here
	@p_withCount bit,
	@p_grupa_id int = NULL,
	@p_posiadajacy_niezwrocone bit = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT grupa_id, 
	LTRIM(RTRIM(nazwa)) + 
		CASE WHEN @p_withCount = 1 THEN 
			' (' + CAST((SELECT count(grupa_id) FROM dbo.w2_uzytkownicy WHERE data_wyrejestr IS NULL AND dbo.w2_uzytkownicy.grupa_id = dbo.w2_grupy_u.grupa_id AND (@p_posiadajacy_niezwrocone = 0 OR (@p_posiadajacy_niezwrocone = 1 AND uzytk_id IN (SELECT uzytk_id FROM dbo.w2_wypozyczenia WHERE data_zwrot IS NULL)))) AS varchar) + ')' 
		ELSE
			''	
		END AS nazwa, 
	limit_czasu, limit_ilosci
	FROM dbo.w2_grupy_u 
	WHERE aktywna = 1 AND (grupa_id = @p_grupa_id OR @p_grupa_id IS NULL)
	ORDER BY nazwa;
END
