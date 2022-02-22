CREATE TABLE [dbo].[w2_uprawnienia_z] (
    [upraw_id]    UNIQUEIDENTIFIER CONSTRAINT [DF_w2_uprawnienia_z_upraw_id] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [zasob_id]    INT              NOT NULL,
    [prawa_id]    INT              NOT NULL,
    [data_od]     DATETIME         CONSTRAINT [DF_w2_uprawnienia_z_data_od] DEFAULT (getdate()) NOT NULL,
    [data_do]     DATETIME         CONSTRAINT [DF_w2_uprawnienia_z_data_do] DEFAULT (getdate()) NOT NULL,
    [zablokowane] BIT              CONSTRAINT [DF_w2_uprawnienia_z_zablokowane] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_w2_uprawnienia_z] PRIMARY KEY CLUSTERED ([upraw_id] ASC),
    CONSTRAINT [FK_w2_uprawnienia_z_w2_zasoby] FOREIGN KEY ([zasob_id]) REFERENCES [dbo].[w2_zasoby_t] ([zasob_id]) ON DELETE CASCADE ON UPDATE CASCADE
);

