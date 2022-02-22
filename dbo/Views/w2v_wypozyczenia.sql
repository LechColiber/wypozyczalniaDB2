CREATE VIEW [dbo].[w2v_wypozyczenia]
AS
SELECT zasob_id, 
  CONVERT(char(10), data_wypoz, 104) AS data_w, 
  COALESCE(CONVERT(char(10), data_zwrot, 104), '') AS data_z,
  (CASE WHEN DATEDIFF("d", data_wypoz, COALESCE(data_zwrot, GETDATE())) > w2_Wypozyczenia.limit_czasu THEN DATEDIFF("d", data_wypoz, COALESCE(data_zwrot, GETDATE()))-w2_Wypozyczenia.limit_czasu ELSE 0 END) AS po_terminie,
  w2_Uzytkownicy.nazwa AS Uzytkownik, RTRIM(w2_Pracownicy.nazwisko) + ' ' + RTRIM(w2_Pracownicy.imie) AS Pracownik
 FROM w2_Wypozyczenia
    LEFT OUTER JOIN w2_Pracownicy ON  w2_Wypozyczenia.pracown_id_wypoz = w2_Pracownicy.pracown_id
    LEFT OUTER JOIN w2_Uzytkownicy ON  w2_Wypozyczenia.uzytk_id = w2_Uzytkownicy.uzytk_id

