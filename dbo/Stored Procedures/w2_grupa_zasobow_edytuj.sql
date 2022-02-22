-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_grupa_zasobow_edytuj]
	-- Add the parameters for the stored procedure here
	@p_nazwa varchar(50),
	@p_uwagi text,
	@p_aktywna bit,
	@p_limit_czasu smallint,
	@p_grupa_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.w2_grupy_z
		SET
			nazwa = @p_nazwa,
			uwagi = @p_uwagi,
			aktywna = @p_aktywna,
			limit_czasu = @p_limit_czasu
	WHERE grupa_id = @p_grupa_id;
END
