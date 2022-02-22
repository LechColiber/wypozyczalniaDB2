-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_prawa_dodaj]
	-- Add the parameters for the stored procedure here
	@p_nazwa varchar(50),
	@p_stan_domyslny bit,
	@prawa_id int = NULL OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.w2_prawa (nazwa, stan_domyslny) VALUES (@p_nazwa, @p_stan_domyslny);

	SET @prawa_id = SCOPE_IDENTITY();
END
