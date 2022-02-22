-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_lista_typow_teleadresu] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT typteleadr_id, LTRIM(RTRIM(nazwa)) AS nazwa
	FROM dbo.w2_typy_teleadresu
	ORDER BY nazwa;
END
