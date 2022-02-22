

CREATE VIEW [dbo].[w2_zasoby]
AS

SELECT     zasob_id, kod_kresk, obcy_id, opis, pozcennik_id, limit_czas, opi_id, prawa, wypozyczony, uwagi, grupa_id, zewn_akt, numer_inw
FROM         dbo.w2_zasoby_t
WHERE     (deleted <> 1)





GO
CREATE TRIGGER [dbo].[w2_zasoby_del]
   ON [wypozyczalnia_wzorzec_dentons].[dbo].[w2_zasoby] 
   instead of delete
AS 
BEGIN
declare @wyporzycz bit
declare @tmp_id int
set @wyporzycz = (select wypozyczony from deleted)
if @wyporzycz <> 1
begin
update w2_zasoby_t set deleted = 1 where zasob_id = (select zasob_id from deleted)

select @tmp_id = zasob_id from deleted

print @tmp_id

end
END


GO
/*
-- 2013.08.13
--	v1.1		1. Sprawdzenie, czy @maxzasob_id jest NULL, jeśli tak, to ustawiana jest wartość na 1, w innym przypadku na @maxzasob_id += 1.
*/
CREATE TRIGGER [dbo].[w2_zasoby_it]
   ON [dbo].[w2_zasoby] 
   instead of insert
AS 
BEGIN
/*
declare @stan bit
declare @limit_czas smallint
declare @wypozyczony bit
declare @zasob_id_ins int
set @wypozyczony = 0
set @stan = 0
set @limit_czas = 30

declare @maxzasob_id int

select @maxzasob_id = max(zasob_id) from w2_zasoby_t

IF @maxzasob_id IS NULL
	set @maxzasob_id = 1;
ELSE
	SET @maxzasob_id = @maxzasob_id + 1;

insert into w2_zasoby_t([zasob_id],[kod_kresk], [obcy_id], 
						[opis], [pozcennik_id], [limit_czas], 
						[opi_id], [prawa], [wypozyczony], 
						[uwagi], [grupa_id], [zewn_akt], 
						[numer_inw],[deleted])
SELECT @maxzasob_id,kod_kresk, obcy_id, opis, pozcennik_id, @limit_czas, opi_id, prawa, @wypozyczony, uwagi, grupa_id, zewn_akt, numer_inw,@stan from inserted*/

INSERT INTO w2_zasoby_t([kod_kresk], [obcy_id], [opis], [pozcennik_id], [opi_id], [prawa], [uwagi], grupa_id, [zewn_akt], [numer_inw],[deleted])
SELECT kod_kresk, obcy_id, opis, pozcennik_id, opi_id, prawa, uwagi, grupa_id, zewn_akt, numer_inw, 0 FROM inserted;


END



GO
CREATE TRIGGER [dbo].[w2_zasoby_upd]
   ON [wypozyczalnia_wzorzec_dentons].[dbo].[w2_zasoby] 
   instead of update
AS 
BEGIN
update w2_zasoby_t set 
					kod_kresk = inserted.kod_kresk,
					obcy_id = inserted.obcy_id, 
					opis = inserted.opis, 
					pozcennik_id = inserted.pozcennik_id, 
					limit_czas = inserted.limit_czas, 
					opi_id = inserted.opi_id, 
					prawa = inserted.prawa, 
					wypozyczony = inserted.wypozyczony, 
					uwagi = inserted.uwagi, 
					grupa_id = inserted.grupa_id, 
					zewn_akt = inserted.zewn_akt, 
					numer_inw = inserted.numer_inw from inserted where w2_zasoby_t.zasob_id = inserted.zasob_id
END

