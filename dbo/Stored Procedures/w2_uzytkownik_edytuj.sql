-- =============================================
-- Author:		<Author, , Name>
-- Create date: <Create Date, , >
-- Description:	<Description, , >
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownik_edytuj]
	-- Add the parameters for the stored procedure here
	@p_typuzytk_id int,
	@p_grupa_id int,
	@p_kod_kresk varchar(25),
	@p_nazwa varchar(50),
	@p_data_urodz datetime,
	@p_plec bit,
	@p_uwagi text,
	@p_limit_czasu smallint,
	@p_limit_ilosci smallint,
	@p_zablokowany bit,
	@p_nr_legitym varchar(15),
	@p_domena_nazwa varchar(50),
	@p_dzial varchar(100),
	@p_uzytk_id int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	UPDATE dbo.w2_uzytkownicy SET typuzytk_id = @p_typuzytk_id, grupa_id = @p_grupa_id, kod_kresk = @p_kod_kresk, nazwa = @p_nazwa, data_urodz = @p_data_urodz, plec = @p_plec, uwagi = @p_uwagi,
	limit_czasu = @p_limit_czasu, limit_ilosci = @p_limit_ilosci, zablokowany = @p_zablokowany,	nr_legitym = @p_nr_legitym, domena_nazwa = @p_domena_nazwa, dzial = @p_dzial	
	WHERE uzytk_id = @p_uzytk_id;
END
