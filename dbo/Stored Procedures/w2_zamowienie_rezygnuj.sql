-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_zamowienie_rezygnuj] 
	-- Add the parameters for the stored procedure here
	@p_zamowienie_id int,
	@p_pracown_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- 0 - oczekuje
	-- 1 - zrealizowane
	-- 2 - rezygnacja
	-- 3 - przygotowane
		 
    -- Insert statements for procedure here
	UPDATE dbo.w2_zamowienia 
		SET 
			pracown_id_realiz = @p_pracown_id, 
			data_realiz = GETDATE(),
			stan_zamow = '2'
	 where zamow_id = @p_zamowienie_id;
END
