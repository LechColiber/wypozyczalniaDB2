CREATE TABLE [dbo].[w2_adresy] (
    [adres_id]       INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [uzytk_id]       INT          NULL,
    [pracown_id]     INT          NULL,
    [typadr_id]      INT          NULL,
    [miejscowosc]    VARCHAR (40) NULL,
    [ulica]          VARCHAR (30) NULL,
    [nr_domu]        VARCHAR (6)  NULL,
    [nr_lokalu]      VARCHAR (6)  NULL,
    [kod_poczt]      CHAR (5)     NULL,
    [poczta]         VARCHAR (40) NULL,
    [stan]           CHAR (1)     NULL,
    [data_wprow]     DATETIME     CONSTRAINT [DF_adresy_data_wprow] DEFAULT (getdate()) NULL,
    [pracown_id_wpr] INT          NULL,
    [uwagi]          TEXT         NULL,
    CONSTRAINT [PK_adresy] PRIMARY KEY CLUSTERED ([adres_id] ASC),
    CONSTRAINT [FK_adresy_pracownicy] FOREIGN KEY ([pracown_id]) REFERENCES [dbo].[w2_pracownicy] ([pracown_id]),
    CONSTRAINT [FK_adresy_pracownicy1] FOREIGN KEY ([pracown_id_wpr]) REFERENCES [dbo].[w2_pracownicy] ([pracown_id]),
    CONSTRAINT [FK_adresy_typy_adresu] FOREIGN KEY ([typadr_id]) REFERENCES [dbo].[w2_typy_adresu] ([typadr_id]),
    CONSTRAINT [FK_adresy_uzytkownicy] FOREIGN KEY ([uzytk_id]) REFERENCES [dbo].[w2_uzytkownicy] ([uzytk_id])
);


GO
CREATE NONCLUSTERED INDEX [IX_adresy_pracown_id]
    ON [dbo].[w2_adresy]([pracown_id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_adresy_uzytk_id]
    ON [dbo].[w2_adresy]([uzytk_id] ASC);

