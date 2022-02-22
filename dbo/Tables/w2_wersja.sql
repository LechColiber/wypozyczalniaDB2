CREATE TABLE [dbo].[w2_wersja] (
    [baza]             INT      NOT NULL,
    [dataWprowadzenia] DATETIME DEFAULT (getdate()) NULL
);


GO
CREATE TRIGGER [dbo].[w2updateDataWersji]
ON [dbo].[w2_wersja]
FOR UPDATE

AS
BEGIN
UPDATE dbo.w2_wersja SET dataWprowadzenia = GETDATE()

END

