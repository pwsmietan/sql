CREATE FUNCTION dbo.presentDiffInHHMMSS
(
@date1 DATETIME,
@date2 DATETIME
)
RETURNS VARCHAR(32)
AS
BEGIN
DECLARE @sD INT, @sR INT, @mD INT, @mR INT, @hR INT
SET @sD = DATEDIFF(SECOND, @date1, @date2)
SET @sR = @sD % 60
SET @mD = (@sD - @sR) / 60
SET @mR = @mD % 60
SET @hR = (@mD - @mR) / 60

RETURN CONVERT(VARCHAR, @hR)
+':'+RIGHT('00'+CONVERT(VARCHAR, @mR), 2)
+':'+RIGHT('00'+CONVERT(VARCHAR, @sR), 2)
END

Usage:

DECLARE @dt DATETIME
SET @dt = '2001-04-30 17:04:32'
PRINT dbo.presentDiffInHHMMSS(@dt, GETDATE())

DROP  FUNCTION dbo.presentDiffInHHMMSS 
 
