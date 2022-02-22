-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>a
-- =============================================
create PROCEDURE [dbo].[w2_zasob_przez_sygnatura]
	-- Add the parameters for the stored procedure here
	@p_sygnatura varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT zasob_id
	FROM dbo.w2v_zasoby_syg
	WHERE LTRIM(RTRIM(syg)) = LTRIM(RTRIM(@p_sygnatura));
END
