-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_grupa_zasobow_dodaj] 
	-- Add the parameters for the stored procedure here
	@p_nazwa varchar(50),
	@p_uwagi text,
	@p_aktywna bit,
	@p_limit_czasu smallint,
	@grupa_id int = NULL output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.w2_grupy_z (nazwa, uwagi, aktywna, limit_czasu)
	VALUES (@p_nazwa, @p_uwagi, @p_aktywna, @p_limit_czasu);

	SET @grupa_id = SCOPE_IDENTITY();
END
