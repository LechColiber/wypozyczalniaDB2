CREATE TABLE [dbo].[w2_uprawnienia_u] (
    [upraw_id]    UNIQUEIDENTIFIER CONSTRAINT [DF_w2_uprawnienia_u_upraw_id] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [uzytk_id]    INT              NOT NULL,
    [prawa_id]    INT              NOT NULL,
    [data_od]     DATETIME         CONSTRAINT [DF_w2_uprawnienia_u_data_od] DEFAULT (getdate()) NOT NULL,
    [data_do]     DATETIME         CONSTRAINT [DF_w2_uprawnienia_u_data_do] DEFAULT (dateadd(year,(25),getdate())) NOT NULL,
    [zablokowane] BIT              CONSTRAINT [DF_w2_uprawnienia_u_zablokowane] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_w2_uprawnienia_u] PRIMARY KEY CLUSTERED ([upraw_id] ASC),
    CONSTRAINT [FK_w2_uprawnienia_u_w2_uzytkownicy] FOREIGN KEY ([uzytk_id]) REFERENCES [dbo].[w2_uzytkownicy] ([uzytk_id])
);

