CREATE VIEW [dbo].[v_teleadresy]
AS
SELECT     a.*, t.nazwa AS typteleadr_nazwa
FROM         dbo.w2_teleadresy a INNER JOIN
                      dbo.w2_typy_teleadresu t ON a.typteleadr_id = t.typteleadr_id

