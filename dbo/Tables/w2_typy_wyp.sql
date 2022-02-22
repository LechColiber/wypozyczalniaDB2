CREATE TABLE [dbo].[w2_typy_wyp] (
    [typw_id] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [nazwa]   VARCHAR (50) NULL,
    [stan]    VARCHAR (50) NULL,
    CONSTRAINT [PK_typy_wyp] PRIMARY KEY CLUSTERED ([typw_id] ASC)
);

