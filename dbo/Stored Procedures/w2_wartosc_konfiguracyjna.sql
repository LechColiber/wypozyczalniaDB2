-- Procedura zwracająca ustawienie konfiguracyjne.
-- Autor: Tomasz Puwalski
-- Wersja 1.0.0
-- Copyright c 2004 - 2009 Exell Sp. z o.o.
--
-- Historia zmian:
--   1.0.0 (2009-03-23) - pierwsza wersja procedury
CREATE PROCEDURE [dbo].[w2_wartosc_konfiguracyjna]
	@nazwa VARCHAR(50)
AS

DECLARE @typ CHAR(1);
SELECT @typ = typ FROM w2_konfig WHERE nazwa = @nazwa;

IF @typ = 'C'
	SELECT wart_C FROM w2_konfig WHERE nazwa = @nazwa;
IF @typ = 'D'
	SELECT wart_D FROM w2_konfig WHERE nazwa = @nazwa;
IF @typ = 'N'
	SELECT wart_N FROM w2_konfig WHERE nazwa = @nazwa;
IF @typ = 'L'
	SELECT wart_L FROM w2_konfig WHERE nazwa = @nazwa;
