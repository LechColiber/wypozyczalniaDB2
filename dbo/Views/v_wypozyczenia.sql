


CREATE VIEW [dbo].[v_wypozyczenia]
AS
/*
SELECT     z.opis, w.stan_wypoz, w.data_wypoz, w.limit_czasu, u.nazwa
FROM         dbo.w2_wypozyczenia w LEFT OUTER JOIN
                      dbo.w2_zasoby z ON w.zasob_id = z.zasob_id LEFT OUTER JOIN
                      dbo.w2_uzytkownicy u ON w.uzytk_id = u.uzytk_id
WHERE     (w.data_zwrot IS NULL)*/
SELECT wypoz_id, dbo.w2_zasoby_t.zasob_id, uzytk_id, dbo.w2_zasoby_t.grupa_id, opis, autor, syg, all_sygnat_z_usunietymi.numer_inw, k_kreskowy, limit_czasu, data_wypoz, data_zwrot,
syg_expand, numer_inw_expand,
(SELECT dbo.w2_grupy_z.nazwa AS grupa_nazwa FROM dbo.w2_grupy_z WHERE dbo.w2_grupy_z.grupa_id = dbo.w2_zasoby_t.grupa_id) AS rodzaj,
(SELECT LTRIM(RTRIM(nazwa)) FROM dbo.w2_uzytkownicy WHERE dbo.w2_uzytkownicy.uzytk_id = dbo.w2_wypozyczenia.uzytk_id) AS uzytkownik,
(SELECT LTRIM(RTRIM(nazwisko)) + ' ' + LTRIM(RTRIM(imie)) FROM dbo.w2_pracownicy WHERE dbo.w2_pracownicy.pracown_id = dbo.w2_wypozyczenia.pracown_id_wypoz) AS pracownik, num, rok1, tytul_sort
FROM colibertk.[dbo].[all_sygnat_z_usunietymi]
INNER JOIN dbo.w2_zasoby_t ON CAST(obcy_id AS int) = all_sygnat_z_usunietymi.id_zasob
INNER JOIN dbo.w2_wypozyczenia ON dbo.w2_wypozyczenia.zasob_id = dbo.w2_zasoby_t.zasob_id;












