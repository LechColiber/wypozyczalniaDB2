-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_zasoby_raport_liczba] 
	-- Add the parameters for the stored procedure here
	@p_isStartDate bit,
	@p_startDate datetime,
	@p_isEndDate bit,
	@p_endDate datetime,
	@p_group_id int,
	@p_state int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		(SELECT COUNT(*)
		FROM dbo.w2v_zasoby_syg
		INNER JOIN dbo.v_wypozyczenia ON dbo.v_wypozyczenia.zasob_id = dbo.w2v_zasoby_syg.zasob_id AND data_zwrot IS NULL
		WHERE wypozyczony = 1 AND (@p_group_id = -1 OR dbo.w2v_zasoby_syg.grupa_id = @p_group_id) AND (@p_state = 1 OR @p_state = -1)
		AND (@p_isStartDate = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) >= @p_startDate OR (@p_isStartDate = 0))
		AND (@p_isEndDate = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) <= @p_endDate OR (@p_isEndDate = 0)))
		
		+

		(SELECT COUNT(*)
		FROM dbo.w2_zasoby_t
		INNER JOIN dbo.w2v_zasoby_syg ON dbo.w2v_zasoby_syg.zasob_id = dbo.w2_zasoby_t.zasob_id
		WHERE deleted = 0 AND dbo.w2_zasoby_t.wypozyczony = 0 AND (@p_group_id = -1 OR dbo.w2_zasoby_t.grupa_id = @p_group_id) AND (@p_state = 0 OR @p_state = -1))

		+

		(SELECT COUNT(*)
		FROM dbo.w2v_zasoby_syg
		INNER JOIN dbo.w2_zamowienia ON dbo.w2_zamowienia.zasob_id = dbo.w2v_zasoby_syg.zasob_id AND data_realiz IS NULL
		WHERE (@p_group_id = -1 OR dbo.w2v_zasoby_syg.grupa_id = @p_group_id) AND (@p_state = 2 OR @p_state = -1)	
		AND (@p_isStartDate = 1 AND CAST(data_zamow AS date) >= @p_startDate OR (@p_isStartDate = 0))
		AND (@p_isEndDate = 1 AND CAST(data_zamow AS date) <= @p_endDate OR (@p_isEndDate = 0))) AS liczba;
END
