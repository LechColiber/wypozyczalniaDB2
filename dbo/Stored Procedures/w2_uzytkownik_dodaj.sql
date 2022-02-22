-- =============================================
-- Author:		<Author, , Name>
-- Create date: <Create Date, , >
-- Description:	<Description, , >
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownik_dodaj]
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
	@uzytk_id int OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	INSERT INTO dbo.w2_uzytkownicy (uzytk_id_parent, typuzytk_id, grupa_id, kod_kresk, nazwa, data_urodz, plec, uwagi, limit_czasu, limit_ilosci, zablokowany, nr_legitym, domena_nazwa, dzial)
    VALUES (NULL, @p_typuzytk_id, @p_grupa_id, @p_kod_kresk, @p_nazwa, @p_data_urodz, @p_plec, @p_uwagi, @p_limit_czasu, @p_limit_ilosci, @p_zablokowany, @p_nr_legitym, @p_domena_nazwa, @p_dzial);

	SET @uzytk_id = SCOPE_IDENTITY();
END
