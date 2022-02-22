CREATE TABLE [dbo].[w2_typy_adresu] (
    [typadr_id] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [nazwa]     VARCHAR (50) NULL,
    CONSTRAINT [PK_typy_adresu] PRIMARY KEY CLUSTERED ([typadr_id] ASC)
);

