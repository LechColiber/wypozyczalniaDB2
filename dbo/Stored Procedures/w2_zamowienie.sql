-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[w2_zamowienie]
	-- Add the parameters for the stored procedure here
		@zasob_id int,
		@uzytk_id int,
		@pracown_id int,
		@uwagi varchar(max),
		@rezultat TINYINT = 0 OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- 0 - oczekuje
	-- 1 - zrealizowane
	-- 2 - rezygnacja
	-- 3 - przygotowane

    -- Insert statements for procedure here
	
	IF NOT EXISTS (SELECT 1 FROM dbo.w2_zamowienia WHERE uzytk_id = @uzytk_id AND zasob_id = @zasob_id AND stan_zamow IN ('0', '3'))
	BEGIN
		INSERT INTO dbo.w2_zamowienia (zasob_id, uzytk_id, pracown_id_zamow, stan_zamow, uwagi, data_zamow) 
		VALUES (@zasob_id, @uzytk_id, @pracown_id, '0', @uwagi, GETDATE());	

		SET @rezultat = 1;
	END
END
