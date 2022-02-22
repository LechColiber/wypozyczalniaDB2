-- =============================================
-- Author:		Piotr Zawistowski
-- ALTER  date: 20.08.2008
-- Description:	Procedura zwraca raport wypożyczeń zasobów
-- =============================================
CREATE PROCEDURE [dbo].[w2_wypozyczenia_raport]
	@data_od datetime,
	@data_do datetime,
	@zwrocone bit = NULL,
	@uzytk_id int = NULL
AS
BEGIN

	SET NOCOUNT ON;

SELECT w.wypoz_id,
       w.zasob_id,
       w.uzytk_id,
       u.nazwa,
       w.grupa_id,
       w.pracown_id_wypoz,
       w.data_wypoz data_inicjacji,
       
       GETDATE() as dzisiaj,
       DATEADD(day,w.limit_czasu,w.data_wypoz) przew_data_zwrotu,
       w.pracown_id_zwrot,
       ISNULL(w.data_zwrot,'') data_zakonczenia,
       w.limit_czasu,
       w.stan_wypoz,
       CAST(w.uwagi as varchar),
       z.kod_kresk as kod,
       z.numer_inw AS inw, 
       sw_nazwa = 
       CASE
         WHEN data_zwrot IS NULL  and @zwrocone = 0
          THEN
            'Wypożyczony'
         WHEN data_zwrot IS NOT NULL  and @zwrocone = 1
          THEN
            'Pozycje zwrócone'
            --else ''
       END,
       g.nazwa AS gz_nazwa, 
       z.opis AS opis_zasobu  
  FROM [w2_wypozyczenia] w LEFT OUTER JOIN w2_uzytkownicy u 
    ON  w.uzytk_id = u.uzytk_id , 
       [w2_zasoby] z, 
       [w2_grupy_z] g
       
 WHERE ((@zwrocone = 1 
 AND data_zwrot IS NOT NULL 
 --and z.wypozyczony = 0
 ) OR 
		(@zwrocone = 0  
		and data_zwrot is null 
		--and z.wypozyczony = 1
		) or @zwrocone is null) AND
 g.grupa_id = z.grupa_id
 AND (@uzytk_id is null or u.uzytk_id = @uzytk_id)
   AND w.zasob_id = z.zasob_id
   AND (w.data_wypoz >= @data_od  
   AND w.data_wypoz <= @data_do)
   group by z.wypozyczony,g.nazwa,w.wypoz_id,
       w.zasob_id,
       w.uzytk_id,
       u.nazwa,
       w.grupa_id,
       w.pracown_id_wypoz,
       w.data_wypoz,
       w.limit_czasu,w.data_wypoz,
       w.pracown_id_zwrot,
       w.data_zwrot,
       w.limit_czasu,
       w.stan_wypoz,
       CAST(w.uwagi as varchar),
       z.kod_kresk, 
       z.numer_inw, 
       z.opis
 UNION ALL
SELECT w.wypoz_id,
       w.zasob_id,
       w.uzytk_id,
       u.nazwa,
       w.grupa_id,
       w.pracown_id_wypoz,
       w.data_wypoz data_inicjacji,
       
       GETDATE() as dzisiaj,
       DATEADD(day,w.limit_czasu,w.data_wypoz) przew_data_zwrotu,
       w.pracown_id_zwrot,
       ISNULL(w.data_zwrot,'') data_zakonczenia,
       w.limit_czasu,
       w.stan_wypoz,
       CAST(w.uwagi as varchar),
       z.kod_kresk as kod,
       z.numer_inw AS inw, 
       'Zamówiony' sw_nazwa,
       g.nazwa AS gz_nazwa, 
       z.opis AS opis_zasobu  
  FROM [w2_wypozyczenia] w LEFT OUTER JOIN w2_uzytkownicy u 
    ON  w.uzytk_id = u.uzytk_id, 
       [w2_zasoby] z JOIN [w2_zamowienia] za
       ON z.zasob_id = za.zasob_id, 
       [w2_grupy_z] g
        
 WHERE ((@zwrocone = 1 
 AND data_zwrot IS NOT NULL 
 --and z.wypozyczony = 0
 ) OR 
		(@zwrocone = 0  
		and data_zwrot is null 
		--and z.wypozyczony = 1
		) or @zwrocone is null) AND
 g.grupa_id = z.grupa_id
 AND (@uzytk_id is null or u.uzytk_id = @uzytk_id)
   AND w.zasob_id = z.zasob_id
   AND (w.data_wypoz >= @data_od  
   AND w.data_wypoz <= @data_do)
   AND (za.data_zamow >= @data_od
   AND za.data_zamow >= @data_do)
   group by z.wypozyczony,g.nazwa,w.wypoz_id,
       w.zasob_id,
       w.uzytk_id,
       u.nazwa,
       w.grupa_id,
       w.pracown_id_wypoz,
       w.data_wypoz,
       w.limit_czasu,w.data_wypoz,
       w.pracown_id_zwrot,
       w.data_zwrot,
       w.limit_czasu,
       w.stan_wypoz,
       CAST(w.uwagi as varchar),
       z.numer_inw ,
       z.kod_kresk, 
       z.opis
 ORDER BY sw_nazwa,g.nazwa,w.data_wypoz,  z.opis 
END

