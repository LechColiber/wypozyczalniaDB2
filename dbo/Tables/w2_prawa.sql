CREATE TABLE [dbo].[w2_prawa] (
    [prawa_id]      INT          IDENTITY (1, 1) NOT NULL,
    [nazwa]         VARCHAR (50) NOT NULL,
    [stan_domyslny] BIT          CONSTRAINT [DF_w2_prawa_stan_domyslny] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_w2_prawa] PRIMARY KEY CLUSTERED ([prawa_id] ASC)
);

