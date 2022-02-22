-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_zasob_edytuj]
	-- Add the parameters for the stored procedure here
	@p_zasob_id int,
	@p_limit_czasu int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.w2_zasoby_t SET limit_czas = @p_limit_czasu WHERE zasob_id = @p_zasob_id;
END
