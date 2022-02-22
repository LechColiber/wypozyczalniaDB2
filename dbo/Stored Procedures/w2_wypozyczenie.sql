-- Procedura realizuje proces wypożyczenia zasobu.
-- Autor: Tomasz Puwalski
-- Wersja 1.1.0
-- Copyright c 2004 - 2008 Exell Sp. z o.o.
--
--
-- Historia zmian:
--	 1.2.0 (2013-09-19) - dodanie "zewn_akt = 0" na update w2_zasoby
--   1.1.0 (2008-08-01) - oznaczenie parametru @data_wyp jako opcjonalny
--   1.0.0 (2004-05-15) - pierwsza wersja procedury

CREATE procedure [dbo].[w2_wypozyczenie]
	  @p_zasob_id int,
	  @p_uzytk_id int,
	  @p_pracown_id int,
	  @p_limit_czasu smallint,
	  @p_uwagi varchar(max),
	  @p_data_wyp datetime,
	  @wypoz_id int = -1 OUTPUT
AS
BEGIN
	DECLARE @grupa_id int;

	IF ((SELECT wypozyczony FROM dbo.w2_zasoby_t WHERE zasob_id = @p_zasob_id) = 1) 
	BEGIN
		RAISERROR('Nie można wypożyczyć zasobu, ponieważ aktualnie jest wypożyczony.', 16, 1)
		RETURN 1;
	END

	SELECT @grupa_id = (SELECT grupa_id FROM dbo.w2_uzytkownicy WHERE uzytk_id = @p_uzytk_id);

	INSERT INTO dbo.w2_wypozyczenia (zasob_id, uzytk_id, grupa_id, pracown_id_wypoz, limit_czasu, uwagi, data_wypoz) 
	VALUES (@p_zasob_id, @p_uzytk_id, @grupa_id, @p_pracown_id, @p_limit_czasu, @p_uwagi, @p_data_wyp);

	set @wypoz_id = SCOPE_IDENTITY();

	UPDATE dbo.w2_zasoby SET wypozyczony = 1, zewn_akt = 0 WHERE zasob_id = @p_zasob_id;

	UPDATE dbo.w2_zamowienia SET pracown_id_realiz = @p_pracown_id, data_realiz = GETDATE(), stan_zamow = '1' 
	WHERE uzytk_id = @p_uzytk_id AND zasob_id = @p_zasob_id AND stan_zamow IN ('0', '3');
end