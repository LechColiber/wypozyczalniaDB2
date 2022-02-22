-- =============================================
-- Author:		Piotr Zawistowski
-- ALTER  date: 20.08.2008
-- Description:	Procedura zwraca raport użytkowników
-- =============================================
-- Mod: TP / 26.08.2008
-- =============================================
CREATE PROCEDURE [dbo].[w2_uzytkownicy_raport]
	@typ_id int = NULL,
	@grupa_id int = NULL
AS
BEGIN

	SET NOCOUNT ON;

SELECT u.uzytk_id AS id_uzyt, p.imie, p.nazwisko, u.nazwa, gu.nazwa AS gu_nazwa, '' AS dzial, tu.nazwa AS typ
	FROM [w2_typy_uzytk] tu
	INNER JOIN [w2_uzytkownicy] u ON u.typuzytk_id = tu.typuzytk_id
	INNER JOIN [w2_grupy_u] gu ON gu.grupa_id = u.grupa_id
	LEFT JOIN [w2_adresy] a ON u.uzytk_id = a.uzytk_id
	LEFT JOIN [w2_pracownicy] p ON a.pracown_id = p.pracown_id
	WHERE gu.grupa_id = COALESCE(@grupa_id, gu.grupa_id)
		AND tu.typuzytk_id = COALESCE(@typ_id, tu.typuzytk_id)

END

