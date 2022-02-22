CREATE VIEW [dbo].[w2v_pozycje_cennika]
AS
SELECT *, walutaex = CASE waluta WHEN 'Z' THEN 'zł' WHEN '$' THEN '$ ' WHEN 'E' THEN '? ' ELSE '  ' END 
FROM  dbo.w2_pozycje_cennika

