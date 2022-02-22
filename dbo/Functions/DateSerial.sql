-- DateSerial - funkcja tworząca datę na podstawie roku, miesiąca i dnia
-- Autor: Tomasz Puwalski
-- Wersja 1.0.0
-- Copyright © 2008 PUWALSKI
--
-- Historia zmian:
--   1.0.0 (2008-08-14) - pierwsza wersja funkcji

CREATE FUNCTION [dbo].[DateSerial] (
	@Year INT, 
	@Month INT, 
	@Day INT)
RETURNS SMALLDATETIME
AS
BEGIN 
	DECLARE @d AS SMALLDATETIME
	SET @d = CAST(0 AS SMALLDATETIME)
	SET @d = DATEADD(yyyy, @Year - YEAR(@d), @d)
	SET @d = DATEADD(m, @Month - 1, @d)
	SET @d = DATEADD(d,  @Day - 1, @d)
	RETURN @d
END

