CREATE TABLE [dbo].[pracow] (
    [id_uzyt]    NUMERIC (7)   NOT NULL,
    [data_wpisu] DATETIME      NULL,
    [data_wyk]   DATETIME      NULL,
    [nazwisko]   VARCHAR (40)  NULL,
    [imie]       VARCHAR (20)  NULL,
    [dzial]      VARCHAR (100) NULL,
    [tel_sluz]   VARCHAR (15)  NULL,
    [poczta]     VARCHAR (6)   NULL,
    [miasto]     VARCHAR (20)  NULL,
    [adres]      VARCHAR (40)  NULL,
    [tel_dom]    VARCHAR (20)  NULL,
    [nr_legitym] VARCHAR (15)  NULL,
    [odwiedziny] VARCHAR (50)  NULL,
    [data_w_rok] DATETIME      NULL,
    [ilosc_w_k]  NUMERIC (3)   NULL,
    [ilosc_w_c]  NUMERIC (3)   NULL,
    [ilosc_z_k]  NUMERIC (3)   NULL,
    [ilosc_z_c]  NUMERIC (3)   NULL
);

