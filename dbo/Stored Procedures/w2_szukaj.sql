
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_szukaj] 
	-- Add the parameters for the stored procedure here
	 @p_searchText varchar(max), 
	 @p_field int, -- Title = 0, Signature = 1, InvertoryNo = 2, Barcode = 3 
	 @p_borrowed bit, -- NULL, true, false
	 @p_compareType int, -- Equals = 0, StartsWith = 1, Contains = 2 
	 @p_resourceType int, 
	 @p_sort1 int, -- None = 0, Signature = 1, InvertoryNo = 2, Title = 3, Author = 4 
	 @p_sort2 int, 
	 @p_sort3 int, 
	 @p_sort4 int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF (@p_sort4 IN (@p_sort1, @p_sort2, @p_sort3))
		SET @p_sort4 = 0;

	IF (@p_sort3 IN (@p_sort1, @p_sort2))
		SET @p_sort3 = 0;

	IF (@p_sort2 = @p_sort1)
		SET @p_sort2 = 0;

	SET @p_searchText =  
		CASE 
			WHEN @p_compareType = 0 THEN @p_searchText
			WHEN @p_compareType = 1 THEN @p_searchText + '%'
			WHEN @p_compareType = 2 THEN '%' + @p_searchText + '%'
		END;

    -- Insert statements for procedure here
	SELECT zasob_id, LTRIM(RTRIM(opis)) AS opis, autor, syg, k_kreskowy, numer_inw, sort_order,
	CASE WHEN wypozyczony = 1 THEN 1 ELSE 0 END AS wypozyczony
	FROM dbo.w2v_zasoby_syg
	WHERE 
		(
			(@p_field = 0 AND LTRIM(RTRIM(opis)) LIKE @p_searchText)
			OR (@p_field = 1 AND LTRIM(RTRIM(syg)) LIKE @p_searchText)
			OR (@p_field = 2 AND LTRIM(RTRIM(numer_inw)) LIKE @p_searchText)
			OR (@p_field = 3 AND LTRIM(RTRIM(k_kreskowy)) LIKE @p_searchText)
		) AND (@p_borrowed IS NULL OR wypozyczony = @p_borrowed)
		AND grupa_id = @p_resourceType
	ORDER BY
		CASE WHEN @p_sort1 = 1 THEN sort_order END,
		CASE WHEN @p_sort1 = 1 THEN syg_expand END,
		CASE WHEN @p_sort1 = 2 THEN numer_inw_expand END,
		CASE WHEN @p_sort1 = 3 AND grupa_id = 2 THEN tytul_sort END,	
		CASE WHEN @p_sort1 = 3 AND grupa_id = 2 THEN rok1 END,
		CASE WHEN @p_sort1 = 3 AND grupa_id = 2 THEN num END,	
		CASE WHEN @p_sort1 = 3 AND grupa_id = 1 THEN opis END,	
		CASE WHEN @p_sort1 = 4 THEN autor END,
		
		CASE WHEN @p_sort2 = 1 THEN sort_order END,
		CASE WHEN @p_sort2 = 1 THEN syg_expand END,
		CASE WHEN @p_sort2 = 2 THEN numer_inw_expand END,
		CASE WHEN @p_sort2 = 3 AND grupa_id = 2 THEN tytul_sort END,
		CASE WHEN @p_sort2 = 3 AND grupa_id = 2 THEN rok1 END,
		CASE WHEN @p_sort2 = 3 AND grupa_id = 2 THEN num END,
		CASE WHEN @p_sort2 = 3 AND grupa_id = 1 THEN opis END,
		CASE WHEN @p_sort2 = 4 THEN autor END,
		 
		CASE WHEN @p_sort3 = 1 THEN sort_order END,
		CASE WHEN @p_sort3 = 1 THEN syg_expand END,
		CASE WHEN @p_sort3 = 2 THEN numer_inw_expand END,
		CASE WHEN @p_sort3 = 3 AND grupa_id = 2 THEN tytul_sort END,
		CASE WHEN @p_sort3 = 3 AND grupa_id = 2 THEN rok1 END,
		CASE WHEN @p_sort3 = 3 AND grupa_id = 2 THEN num END,
		CASE WHEN @p_sort3 = 3 AND grupa_id = 1 THEN opis END,
		CASE WHEN @p_sort3 = 4 THEN autor END,
		
		CASE WHEN @p_sort4 = 1 THEN sort_order END,
		CASE WHEN @p_sort4 = 1 THEN syg_expand END,
		CASE WHEN @p_sort4 = 2 THEN numer_inw_expand END,
		CASE WHEN @p_sort4 = 3 AND grupa_id = 2 THEN tytul_sort END,
		CASE WHEN @p_sort4 = 3 AND grupa_id = 2 THEN rok1 END,
		CASE WHEN @p_sort4 = 3 AND grupa_id = 2 THEN num END,
		CASE WHEN @p_sort4 = 3 AND grupa_id = 1 THEN opis END,
		CASE WHEN @p_sort4 = 4 THEN autor END;
END

