-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownicy_podpowiedzi]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT LTRIM(RTRIM(nazwa)) AS nazwa
	FROM dbo.w2_uzytkownicy
	WHERE data_wyrejestr IS NULL
	ORDER BY nazwa;
END
