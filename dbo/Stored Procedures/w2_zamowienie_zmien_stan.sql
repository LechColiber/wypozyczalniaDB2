-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_zamowienie_zmien_stan]
	-- Add the parameters for the stored procedure here
	@p_zamow_id int,
	@p_przygotowane bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.w2_zamowienia 
		SET
			stan_zamow = CASE WHEN @p_przygotowane = 0 THEN '0' ELSE '3' END
	WHERE zamow_id = @p_zamow_id;
END
