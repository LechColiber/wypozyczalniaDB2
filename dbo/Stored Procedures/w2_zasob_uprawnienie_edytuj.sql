-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_zasob_uprawnienie_edytuj]
	-- Add the parameters for the stored procedure here
	@p_data_od datetime, 
	@p_data_do datetime, 
	@p_zablokowane bit,
	@p_uprawnienie_id uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.w2_uprawnienia_z SET data_od = @p_data_od, data_do = @p_data_do, zablokowane = @p_zablokowane
	WHERE upraw_id = @p_uprawnienie_id;
END
