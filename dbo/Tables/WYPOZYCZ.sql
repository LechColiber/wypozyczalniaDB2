CREATE TABLE [dbo].[WYPOZYCZ] (
    [id]         INT          IDENTITY (1, 1) NOT NULL,
    [id_zasob]   INT          NOT NULL,
    [id_uzyt]    NUMERIC (7)  NOT NULL,
    [rodzaj_poz] NUMERIC (1)  NULL,
    [kod]        NUMERIC (7)  NULL,
    [syg]        VARCHAR (20) NULL,
    [data_wyp]   DATETIME     NULL,
    [data_przew] DATETIME     NULL,
    [data_upom]  DATETIME     NULL,
    [data_zwr]   DATETIME     NULL,
    [kto_wzial]  VARCHAR (62) NULL
);

