CREATE TABLE [dbo].[w2_uzytkownicy] (
    [uzytk_id]        INT           IDENTITY (1, 1) NOT NULL,
    [uzytk_id_parent] INT           NULL,
    [typuzytk_id]     INT           NULL,
    [grupa_id]        INT           NULL,
    [kod_kresk]       VARCHAR (25)  NULL,
    [nazwa]           VARCHAR (50)  NULL,
    [data_urodz]      DATETIME      NULL,
    [plec]            BIT           NULL,
    [data_wpis]       DATETIME      CONSTRAINT [DF_uzytkownicy_data_wpis] DEFAULT (getdate()) NULL,
    [data_wyrejestr]  DATETIME      NULL,
    [uwagi]           TEXT          NULL,
    [limit_czasu]     SMALLINT      CONSTRAINT [DF_uzytkownicy_limit_czasu] DEFAULT ((30)) NOT NULL,
    [limit_ilosci]    SMALLINT      CONSTRAINT [DF_uzytkownicy_limit_ilosci] DEFAULT ((5)) NOT NULL,
    [zablokowany]     BIT           CONSTRAINT [DF_uzytkownicy_zablokowany] DEFAULT ((0)) NOT NULL,
    [nr_legitym]      VARCHAR (15)  NULL,
    [domena_nazwa]    VARCHAR (50)  NULL,
    [dzial]           VARCHAR (100) NULL,
    CONSTRAINT [PK_uzytkownicy] PRIMARY KEY CLUSTERED ([uzytk_id] ASC),
    CONSTRAINT [FK_uzytkownicy_typy_uzytk] FOREIGN KEY ([typuzytk_id]) REFERENCES [dbo].[w2_typy_uzytk] ([typuzytk_id]),
    CONSTRAINT [FK_uzytkownicy_uzytkownicy] FOREIGN KEY ([uzytk_id_parent]) REFERENCES [dbo].[w2_uzytkownicy] ([uzytk_id])
);


GO
CREATE NONCLUSTERED INDEX [IX_uzytkownicy_grupa_id]
    ON [dbo].[w2_uzytkownicy]([grupa_id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_uzytkownicy_kod_kresk]
    ON [dbo].[w2_uzytkownicy]([kod_kresk] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_uzytkownicy_nazwa]
    ON [dbo].[w2_uzytkownicy]([nazwa] ASC);

