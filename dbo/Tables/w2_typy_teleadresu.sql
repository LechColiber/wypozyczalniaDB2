CREATE TABLE [dbo].[w2_typy_teleadresu] (
    [typteleadr_id] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [nazwa]         VARCHAR (50) NULL,
    CONSTRAINT [PK_typy_teleadresu] PRIMARY KEY CLUSTERED ([typteleadr_id] ASC)
);

