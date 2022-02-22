-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_raport_uzytkownikow]
	-- Add the parameters for the stored procedure here
	@p_grupa_id int,
	@p_typ_uzytk int,
	@p_tylko_aktywni bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT LTRIM(RTRIM(nazwa)) AS uzytkownik,
	(SELECT LTRIM(RTRIM(nazwa)) FROM dbo.w2_grupy_u WHERE dbo.w2_grupy_u.grupa_id = dbo.w2_uzytkownicy.grupa_id) AS grupa, grupa_id,
	typuzytk_id,
	(SELECT LTRIM(RTRIM(nazwa)) FROM dbo.w2_typy_uzytk WHERE dbo.w2_typy_uzytk.typuzytk_id = dbo.w2_uzytkownicy.typuzytk_id) AS typ_uzytkownika,
	CONVERT(varchar(10), GETDATE(), 105) AS data
	FROM dbo.w2_uzytkownicy
	WHERE (@p_grupa_id = -1 OR @p_grupa_id = grupa_id) AND (@p_typ_uzytk = -1 OR @p_typ_uzytk = typuzytk_id) AND (@p_tylko_aktywni = 0 OR (@p_tylko_aktywni = 1 AND data_wyrejestr IS NULL))
	ORDER BY uzytkownik;

END
