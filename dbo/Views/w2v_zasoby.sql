CREATE VIEW [dbo].[w2v_zasoby]
AS
SELECT     dbo.w2_zasoby.*, dbo.w2_grupy_z.nazwa AS grupa_nazwa
FROM         dbo.w2_zasoby INNER JOIN
                      dbo.w2_grupy_z ON dbo.w2_zasoby.grupa_id = dbo.w2_grupy_z.grupa_id

