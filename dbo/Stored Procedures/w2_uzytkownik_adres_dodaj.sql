-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownik_adres_dodaj]
	-- Add the parameters for the stored procedure here
	@p_uzytk_id int, 
	@p_typadr_id int, 
	@p_miejscowosc varchar(40), 
	@p_ulica varchar(30), 
	@p_nr_domu varchar(6),
	@p_nr_lokalu varchar(6), 
	@p_kod_poczt char(5), 
	@p_poczta varchar(40), 
	@p_stan char(1), 
	@p_pracown_id_wpr int, 
	@p_uwagi text
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.w2_adresy (uzytk_id, typadr_id, miejscowosc, ulica, nr_domu, nr_lokalu, kod_poczt, poczta, stan, pracown_id_wpr, uwagi)
    VALUES (@p_uzytk_id, @p_typadr_id, @p_miejscowosc, @p_ulica, @p_nr_domu, @p_nr_lokalu, @p_kod_poczt, @p_poczta, @p_stan, @p_pracown_id_wpr, @p_uwagi);
END