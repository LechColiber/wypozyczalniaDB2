CREATE VIEW [dbo].[w2v_zamowione]
AS
SELECT     z.opis, w.stan_zamow, w.data_zamow, w.limit_czasu, u.nazwa
FROM         dbo.w2_zamowienia w LEFT OUTER JOIN
                      dbo.w2_zasoby z ON w.zasob_id = z.zasob_id LEFT OUTER JOIN
                      dbo.w2_uzytkownicy u ON w.uzytk_id = u.uzytk_id
WHERE     (w.data_realiz IS NULL)

