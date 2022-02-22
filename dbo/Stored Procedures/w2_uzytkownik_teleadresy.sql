-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownik_teleadresy]
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT teleadr_id, typteleadr_id, LTRIM(RTRIM(wartosc)) AS wartosc,
	stan, uwagi,
	(SELECT LTRIM(RTRIM(nazwa)) FROM dbo.w2_typy_teleadresu WHERE dbo.w2_typy_teleadresu.typteleadr_id = dbo.w2_teleadresy.typteleadr_id) AS typ_slownie
	FROM dbo.w2_teleadresy
	WHERE uzytk_id = @p_uzytk_id;
END
