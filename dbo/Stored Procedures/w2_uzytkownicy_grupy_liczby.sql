-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownicy_grupy_liczby]
	-- Add the parameters for the stored procedure here
	@p_posiadajacy_niezwrocone bit

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	(SELECT count(uzytk_id) 
		FROM dbo.w2_uzytkownicy 
		WHERE data_wyrejestr IS NULL
		AND (@p_posiadajacy_niezwrocone = 0 OR (@p_posiadajacy_niezwrocone = 1 AND uzytk_id IN (SELECT uzytk_id FROM dbo.w2_wypozyczenia WHERE data_zwrot IS NULL)))
	) AS liczba_wszystkich,
	(SELECT count(uzytk_id) 
		FROM dbo.w2_uzytkownicy 
		WHERE data_wyrejestr IS NULL AND grupa_id IS NULL
		AND (@p_posiadajacy_niezwrocone = 0 OR (@p_posiadajacy_niezwrocone = 1 AND uzytk_id IN (SELECT uzytk_id FROM dbo.w2_wypozyczenia WHERE data_zwrot IS NULL)))
	) AS bez_grupy
END
