CREATE TABLE [dbo].[w2_grupy_z] (
    [grupa_id]    INT          IDENTITY (1, 1) NOT NULL,
    [nazwa]       VARCHAR (50) NULL,
    [uwagi]       TEXT         NULL,
    [aktywna]     BIT          NULL,
    [limit_czasu] SMALLINT     NULL,
    CONSTRAINT [PK_w2_grupy_z] PRIMARY KEY CLUSTERED ([grupa_id] ASC)
);


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[w2_grupy_z_ut]
   ON  [dbo].[w2_grupy_z]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	UPDATE dbo.w2_zasoby_t 
		SET 
			limit_czas = ins.limit_czasu
		FROM inserted ins
	WHERE dbo.w2_zasoby_t.grupa_id = ins.grupa_id;
END
