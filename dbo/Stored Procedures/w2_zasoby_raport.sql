-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_zasoby_raport] 
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
	;with tab1 AS
	(
		SELECT /*ISNULL(autor, '') AS autor, dbo.v_wypozyczenia.opis AS opis,*/
		ISNULL(dbo.v_wypozyczenia.autor + ' : ', '') + dbo.v_wypozyczenia.opis AS opis, dbo.v_wypozyczenia.numer_inw, dbo.v_wypozyczenia.syg, uzytkownik,
		CASE WHEN @p_isStartDate = 0 THEN
				(SELECT TOP 1 CONVERT(varchar(10), data_wypoz, 105) FROM dbo.v_wypozyczenia WHERE uzytk_id = dbo.v_wypozyczenia.uzytk_id AND data_zwrot IS NOT NULL ORDER BY data_wypoz) 
			ELSE
				CONVERT(varchar(10), @p_startDate, 105)
		END AS data_min,

		CASE WHEN @p_isEndDate = 0 THEN
				CONVERT(varchar(10), GETDATE(), 105)
			ELSE
				CONVERT(varchar(10), @p_endDate, 105)
		END AS data_max,
		CONVERT(varchar(10), data_wypoz, 105) AS data_wypoz,
		data_wypoz AS data_wypoz_sort,
		CONVERT(varchar(10), GETDATE(), 105) AS data_aktualna,
		dbo.w2v_zasoby_syg.grupa_id, (SELECT UPPER(LTRIM(RTRIM(nazwa))) FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.w2v_zasoby_syg.grupa_id) AS nazwa_grupy,
		1 AS stan, 'Wypożyczone' AS stan_nazwa, sort_order, dbo.v_wypozyczenia.syg_expand, dbo.v_wypozyczenia.tytul_sort, dbo.v_wypozyczenia.rok1, dbo.v_wypozyczenia.num
		FROM dbo.w2v_zasoby_syg
		INNER JOIN dbo.v_wypozyczenia ON dbo.v_wypozyczenia.zasob_id = dbo.w2v_zasoby_syg.zasob_id AND data_zwrot IS NULL
		WHERE wypozyczony = 1 AND (@p_group_id = -1 OR dbo.w2v_zasoby_syg.grupa_id = @p_group_id) AND (@p_state = 1 OR @p_state = -1)
		AND (@p_isStartDate = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) >= @p_startDate OR (@p_isStartDate = 0))
		AND (@p_isEndDate = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) <= @p_endDate OR (@p_isEndDate = 0))
		--ORDER BY dbo.v_wypozyczenia.data_wypoz, syg_expand;
		UNION

		SELECT /*ISNULL(autor, '') AS autor, dbo.v_wypozyczenia.opis AS opis,*/
		ISNULL(autor + ' : ', '') + dbo.w2v_zasoby_syg.opis AS opis, dbo.w2v_zasoby_syg.numer_inw, syg, NULL AS uzytkownik,
		CASE WHEN @p_isStartDate = 0 THEN
				(SELECT TOP 1 CONVERT(varchar(10), data_wypoz, 105) FROM dbo.v_wypozyczenia WHERE uzytk_id = dbo.v_wypozyczenia.uzytk_id AND data_zwrot IS NOT NULL ORDER BY data_wypoz) 
			ELSE
				CONVERT(varchar(10), @p_startDate, 105)
		END AS data_min,

		CASE WHEN @p_isEndDate = 0 THEN
				CONVERT(varchar(10), GETDATE(), 105)
			ELSE
				CONVERT(varchar(10), @p_endDate, 105)
		END AS data_max,

		NULL data_wypoz,
		NULL AS data_wypoz_sort,
		CONVERT(varchar(10), GETDATE(), 105) AS data_aktualna,
		dbo.w2_zasoby_t.grupa_id, (SELECT UPPER(LTRIM(RTRIM(nazwa))) FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.w2_zasoby_t.grupa_id) AS nazwa_grupy,
		0 AS stan, 'Niewypożyczone' AS stan_nazwa, sort_order, syg_expand, tytul_sort, rok1, num
		FROM dbo.w2_zasoby_t
		INNER JOIN dbo.w2v_zasoby_syg ON dbo.w2v_zasoby_syg.zasob_id = dbo.w2_zasoby_t.zasob_id
		WHERE deleted = 0 AND dbo.w2_zasoby_t.wypozyczony = 0 AND (@p_group_id = -1 OR dbo.w2_zasoby_t.grupa_id = @p_group_id) AND (@p_state = 0 OR @p_state = -1)

		UNION

			SELECT /*ISNULL(autor, '') AS autor, dbo.v_wypozyczenia.opis AS opis,*/
		ISNULL(autor + ' : ', '') + dbo.w2v_zasoby_syg.opis AS opis, dbo.w2v_zasoby_syg.numer_inw, syg, 
		(SELECT LTRIM(RTRIM(nazwa)) FROM dbo.w2_uzytkownicy WHERE dbo.w2_uzytkownicy.uzytk_id = dbo.w2_zamowienia.uzytk_id) AS uzytkownik,
		CASE WHEN @p_isStartDate = 0 THEN
				(SELECT TOP 1 CONVERT(varchar(10), data_zamow, 105) FROM dbo.w2_zamowienia WHERE uzytk_id = dbo.w2_zamowienia.uzytk_id ORDER BY data_zamow) 
			ELSE
				CONVERT(varchar(10), @p_startDate, 105)
		END AS data_min,

		CASE WHEN @p_isEndDate = 0 THEN
				CONVERT(varchar(10), GETDATE(), 105)
			ELSE
				CONVERT(varchar(10), @p_endDate, 105)
		END AS data_max,

		CONVERT(varchar(10), data_zamow, 105) AS data_wypoz,
		NULL AS data_wypoz_sort,
		CONVERT(varchar(10), GETDATE(), 105) AS data_aktualna,
		dbo.w2v_zasoby_syg.grupa_id, (SELECT UPPER(LTRIM(RTRIM(nazwa))) FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.w2v_zasoby_syg.grupa_id) AS nazwa_grupy,
		2 AS stan, 'Zamówione' AS stan_nazwa, sort_order, syg_expand, tytul_sort, rok1, num
		FROM dbo.w2v_zasoby_syg
		INNER JOIN dbo.w2_zamowienia ON dbo.w2_zamowienia.zasob_id = dbo.w2v_zasoby_syg.zasob_id AND data_realiz IS NULL
		WHERE (@p_group_id = -1 OR dbo.w2v_zasoby_syg.grupa_id = @p_group_id) AND (@p_state = 2 OR @p_state = -1)	
		AND (@p_isStartDate = 1 AND CAST(data_zamow AS date) >= @p_startDate OR (@p_isStartDate = 0))
		AND (@p_isEndDate = 1 AND CAST(data_zamow AS date) <= @p_endDate OR (@p_isEndDate = 0))
	)

	SELECT opis, syg, data_wypoz, data_min, data_max, data_aktualna, uzytkownik, grupa_id, nazwa_grupy, stan, stan_nazwa
	FROM tab1
	ORDER BY data_wypoz_sort, sort_order, syg_expand, 
	CASE WHEN grupa_id = 2 THEN rok1 END,
	CASE WHEN grupa_id = 2 THEN num END,
	CASE WHEN grupa_id = 2 THEN tytul_sort ELSE opis END;	
END
