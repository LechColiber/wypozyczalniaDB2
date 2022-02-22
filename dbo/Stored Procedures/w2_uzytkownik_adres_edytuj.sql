-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownik_adres_edytuj]
	-- Add the parameters for the stored procedure here
	@p_typadr_id int, 
	@p_miejscowosc varchar(40), 
	@p_ulica varchar(30), 
	@p_nr_domu varchar(6),
	@p_nr_lokalu varchar(6), 
	@p_kod_poczt char(5), 
	@p_poczta varchar(40), 
	@p_stan char(1), 
	@p_uwagi text,
	@p_adres_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.w2_adresy SET typadr_id = @p_typadr_id, miejscowosc = @p_miejscowosc, ulica = @p_ulica, nr_domu = @p_nr_domu, nr_lokalu = @p_nr_lokalu, kod_poczt = @p_kod_poczt, poczta = @p_poczta, stan = @p_stan, uwagi = @p_uwagi
	WHERE adres_id = @p_adres_id;
END
