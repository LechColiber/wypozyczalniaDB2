-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownik_teleadres_dodaj]
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int,	
	@p_typteleadr_id int,
	@p_wartosc varchar(80),
	@p_stan char(1),
	@p_pracown_id_wpr int,
	@p_uwagi varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.w2_teleadresy (uzytk_id, typteleadr_id, wartosc, stan, data_wprow, pracown_id_wpr, uwagi)
    VALUES (@p_uzytk_id, @p_typteleadr_id, @p_wartosc, @p_stan, GETDATE(), @p_pracown_id_wpr, @p_uwagi);
END
