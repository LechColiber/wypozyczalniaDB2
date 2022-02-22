CREATE TABLE [dbo].[w2_prawa_grupy_z] (
    [prawa_id] INT NOT NULL,
    [grupa_id] INT NOT NULL,
    [wartosc]  BIT NULL,
    CONSTRAINT [PK_w2_prawa_grupy_z] PRIMARY KEY CLUSTERED ([prawa_id] ASC, [grupa_id] ASC)
);

