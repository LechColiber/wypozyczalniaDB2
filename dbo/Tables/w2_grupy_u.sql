CREATE TABLE [dbo].[w2_grupy_u] (
    [grupa_id]     INT          IDENTITY (1, 1) NOT NULL,
    [nazwa]        VARCHAR (50) NOT NULL,
    [uwagi]        TEXT         NULL,
    [aktywna]      BIT          CONSTRAINT [DF_grupy_aktywna] DEFAULT ((1)) NOT NULL,
    [limit_czasu]  SMALLINT     NULL,
    [limit_ilosci] SMALLINT     NULL,
    CONSTRAINT [PK_grupy] PRIMARY KEY CLUSTERED ([grupa_id] ASC)
);


GO
CREATE TRIGGER [dbo].[w2_grupy_u_ut] on [dbo].[w2_grupy_u] AFTER UPDATE AS
BEGIN
	UPDATE dbo.w2_uzytkownicy
		SET
			dbo.w2_uzytkownicy.limit_czasu = ins.limit_czasu,
			dbo.w2_uzytkownicy.limit_ilosci = ins.limit_ilosci,
			dbo.w2_uzytkownicy.zablokowany = CASE WHEN ins.aktywna = 0 THEN 1 ELSE 0 END
		FROM inserted ins
	WHERE dbo.w2_uzytkownicy.grupa_id = ins.grupa_id;
END