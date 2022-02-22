-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownik_wyrejestruj]
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.w2_uzytkownicy SET data_wyrejestr = GETDATE(), domena_nazwa = NULL
	WHERE uzytk_id = @p_uzytk_id;

	UPDATE dbo.w2_zamowienia 
		SET 			
			data_realiz = GETDATE(),
			stan_zamow = '2'
	 where uzytk_id = @p_uzytk_id;
END
