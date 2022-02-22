-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownik_zamowienia]
	-- Add the parameters for the stored procedure here
	@p_uzytk int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT zamow_id, opis, autor, numer_inw, syg, dbo.w2_zamowienia.zasob_id, uwagi,
	CONVERT(varchar(10), data_zamow, 105) AS data_zamow,
	CASE 
		WHEN stan_zamow = '0' THEN 'Oczekuje'
		WHEN stan_zamow = '1' THEN 'Zrealizowane'
		WHEN stan_zamow = '2' THEN 'Rezygnacja'
		WHEN stan_zamow = '3' THEN 'Przygotowane'
	END AS stan
	FROM dbo.w2_zamowienia
	INNER JOIN dbo.w2v_zasoby_syg ON dbo.w2v_zasoby_syg.zasob_id = dbo.w2_zamowienia.zasob_id
	WHERE stan_zamow IN ('0', '3') AND uzytk_id = @p_uzytk
	ORDER BY dbo.w2_zamowienia.data_zamow;
END
