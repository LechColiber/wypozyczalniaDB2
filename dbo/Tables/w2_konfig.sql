CREATE TABLE [dbo].[w2_konfig] (
    [id]     INT           IDENTITY (1, 1) NOT NULL,
    [nazwa]  VARCHAR (50)  NOT NULL,
    [typ]    CHAR (1)      CONSTRAINT [DF_wkonfig_typ] DEFAULT ('C') NOT NULL,
    [wart_C] VARCHAR (255) NULL,
    [wart_D] DATETIME      NULL,
    [wart_N] NUMERIC (18)  NULL,
    [wart_L] BIT           NULL,
    CONSTRAINT [PK_w2_konfig] PRIMARY KEY CLUSTERED ([id] ASC)
);

