-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownik_z_nazwa_domenowa]
	-- Add the parameters for the stored procedure here
	@p_nazwa_domenowa varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT uzytk_id, LTRIM(RTRIM(nazwa)) AS uzytkownik
	FROM dbo.w2_uzytkownicy
	WHERE LTRIM(RTRIM(domena_nazwa)) = LTRIM(RTRIM(@p_nazwa_domenowa)) ;
END
