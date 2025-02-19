SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Paul Smietan
-- Create date: 17-JUL-2008
-- Description:	Check for existance of a table.
-- =============================================
ALTER FUNCTION IsTable
(
	@TableName nvarchar(50)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar int

	-- Add the T-SQL statements to compute the return value here
	IF OBJECT_ID(@TableName) IS NOT NULL 
		SET @ResultVar = 0
	ELSE
		SET @ResultVar = -1

	-- Return the result of the function
	RETURN @ResultVar

END
GO

