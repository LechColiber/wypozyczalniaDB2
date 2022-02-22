CREATE VIEW [dbo].[w2v_uprawnienia_u]
AS
SELECT     dbo.w2_uprawnienia_u.*, dbo.w2_prawa.nazwa AS Nazwa
FROM         dbo.w2_uprawnienia_u INNER JOIN
                      dbo.w2_prawa ON dbo.w2_uprawnienia_u.prawa_id = dbo.w2_prawa.prawa_id

