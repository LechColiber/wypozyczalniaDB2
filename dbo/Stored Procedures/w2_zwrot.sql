
-- Procedura realizuje proces zwracania wypożyczonego zasobu.
-- Zwracane jest 1 jeżli wykonano pomyślnie, a 0 w przeciwnym wypadku.
-- Autor: Tomasz Puwalski
-- Wersja 1.1.0
--
CREATE PROCEDURE [dbo].[w2_zwrot]
	@wypoz_id INT,
	@pracown_id INT,
	@data_zwrotu DATETIME,
	@rezultat TINYINT OUTPUT
AS
BEGIN
	DECLARE @zasob_id INT;
	DECLARE @data_zwrot DATETIME;
	DECLARE @wypozyczony BIT;
 
	SET @rezultat = 0;

	SELECT @zasob_id = zasob_id, @data_zwrot = data_zwrot
	FROM dbo.w2_wypozyczenia
	WHERE wypoz_id = @wypoz_id;

	IF @data_zwrot IS NOT NULL 
	BEGIN
		RAISERROR('Zasób został już wcześniej zwrócony.', 16, 1);
		RETURN (1);
	END -- IF

	/*SELECT @wypozyczony = wypozyczony
		FROM w2_zasoby
		WHERE zasob_id = @zasob_id
	IF @wypozyczony = 0 BEGIN
		RAISERROR('Nie można zwrócić zasobu, który nie był wypożyczony.', 1, 1)
		RETURN (1)
	END -- IF*/

	--BEGIN TRANSACTION
		UPDATE dbo.w2_wypozyczenia
			SET 
				pracown_id_zwrot = @pracown_id, 
				data_zwrot = @data_zwrotu
		WHERE wypoz_id = @wypoz_id;

		IF NOT EXISTS (SELECT 1 FROM dbo.w2_wypozyczenia WHERE zasob_id = @zasob_id AND data_zwrot IS NULL) -- Zabezpieczenie przed błędami z poprzednich wersji
			UPDATE dbo.w2_zasoby_t
				SET 
					wypozyczony = 0, 
					zewn_akt = 0
			WHERE zasob_id = @zasob_id;
	--COMMIT TRANSACTION

	SET @rezultat = 1;
END

