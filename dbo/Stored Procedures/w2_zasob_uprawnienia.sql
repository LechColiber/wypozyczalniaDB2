-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_zasob_uprawnienia]
	-- Add the parameters for the stored procedure here
	@p_zasob_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT upraw_id, prawa_id, CONVERT(char(10), data_od, 112) AS data_od, CONVERT(char(10), data_do, 112) AS data_do, zablokowane, LTRIM(RTRIM(Nazwa)) AS nazwa
	FROM dbo.w2v_uprawnienia_z
	WHERE zasob_id = @p_zasob_id
	ORDER BY Nazwa;
END
