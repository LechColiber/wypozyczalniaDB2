CREATE TABLE [dbo].[w2_prawa_grupy_u] (
    [prawa_id] INT NOT NULL,
    [grupa_id] INT NOT NULL,
    [wartosc]  BIT NULL,
    CONSTRAINT [PK_w2_prawa_grupy_u] PRIMARY KEY CLUSTERED ([prawa_id] ASC, [grupa_id] ASC),
    CONSTRAINT [FK_prawa_grupy_u_w2_grupy_u] FOREIGN KEY ([grupa_id]) REFERENCES [dbo].[w2_grupy_u] ([grupa_id])
);

