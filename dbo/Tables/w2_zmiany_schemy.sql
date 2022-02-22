CREATE TABLE [dbo].[w2_zmiany_schemy] (
    [id]                 INT          IDENTITY (1, 1) NOT NULL,
    [MajorReleaseNumber] VARCHAR (2)  NULL,
    [MinorReleaseNumber] VARCHAR (2)  NULL,
    [PointReleaseNumber] VARCHAR (4)  NULL,
    [NazwaSkryptu]       VARCHAR (50) NULL,
    [DataWprowadzenia]   DATETIME     DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

