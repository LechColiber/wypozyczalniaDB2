-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownik_teleadres_usun]
	-- Add the parameters for the stored procedure here
	@p_teleadres_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM dbo.w2_teleadresy WHERE teleadr_id = @p_teleadres_id;
END
