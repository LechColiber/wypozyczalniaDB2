-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_prawa_edytuj]
	-- Add the parameters for the stored procedure here
	@p_nazwa varchar(50),
	@p_stan_domyslny bit,
	@prawa_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.w2_prawa
		SET
			nazwa = @p_nazwa,
			stan_domyslny = @p_stan_domyslny
	WHERE prawa_id = @prawa_id;	
END
