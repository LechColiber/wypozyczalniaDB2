CREATE TABLE [dbo].[w2_zamowienia] (
    [zamow_id]          INT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [zasob_id]          INT      NULL,
    [uzytk_id]          INT      NULL,
    [grupa_id]          INT      NULL,
    [pracown_id_zamow]  INT      NULL,
    [data_zamow]        DATETIME CONSTRAINT [DF_zamowienia_data_zamow] DEFAULT (getdate()) NULL,
    [pracown_id_realiz] INT      NULL,
    [data_realiz]       DATETIME NULL,
    [limit_czasu]       SMALLINT NULL,
    [stan_zamow]        CHAR (1) NULL,
    [uwagi]             TEXT     NULL,
    CONSTRAINT [PK_zamowienia] PRIMARY KEY CLUSTERED ([zamow_id] ASC),
    CONSTRAINT [FK_zamowienia_pracownicy] FOREIGN KEY ([pracown_id_zamow]) REFERENCES [dbo].[w2_pracownicy] ([pracown_id]),
    CONSTRAINT [FK_zamowienia_pracownicy1] FOREIGN KEY ([pracown_id_realiz]) REFERENCES [dbo].[w2_pracownicy] ([pracown_id]),
    CONSTRAINT [FK_zamowienia_uzytkownicy] FOREIGN KEY ([uzytk_id]) REFERENCES [dbo].[w2_uzytkownicy] ([uzytk_id]),
    CONSTRAINT [FK_zamowienia_zasoby] FOREIGN KEY ([zasob_id]) REFERENCES [dbo].[w2_zasoby_t] ([zasob_id]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_zamowienia_uzytk_id]
    ON [dbo].[w2_zamowienia]([uzytk_id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_zamowienia_zasob_id]
    ON [dbo].[w2_zamowienia]([zasob_id] ASC);

