-- Procedura do testowania przekazywania parametr˘w w obie strony

-- c 2004 Exell Sp. z o.o.
-- Autor: Tomasz Puwalski

CREATE proc [dbo].[test]
  @rezultat varchar(30) output
as

select @rezultat = 'SQL Server return value :-)'

