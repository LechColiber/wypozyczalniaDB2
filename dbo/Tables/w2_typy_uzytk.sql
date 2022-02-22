CREATE TABLE [dbo].[w2_typy_uzytk] (
    [typuzytk_id] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [nazwa]       VARCHAR (50) NOT NULL,
    [aktywny]     BIT          CONSTRAINT [DF_typy_uzytk_aktywny] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_typy_uzytk] PRIMARY KEY CLUSTERED ([typuzytk_id] ASC)
);

