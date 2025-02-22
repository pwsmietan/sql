USE [GoImage]
GO
/****** Object:  UserDefinedFunction [dbo].[IsMatch]    Script Date: 07/17/2008 03:42:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Paul W. Smietan
-- Create date: 08-JUL-2008
-- Description:	Returns boolean (TRUE) if two strings match.
-- =============================================
ALTER FUNCTION [dbo].[IsMatch]
(
	@str1 nvarchar (50),
	@str2 nvarchar (50)
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result bit

	if( upper(substring(@str1,1,len(@str2))) = upper(@str2) )
		set @result = 1
	else
		set @result = 0
	
	-- Return the result of the function
	RETURN @result

END
