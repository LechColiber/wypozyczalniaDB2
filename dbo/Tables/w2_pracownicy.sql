CREATE TABLE [dbo].[w2_pracownicy] (
    [pracown_id]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [login]              VARCHAR (20) NOT NULL,
    [haslo]              VARCHAR (40) NOT NULL,
    [imie]               VARCHAR (20) NOT NULL,
    [nazwisko]           VARCHAR (30) NOT NULL,
    [waznosc_hasla]      SMALLINT     CONSTRAINT [DF_pracownicy_waznosc_hasla] DEFAULT ((0)) NOT NULL,
    [data_zm_hasla]      DATETIME     CONSTRAINT [DF_pracownicy_data_zm_hasla] DEFAULT (getdate()) NOT NULL,
    [logow_awar]         TINYINT      CONSTRAINT [DF_pracownicy_logow_awar] DEFAULT ((5)) NOT NULL,
    [licznik_logow_awar] TINYINT      CONSTRAINT [DF_pracownicy_licznik_logow_awar] DEFAULT ((0)) NOT NULL,
    [uwagi]              TEXT         NULL,
    [ustawienia]         TEXT         NULL,
    [deleted]            BIT          NOT NULL,
    [obcy_id]            INT          NULL,
    CONSTRAINT [PK_pracownicy] PRIMARY KEY CLUSTERED ([pracown_id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_pracownicy_login]
    ON [dbo].[w2_pracownicy]([login] ASC);

