-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_raport_uzytkownikow_liczba]
	-- Add the parameters for the stored procedure here
	@p_grupa_id int,
	@p_typ_uzytk int,
	@p_tylko_aktywni bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT COUNT(*) AS liczba
	FROM dbo.w2_uzytkownicy
	WHERE (@p_grupa_id = -1 OR @p_grupa_id = grupa_id) AND (@p_typ_uzytk = -1 OR @p_typ_uzytk = typuzytk_id) AND (@p_tylko_aktywni = 0 OR (@p_tylko_aktywni = 1 AND data_wyrejestr IS NULL));
END
