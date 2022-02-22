-- Procedura realizuje zmianę limitu czasu na oddanie zasobu
-- Autor: Tomasz Puwalski
-- Wersja 1.0.0
--
CREATE PROCEDURE [dbo].[w2_przedluzenie]
	@wypoz_id AS INT,
	@data_wymag AS DATETIME,
	@rezultat TINYINT OUTPUT
AS
BEGIN
	SET @rezultat = 0
	UPDATE w2_wypozyczenia
		SET limit_czasu = DATEDIFF(d, data_wypoz, @data_wymag)
		WHERE wypoz_id = @wypoz_id
	SET @rezultat = @@ROWCOUNT
END

