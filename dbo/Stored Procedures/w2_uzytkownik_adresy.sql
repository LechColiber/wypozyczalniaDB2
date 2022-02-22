-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownik_adresy]
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT adres_id, typadr_id, LTRIM(RTRIM(miejscowosc)) AS miejscowosc, LTRIM(RTRIM(ulica)) AS ulica, 
	LTRIM(RTRIM(nr_domu)) AS nr_domu, LTRIM(RTRIM(nr_lokalu)) AS nr_lokalu, LTRIM(RTRIM(kod_poczt)) AS kod_poczt, stan, uwagi,
	(SELECT LTRIM(RTRIM(nazwa)) FROM dbo.w2_typy_adresu WHERE w2_typy_adresu.typadr_id = w2_adresy.typadr_id) AS typ_slownie, 
	LTRIM(RTRIM(poczta)) AS poczta
	FROM dbo.w2_adresy
	WHERE uzytk_id = @p_uzytk_id;
END

