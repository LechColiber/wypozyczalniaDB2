CREATE VIEW [dbo].[w2v_pozycje_cennika_cnt]
AS
SELECT     cennik_id, COUNT(*) AS cnt
FROM         dbo.w2_pozycje_cennika W2_pozycje_cennika
GROUP BY cennik_id

