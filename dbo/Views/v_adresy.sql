CREATE VIEW [dbo].[v_adresy]
AS
SELECT     a.*, t.nazwa AS typadr_nazwa
FROM         dbo.w2_adresy a INNER JOIN
                      dbo.w2_typy_adresu t ON a.typadr_id = t.typadr_id

