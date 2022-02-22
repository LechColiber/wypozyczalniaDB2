-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_wartosc_konfiguracyjna_c_edycja]
	-- Add the parameters for the stored procedure here
	@p_nazwa varchar(50),
	@p_wartosc varchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT 1 FROM dbo.w2_konfig WHERE nazwa = @p_nazwa)
		INSERT INTO dbo.w2_konfig (nazwa, typ, wart_C) VALUES (@p_nazwa, 'C', @p_wartosc)
	ELSE
		UPDATE dbo.w2_konfig SET wart_C = @p_wartosc WHERE nazwa = @p_nazwa;
END
