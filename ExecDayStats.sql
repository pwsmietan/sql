USE [DB_99100_bulzi]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[DayStats]
		@targetDate = '4/7/2016'

SELECT	'Return Value' = @return_value

GO
