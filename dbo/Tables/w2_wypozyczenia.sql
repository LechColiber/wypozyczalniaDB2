CREATE TABLE [dbo].[w2_wypozyczenia] (
    [wypoz_id]         INT      IDENTITY (1, 1) NOT NULL,
    [zasob_id]         INT      NULL,
    [uzytk_id]         INT      NULL,
    [grupa_id]         INT      NULL,
    [pracown_id_wypoz] INT      NULL,
    [data_wypoz]       DATETIME CONSTRAINT [DF_wypozyczenia_data_wypoz] DEFAULT (getdate()) NULL,
    [pracown_id_zwrot] INT      NULL,
    [data_zwrot]       DATETIME NULL,
    [limit_czasu]      SMALLINT NULL,
    [stan_wypoz]       CHAR (1) NULL,
    [uwagi]            TEXT     NULL,
    CONSTRAINT [PK_wypozyczenia] PRIMARY KEY CLUSTERED ([wypoz_id] ASC),
    CONSTRAINT [FK_wypozyczenia_pracownicy] FOREIGN KEY ([pracown_id_wypoz]) REFERENCES [dbo].[w2_pracownicy] ([pracown_id]),
    CONSTRAINT [FK_wypozyczenia_pracownicy1] FOREIGN KEY ([pracown_id_zwrot]) REFERENCES [dbo].[w2_pracownicy] ([pracown_id])
);


GO
CREATE NONCLUSTERED INDEX [IX_wypozyczenia_uzytk_id]
    ON [dbo].[w2_wypozyczenia]([uzytk_id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_wypozyczenia_zasob_id]
    ON [dbo].[w2_wypozyczenia]([zasob_id] ASC);

