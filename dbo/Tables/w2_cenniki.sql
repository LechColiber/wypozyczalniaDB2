CREATE TABLE [dbo].[w2_cenniki] (
    [cennik_id] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [nazwa]     VARCHAR (50) NOT NULL,
    [uwagi]     TEXT         NULL,
    CONSTRAINT [PK_cenniki] PRIMARY KEY CLUSTERED ([cennik_id] ASC)
);

