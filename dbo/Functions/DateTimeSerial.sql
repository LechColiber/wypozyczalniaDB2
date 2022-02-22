-- DateTimeSerial - funkcja tworząca datę na podstawie roku, miesiąca, dnia, godziny, minuty, sekundy i milisekund
-- Autor: Tomasz Puwalski
-- Wersja 1.1.0
-- Copyright © 2008 PUWALSKI
--
-- Historia zmian:
--   1.0.0 (2008-08-18) - pierwsza wersja funkcji

CREATE FUNCTION [dbo].[DateTimeSerial] (
	@Year INT, 
	@Month INT, 
	@Day INT,
	@Hour INT,
	@Minute INT,
	@Second INT,
	@Milisec INT)
RETURNS DATETIME
AS
BEGIN 
	DECLARE @d AS DATETIME
	SET @d = CAST(0 AS SMALLDATETIME)
	SET @d = DATEADD(yyyy, @Year - YEAR(@d), @d)
	SET @d = DATEADD(m, @Month - 1, @d)
	SET @d = DATEADD(d,  @Day - 1, @d)
	SET @d = DATEADD(hh,  @Hour, @d)
	SET @d = DATEADD(n,  @Minute, @d)
	SET @d = DATEADD(s,  @Second, @d)
	SET @d = DATEADD(ms,  @Milisec, @d)
	RETURN @d
END

