CREATE TABLE [dbo].[w2_rozliczenia] (
    [rozlicz_id]   INT       IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [wypoz_id]     INT       NULL,
    [pozcennik_id] INT       NULL,
    [data_rozlicz] CHAR (10) NULL,
    [wartosc]      MONEY     NULL,
    [waluta]       CHAR (1)  NULL,
    [stan]         CHAR (1)  NULL,
    [uwagi]        TEXT      NULL,
    CONSTRAINT [PK_rozliczenia] PRIMARY KEY CLUSTERED ([rozlicz_id] ASC),
    CONSTRAINT [FK_rozliczenia_pozycje_cennika] FOREIGN KEY ([pozcennik_id]) REFERENCES [dbo].[w2_pozycje_cennika] ([pozcennik_id])
);

