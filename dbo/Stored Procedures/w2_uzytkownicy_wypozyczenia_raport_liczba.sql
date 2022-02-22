-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[w2_uzytkownicy_wypozyczenia_raport_liczba]
	-- Add the parameters for the stored procedure here
	@p_isStartDate bit,
	@p_startDate datetime,
	@p_isEndDate bit,
	@p_endDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT COUNT(*) AS liczba
	FROM dbo.v_wypozyczenia
	WHERE data_zwrot IS NULL
	AND (@p_isStartDate = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) >= @p_startDate OR (@p_isStartDate = 0))
	AND (@p_isEndDate = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) <= @p_endDate OR (@p_isEndDate = 0));	
END
