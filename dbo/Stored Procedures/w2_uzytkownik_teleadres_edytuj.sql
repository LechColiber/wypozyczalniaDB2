-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownik_teleadres_edytuj]
	-- Add the parameters for the stored procedure here
	@p_teleadr_id int,	
	@p_typteleadr_id int,
	@p_wartosc varchar(80),
	@p_stan char(1),
	@p_uwagi varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.w2_teleadresy 
		SET
			typteleadr_id = @p_typteleadr_id,
			wartosc = @p_wartosc,
			stan = @p_stan, 
			uwagi = @p_uwagi
	WHERE teleadr_id = @p_teleadr_id;
END
