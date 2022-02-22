-- Procedura zwraca listę wypożyczonych pozycji z danej grupy
-- Autor: Tomasz Puwalski
-- Wersja 1.0.0
-- Copyright c 2004 - 2009 Exell Sp. z o.o.
--
-- Historia zmian:
--   1.0.0 (2009-03-10) - pierwsza wersja procedury
--
/* Sortowanie:
* 1 opis
* 2 autor
* 3 kod kreskowy
* 4 numer inwentarzowy
* 5 sygnatura             
* 6 użytkownik
* 7 data wypożyczenia
* 8 przew. data zwrotu
* 9 rodzaj
* */
CREATE PROCEDURE [dbo].[w2_wypozyczone]
	@p_grupa_id INT, --
	@p_sort int, --
	@p_tytul varchar(201), --
	@p_autor varchar(max), --
	@p_syg varchar(20), -- 
	@p_numer_inw varchar(20), --
	@p_uzytkownik varchar(max), --
	@p_search_by_date bit, 
	@p_start_date datetime, 
	@p_end_date datetime,
	@p_tylko_przeterminowane bit
	
AS
BEGIN
	SELECT wypoz_id, uzytk_id, opis, autor, syg, numer_inw, k_kreskowy, rodzaj, uzytkownik,
	CONVERT(varchar(10), data_wypoz, 105) AS data_wypoz,
	CONVERT(varchar(10), data_wypoz + limit_czasu, 105) AS data_przewidywana,	
	CASE WHEN (data_wypoz + limit_czasu < getdate()) THEN 1 ELSE 0 END AS przedawnione
	FROM dbo.v_wypozyczone	
	WHERE data_zwrot IS NULL 
	AND (@p_grupa_id = 0 OR grupa_id = @p_grupa_id)
	AND ISNULL(opis, '') like @p_tytul + '%'
	AND ISNULL(autor, '') like '%' + @p_autor + '%'
	AND (ISNULL(syg, '') like @p_syg OR ISNULL(@p_syg, '') = '')
	AND ISNULL(numer_inw, '') like @p_numer_inw + '%'
	AND uzytkownik like @p_uzytkownik + '%'
	AND ((@p_search_by_date = 1 AND CAST(data_wypoz AS date) BETWEEN CAST(@p_start_date AS date) AND CAST(@p_end_date AS date)) OR @p_search_by_date = 0)
	AND (@p_tylko_przeterminowane = 0 OR (@p_tylko_przeterminowane = 1 AND getdate() > data_wypoz + limit_czasu))
	ORDER BY 
		CASE WHEN @p_sort = 1 THEN opis END,
		CASE WHEN @p_sort = 2 THEN autor END,
		CASE WHEN @p_sort = 3 THEN CASE WHEN k_kreskowy != '' THEN CAST(k_kreskowy AS int) ELSE 0 END END,
		CASE WHEN @p_sort = 4 THEN numer_inw_expand END,
		CASE WHEN @p_sort = 5 THEN sort_order END,
		CASE WHEN @p_sort = 5 THEN syg_expand END,
		CASE WHEN @p_sort = 6 THEN uzytkownik END,
		CASE WHEN @p_sort = 7 THEN data_wypoz END,
		CASE WHEN @p_sort = 8 THEN data_wypoz + limit_czasu END,
		CASE WHEN @p_sort = 9 THEN rodzaj END;
		
	/*SELECT wypoz_id, uzytk_id, dbo.w2v_zasoby_syg.opis, dbo.w2v_zasoby_syg.autor, dbo.w2v_zasoby_syg.syg, dbo.w2v_zasoby_syg.numer_inw, dbo.w2v_zasoby_syg.k_kreskowy, rodzaj, uzytkownik,
	CONVERT(varchar(10), data_wypoz, 105) AS data_wypoz,
	CONVERT(varchar(10), data_wypoz + limit_czasu, 105) AS data_przewidywana,	
	CASE WHEN (data_wypoz + limit_czasu < getdate()) THEN 1 ELSE 0 END AS przedawnione
	FROM dbo.v_wypozyczenia
	INNER JOIN dbo.w2v_zasoby_syg ON dbo.w2v_zasoby_syg.zasob_id = dbo.v_wypozyczenia.zasob_id
	WHERE data_zwrot IS NULL 
	AND (@p_grupa_id = 0 OR dbo.w2v_zasoby_syg.grupa_id = @p_grupa_id)
	AND ISNULL(dbo.w2v_zasoby_syg.opis, '') like @p_tytul + '%'
	AND ISNULL(dbo.w2v_zasoby_syg.autor, '') like '%' + @p_autor + '%'
	AND (ISNULL(dbo.w2v_zasoby_syg.syg, '') like @p_syg OR ISNULL(@p_syg, '') = '')
	AND ISNULL(dbo.w2v_zasoby_syg.numer_inw, '') like @p_numer_inw + '%'
	AND uzytkownik like @p_uzytkownik + '%'
	AND ((@p_search_by_date = 1 AND CAST(dbo.v_wypozyczenia.data_wypoz AS date) BETWEEN CAST(@p_start_date AS date) AND CAST(@p_end_date AS date)) OR @p_search_by_date = 0)
	AND (@p_tylko_przeterminowane = 0 OR (@p_tylko_przeterminowane = 1 AND getdate() > data_wypoz + limit_czasu))
	ORDER BY 
		CASE WHEN @p_sort = 1 THEN dbo.w2v_zasoby_syg.opis END,
		CASE WHEN @p_sort = 2 THEN dbo.w2v_zasoby_syg.autor END,
		CASE WHEN @p_sort = 3 THEN CASE WHEN dbo.w2v_zasoby_syg.k_kreskowy != '' THEN CAST(dbo.w2v_zasoby_syg.k_kreskowy AS int) ELSE 0 END END,
		CASE WHEN @p_sort = 4 THEN dbo.w2v_zasoby_syg.numer_inw_expand END,
		CASE WHEN @p_sort = 5 THEN sort_order END,
		CASE WHEN @p_sort = 5 THEN dbo.w2v_zasoby_syg.syg_expand END,
		CASE WHEN @p_sort = 6 THEN uzytkownik END,
		CASE WHEN @p_sort = 7 THEN dbo.v_wypozyczenia.data_wypoz END,
		CASE WHEN @p_sort = 8 THEN data_wypoz + limit_czasu END,
		CASE WHEN @p_sort = 9 THEN rodzaj END;*/

	 
END