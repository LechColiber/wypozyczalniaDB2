-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
/* Sortowanie:
* 1 opis
* 2 autor
* 3 stan
* 4 numer inwentarzowy
* 5 sygnatura             
* 6 użytkownik
* 7 data zamowienia
* 8 rodzaj
* */
-- =============================================
CREATE PROCEDURE [dbo].[w2_zamowienia_lista]
	-- Add the parameters for the stored procedure here
	@p_sort int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	;with tab1 AS
	(
		SELECT zamow_id, opis, autor, numer_inw, numer_inw_expand, syg, syg_expand, sort_order, dbo.w2_zamowienia.zasob_id,
		(SELECT dbo.w2_grupy_z.nazwa AS grupa_nazwa FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.w2v_zasoby_syg.grupa_id) AS rodzaj,
		CONVERT(varchar(16), data_zamow, 121) AS data_zamow,
		dbo.w2_zamowienia.data_zamow AS data_zamow_sort,
		dbo.w2_zamowienia.uzytk_id,
		uwagi,
		(SELECT zablokowany FROM dbo.w2_uzytkownicy WHERE dbo.w2_uzytkownicy.uzytk_id = dbo.w2_zamowienia.uzytk_id) AS zablokowany,
		(SELECT LTRIM(RTRIM(nazwa)) FROM dbo.w2_uzytkownicy WHERE dbo.w2_uzytkownicy.uzytk_id = dbo.w2_zamowienia.uzytk_id) AS uzytkownik,
		CASE WHEN stan_zamow = '0' THEN 0 ELSE 1 END AS stan
		FROM dbo.w2_zamowienia
		INNER JOIN dbo.w2v_zasoby_syg ON dbo.w2v_zasoby_syg.zasob_id = dbo.w2_zamowienia.zasob_id
		WHERE stan_zamow IN ('0', '3') AND uzytk_id IN (SELECT uzytk_id FROM dbo.w2_uzytkownicy WHERE data_wyrejestr IS NULL)
	)
	SELECT zamow_id, zasob_id, opis, autor, numer_inw, numer_inw_expand, syg, syg_expand, zasob_id, rodzaj, data_zamow, uzytkownik, uzytk_id, stan, zablokowany, uwagi
	FROM tab1
	ORDER BY 
		CASE WHEN @p_sort = 1 THEN opis END,
		CASE WHEN @p_sort = 2 THEN autor END,
		CASE WHEN @p_sort = 3 THEN stan END,
		CASE WHEN @p_sort = 4 THEN numer_inw_expand END,
		CASE WHEN @p_sort = 5 THEN sort_order END,
		CASE WHEN @p_sort = 5 THEN syg_expand END,
		CASE WHEN @p_sort = 6 THEN uzytkownik END,
		CASE WHEN @p_sort = 7 THEN data_zamow_sort END,
		CASE WHEN @p_sort = 8 THEN rodzaj END;
END
