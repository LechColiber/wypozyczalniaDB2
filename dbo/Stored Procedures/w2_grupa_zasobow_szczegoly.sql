-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_grupa_zasobow_szczegoly] 
	-- Add the parameters for the stored procedure here		
	@p_grupaId int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT grupa_id, LTRIM(RTRIM(nazwa)) AS nazwa, uwagi, aktywna, limit_czasu
	FROM dbo.w2_grupy_z
	WHERE (@p_grupaId = grupa_id OR @p_grupaId IS NULL)
	ORDER BY nazwa;
END
