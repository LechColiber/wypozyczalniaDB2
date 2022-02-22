CREATE VIEW [dbo].[w2v_zamowienia]
AS
SELECT     zasob_id, CONVERT(char(10), data_zamow, 104) AS data_z, CASE WHEN data_realiz IS NULL THEN 'oczekuje  ' ELSE CASE WHEN DATEPART(yyyy, 
                      data_realiz) < 1980 THEN 'odwołane' ELSE CONVERT(char(10), data_realiz, 104) END END AS data_r, (CASE WHEN DATEDIFF([d], data_zamow, 
                      COALESCE (data_realiz, GETDATE())) > w2_zamowienia.limit_czasu THEN DATEDIFF([d], data_zamow, COALESCE (data_realiz, GETDATE())) 
                      - w2_zamowienia.limit_czasu ELSE 0 END) AS po_terminie, w2_Uzytkownicy.nazwa AS Uzytkownik, RTRIM(w2_Pracownicy.nazwisko) 
                      + ' ' + RTRIM(w2_Pracownicy.imie) AS Pracownik
FROM         w2_zamowienia LEFT OUTER JOIN
                      w2_Pracownicy ON w2_zamowienia.pracown_id_zamow = w2_Pracownicy.pracown_id LEFT OUTER JOIN
                      w2_Uzytkownicy ON w2_zamowienia.uzytk_id = w2_Uzytkownicy.uzytk_id

