
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION w2_wypozyczenie_limit_czasu
(	
	-- Add the parameters for the function here
	@p_uzytk_id int,
	@p_zasob_id int
)
RETURNS int 
AS
BEGIN
	DECLARE @uzytk_limit_czasu int = (SELECT limit_czasu FROM dbo.w2_uzytkownicy WHERE uzytk_id = @p_uzytk_id);
	DECLARE @zasob_limit_czasu int = (SELECT limit_czas	FROM dbo.w2_zasoby_t WHERE zasob_id = @p_zasob_id);

	IF @uzytk_limit_czasu <= @zasob_limit_czasu 
		RETURN @uzytk_limit_czasu;
	 
	RETURN @zasob_limit_czasu;
END