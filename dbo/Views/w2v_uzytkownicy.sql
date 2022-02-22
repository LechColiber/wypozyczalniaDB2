CREATE VIEW [dbo].[w2v_uzytkownicy]
AS
SELECT     u.*, u2.nazwa AS nazwa_parent, g.nazwa AS nazwa_grupy, t.nazwa AS nazwa_typu
FROM         dbo.w2_uzytkownicy u LEFT OUTER JOIN
                      dbo.w2_uzytkownicy u2 ON u.uzytk_id_parent = u2.uzytk_id LEFT OUTER JOIN
                      dbo.w2_grupy_u g ON u.grupa_id = g.grupa_id LEFT OUTER JOIN
                      dbo.w2_typy_uzytk t ON u.typuzytk_id = t.typuzytk_id

