CREATE TABLE [dbo].[w2_zasoby_grupa] (
    [zasob_id] INT NOT NULL,
    [grupa_id] INT NOT NULL,
    CONSTRAINT [PK_w2_zasoby_grupa] PRIMARY KEY CLUSTERED ([zasob_id] ASC, [grupa_id] ASC),
    CONSTRAINT [FK_w2_zasoby_grupa_w2_zasoby] FOREIGN KEY ([zasob_id]) REFERENCES [dbo].[w2_zasoby_t] ([zasob_id]) ON DELETE CASCADE ON UPDATE CASCADE
);

