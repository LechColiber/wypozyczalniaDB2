-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_zamowienia_ilosc]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT COUNT(*) AS ilosc
	FROM dbo.w2_zamowienia
	WHERE stan_zamow IN ('0', '3') AND uzytk_id IN (SELECT uzytk_id FROM dbo.w2_uzytkownicy WHERE data_wyrejestr IS NULL);
END
