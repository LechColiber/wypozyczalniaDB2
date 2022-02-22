CREATE TABLE [dbo].[w2_teleadresy] (
    [teleadr_id]     INT          IDENTITY (1, 1) NOT NULL,
    [uzytk_id]       INT          NULL,
    [pracown_id]     INT          NULL,
    [typteleadr_id]  INT          NULL,
    [wartosc]        VARCHAR (80) NULL,
    [stan]           CHAR (1)     NULL,
    [data_wprow]     DATETIME     NULL,
    [pracown_id_wpr] INT          NULL,
    [uwagi]          TEXT         NULL,
    CONSTRAINT [PK_teleadresy] PRIMARY KEY CLUSTERED ([teleadr_id] ASC),
    CONSTRAINT [FK_teleadresy_pracownicy] FOREIGN KEY ([pracown_id]) REFERENCES [dbo].[w2_pracownicy] ([pracown_id]),
    CONSTRAINT [FK_teleadresy_pracownicy1] FOREIGN KEY ([pracown_id_wpr]) REFERENCES [dbo].[w2_pracownicy] ([pracown_id]),
    CONSTRAINT [FK_teleadresy_typy_teleadresu] FOREIGN KEY ([typteleadr_id]) REFERENCES [dbo].[w2_typy_teleadresu] ([typteleadr_id]),
    CONSTRAINT [FK_teleadresy_uzytkownicy] FOREIGN KEY ([uzytk_id]) REFERENCES [dbo].[w2_uzytkownicy] ([uzytk_id])
);


GO
CREATE NONCLUSTERED INDEX [IX_teleadresy_pracown_id]
    ON [dbo].[w2_teleadresy]([pracown_id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_teleadresy_uzytk_id]
    ON [dbo].[w2_teleadresy]([uzytk_id] ASC);

