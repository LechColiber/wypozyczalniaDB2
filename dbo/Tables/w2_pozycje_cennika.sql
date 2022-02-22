CREATE TABLE [dbo].[w2_pozycje_cennika] (
    [pozcennik_id] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [nazwa]        VARCHAR (50) NOT NULL,
    [wartosc]      MONEY        NOT NULL,
    [waluta]       CHAR (1)     NOT NULL,
    [cennik_id]    INT          NOT NULL,
    [uwagi]        TEXT         NULL,
    CONSTRAINT [PK_pozycje_cennika] PRIMARY KEY CLUSTERED ([pozcennik_id] ASC),
    CONSTRAINT [FK_pozycje_cennika_cenniki] FOREIGN KEY ([cennik_id]) REFERENCES [dbo].[w2_cenniki] ([cennik_id]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_pozycje_cennika_cennik_id]
    ON [dbo].[w2_pozycje_cennika]([cennik_id] ASC);

