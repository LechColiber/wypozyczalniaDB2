CREATE TABLE [dbo].[w2_upomnienia] (
    [upomn_id]       INT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [wypoz_id]       INT      NULL,
    [uzytk_id]       INT      NULL,
    [data_upomn]     DATETIME NULL,
    [data_zwr_upomn] DATETIME NULL,
    [uwagi]          TEXT     NULL,
    CONSTRAINT [PK_upomnienia] PRIMARY KEY CLUSTERED ([upomn_id] ASC),
    CONSTRAINT [FK_upomnienia_uzytkownicy] FOREIGN KEY ([uzytk_id]) REFERENCES [dbo].[w2_uzytkownicy] ([uzytk_id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_upomnienia_wypozyczenia] FOREIGN KEY ([wypoz_id]) REFERENCES [dbo].[w2_wypozyczenia] ([wypoz_id])
);

