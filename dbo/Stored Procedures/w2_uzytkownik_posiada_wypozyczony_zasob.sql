-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE w2_uzytkownik_posiada_wypozyczony_zasob
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int,
	@p_zasob_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS (SELECT 1 FROM dbo.w2_wypozyczenia WHERE uzytk_id = @p_uzytk_id AND zasob_id = @p_zasob_id AND data_zwrot IS NULL)
		SELECT 1 AS rezultat;
	ELSE
		SELECT 0 AS rezultat;
END
