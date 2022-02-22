CREATE TABLE [dbo].[w2_zasoby_t] (
    [zasob_id]     INT            IDENTITY (1, 1) NOT NULL,
    [kod_kresk]    VARCHAR (25)   NULL,
    [obcy_id]      VARCHAR (25)   NULL,
    [opis]         VARCHAR (1536) NULL,
    [pozcennik_id] INT            NULL,
    [limit_czas]   SMALLINT       CONSTRAINT [DF_w2_zasoby_limit_czas] DEFAULT ((30)) NOT NULL,
    [opi_id]       INT            NULL,
    [prawa]        VARCHAR (25)   NULL,
    [wypozyczony]  BIT            CONSTRAINT [DF_zasoby_wypozyczony] DEFAULT ((0)) NOT NULL,
    [uwagi]        TEXT           NULL,
    [grupa_id]     INT            CONSTRAINT [DF_w2_zasoby_grupa_id] DEFAULT ((1)) NOT NULL,
    [zewn_akt]     BIT            CONSTRAINT [DF_w2_zasoby_zewn_akt] DEFAULT ((0)) NOT NULL,
    [deleted]      BIT            NULL,
    [numer_inw]    VARCHAR (20)   NULL,
    CONSTRAINT [PK_zasoby] PRIMARY KEY CLUSTERED ([zasob_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_zasoby_kod_kresk]
    ON [dbo].[w2_zasoby_t]([kod_kresk] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_zasoby_obcy_id]
    ON [dbo].[w2_zasoby_t]([obcy_id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_zasoby_opi_id]
    ON [dbo].[w2_zasoby_t]([opi_id] ASC);


GO
create TRIGGER [dbo].[w2_zasoby_t_del]
   ON [dbo].[w2_zasoby_t]
   INSTEAD OF DELETE
AS 
BEGIN
/*
declare @wyporzycz bit
declare @tmp_id int
set @wyporzycz = (select wypozyczony from deleted)
if @wyporzycz <> 1
begin
update w2_zasoby_t set deleted = 1 where zasob_id = (select zasob_id from deleted)

select @tmp_id = zasob_id from deleted

print @tmp_id

end*/

	UPDATE dbo.w2_zasoby_t SET deleted = 1 WHERE zasob_id IN (SELECT zasob_id FROM deleted WHERE deleted.wypozyczony = 0);
END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER AddPermissionsAfterInsert
   ON  dbo.w2_zasoby_t
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	;with tab1 AS
	(
		SELECT zasob_id, prawa_id,
		(SELECT CASE WHEN stan_domyslny = 0 THEN 1 ELSE 0 END FROM dbo.w2_prawa WHERE dbo.w2_prawa.prawa_id = dbo.w2_prawa_grupy_z.prawa_id) AS stan,
		GETDATE() AS data_od, DATEADD(yyyy, 25, GETDATE()) AS data_do
	
		FROM inserted
		INNER JOIN dbo.w2_prawa_grupy_z ON dbo.w2_prawa_grupy_z.grupa_id = inserted.grupa_id
	)
	INSERT INTO dbo.w2_uprawnienia_z (zasob_id, prawa_id, data_od, data_do, zablokowane) 
	--VALUES (@p_zasob_id, @p_prawa_id, @p_data_od, @p_data_do, @p_zablokowane);
	SELECT zasob_id, prawa_id, data_od, data_do, stan
	FROM tab1;
	
END

GO
CREATE TRIGGER [dbo].[UpdateZasobyOnColiber] ON [dbo].[w2_zasoby_t] 
AFTER UPDATE 
AS

	UPDATE colibertk..zasoby
		SET stan = wypozyczony,
			zewn_akt = 1
		FROM inserted
		WHERE id_zasob = CAST(obcy_id AS INT) AND inserted.zewn_akt = 0;

	DELETE FROM dbo.w2_zamowienia WHERE stan_zamow IN ('0', '3') AND zasob_id IN (SELECT zasob_id FROM deleted WHERE deleted.deleted = 1);

/*
	DECLARE @wypozyczony AS BIT
	DECLARE @obcy_id AS VARCHAR(25)
	DECLARE @zewn_akt AS BIT

	DECLARE i_cursor CURSOR LOCAL FAST_FORWARD FOR
		SELECT wypozyczony, obcy_id, zewn_akt FROM inserted

	OPEN i_cursor

	FETCH NEXT
		FROM i_cursor
		INTO @wypozyczony, @obcy_id, @zewn_akt
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @zewn_akt = 0 -- Jeśli 1, to znaczy, że to uaktualnienie zostało wywołane przez trigger w Colibrze i nie wolno go tam odsyłać, bo się zapętli
			UPDATE coliber_wzorzec..zasoby
				SET stan = @wypozyczony,
					zewn_akt = 1
				WHERE id_zasob = CAST(@obcy_id AS INT)
		FETCH NEXT
			FROM i_cursor
			INTO @wypozyczony, @obcy_id, @zewn_akt
	END

CLOSE i_cursor
DEALLOCATE i_cursor
*/
