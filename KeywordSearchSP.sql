USE [GoImage]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GIKeywordSearch]    Script Date: 06/18/2008 20:51:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Paul W. Smietan
-- Create date: 17-JUN-2008
-- Description:	GoImage Keyword Search
-- =============================================
ALTER PROCEDURE [dbo].[Sp_GIKeywordSearch] 
(
	@firstName nvarchar(50), 
	@lastName nvarchar(50),
	@dateOfBirth datetime,
	@genderCode tinyint,
	@zipcode nvarchar(50),
	@podLocation nvarchar(40),
	@formNumber int
)
AS
	DECLARE @sqlWhere nvarchar(6)
	DECLARE @sqlQuery nvarchar(256)
	DECLARE @sqlQueryFinal nvarchar(256)
	DECLARE @fIsPrevious tinyint
	DECLARE @ins nvarchar(50)
	DECLARE @TRUE tinyint
	DECLARE @FALSE tinyint
	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @TRUE = 1
	SET @FALSE = 0
	SET @fIsPrevious = @FALSE
	SET @sqlWhere = 'Where '
	SET @sqlQuery = 'SELECT * FROM GoImageMaster Where '
	
	-- Concatenate SQL query string for each argument that is not empty.
	if( len(@firstName) > 0 ) 
	begin
		SET @sqlQuery = @sqlQuery + 'firstName=''' + @firstName + ''''
		SET @fIsPrevious = @TRUE
	end
		
	if( len(@lastName) > 0 )
	begin
		if( @fIsPrevious = @TRUE )
			SET @ins = ' AND lastName='
		else
			SET @ins = 'lastName='
			SET @fIsPrevious = @TRUE

		SET @sqlQuery = @sqlQuery + @ins + '''' + @lastName + ''''
	end

	if( len(@dateOfBirth) > 0 )
	begin
		if( @fIsPrevious = @TRUE )
			SET @ins = ' AND dateOfBirth='
		else
			SET @ins = 'dateOfBirth='
			SET @fIsPrevious = @TRUE

		SET @sqlQuery = @sqlQuery + @ins + '''' + cast(@dateOfBirth as nvarchar) + ''''
	end

	if( len(@genderCode) > 0 )
	begin
		if( @fIsPrevious = @TRUE )
			SET @ins = ' AND genderCode='
		else
			SET @ins = 'genderCode='
			SET @fIsPrevious = @TRUE

		SET @sqlQuery = @sqlQuery + @ins + cast(@genderCode as nvarchar) + ''
	end

	if( len(@zipcode) > 0 )
	begin
		if( @fIsPrevious = @TRUE )
			SET @ins = ' AND zipcode='
		else
			SET @ins = 'zipcode='
			SET @fIsPrevious = @TRUE

		SET @sqlQuery = @sqlQuery + @ins + '''' + @zipcode + ''''
	end

	if( len(@podLocation) > 0 )
	begin
		if( @fIsPrevious = @TRUE )
			SET @ins = ' AND podLocation='
		else
			SET @ins = 'podLocation='
			SET @fIsPrevious = @TRUE

		SET @sqlQuery = @sqlQuery + @ins + '''' + @podLocation + ''''
	end

	if( len(@formNumber) > 0 )
	begin
		if( @fIsPrevious = @TRUE )
			SET @ins = ' AND formNumber='
		else
			SET @ins = ' formNumber='
			SET @fIsPrevious = @TRUE

		SET @sqlQuery = @sqlQuery + @ins + cast(@formNumber as nvarchar) + ''
	end

	-- Fix-up SQL query string if the character vector contains trailing "Where" clause.
	-- This accomodates the situation where all 'null' values were passed in as arguments.
	if( substring( @sqlQuery, len(@sqlQuery) - len(@sqlWhere), len(@sqlWhere)) = @sqlWhere )
		SET @sqlQueryFinal = substring( @sqlQuery, 1, len(@sqlQuery) - len(@sqlWhere) )
	else
		SET @sqlQueryFinal = @sqlQuery

	BEGIN TRY
		exec(@sqlQueryFinal)
	END TRY
	BEGIN CATCH
		SELECT 
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END
