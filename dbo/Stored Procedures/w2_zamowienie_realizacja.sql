-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_zamowienie_realizacja]
	-- Add the parameters for the stored procedure here
	@p_zamow_id int,
	@p_pracown_id int,
	@wypoz_id int = NULL OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @zasob_id int = (SELECT zasob_id FROM dbo.w2_zamowienia WHERE zamow_id = @p_zamow_id);
	DECLARE @uzytk_id int = (SELECT uzytk_id FROM dbo.w2_zamowienia WHERE zamow_id = @p_zamow_id);
	DECLARE @limit_czasu int = (SELECT dbo.w2_wypozyczenie_limit_czasu(@uzytk_id, @zasob_id));
	DECLARE @now datetime = GETDATE();

	EXEC w2_wypozyczenie @zasob_id, @uzytk_id, @p_pracown_id, @limit_czasu, '', @now, @wypoz_id OUTPUT;

	UPDATE dbo.w2_zamowienia SET pracown_id_realiz = @p_pracown_id, data_realiz = GETDATE(), stan_zamow = '1' 
	WHERE zamow_id = @p_zamow_id;
END
