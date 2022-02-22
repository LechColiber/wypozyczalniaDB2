-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_wartosc_konfiguracyjna_n_edycja]
	-- Add the parameters for the stored procedure here
	@p_nazwa varchar(50),
	@p_wartosc numeric(18, 0)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT 1 FROM dbo.w2_konfig WHERE nazwa = @p_nazwa)
		INSERT INTO dbo.w2_konfig (nazwa, typ, wart_N) VALUES (@p_nazwa, 'N', @p_wartosc)
	ELSE
		UPDATE dbo.w2_konfig SET wart_N = @p_wartosc WHERE nazwa = @p_nazwa;
END
