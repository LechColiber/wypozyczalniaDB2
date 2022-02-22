-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_zasob_przez_numer_inwentarzowy]
	-- Add the parameters for the stored procedure here
	@p_numer_inwentarzowy varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT zasob_id
	FROM dbo.w2v_zasoby_syg
	WHERE LTRIM(RTRIM(numer_inw)) = LTRIM(RTRIM(@p_numer_inwentarzowy));
END
