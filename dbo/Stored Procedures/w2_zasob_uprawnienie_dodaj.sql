-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_zasob_uprawnienie_dodaj]
	-- Add the parameters for the stored procedure here
	@p_zasob_id int, 
	@p_prawa_id int, 
	@p_data_od datetime, 
	@p_data_do datetime, 
	@p_zablokowane bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.w2_uprawnienia_z (zasob_id, prawa_id, data_od, data_do, zablokowane) VALUES (@p_zasob_id, @p_prawa_id, @p_data_od, @p_data_do, @p_zablokowane);
END
