-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownik_przez_kod_kreskowy]
	-- Add the parameters for the stored procedure here
	@p_k_kreskowy varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT uzytk_id
	FROM dbo.w2_uzytkownicy
	WHERE LTRIM(RTRIM(kod_kresk)) = LTRIM(RTRIM(@p_k_kreskowy));
END
