create VIEW [dbo].[w2v_uprawnienia_z]
AS
SELECT     dbo.w2_uprawnienia_z.*, dbo.w2_prawa.nazwa AS Nazwa
FROM         dbo.w2_uprawnienia_z INNER JOIN
                      dbo.w2_prawa ON dbo.w2_uprawnienia_z.prawa_id = dbo.w2_prawa.prawa_id