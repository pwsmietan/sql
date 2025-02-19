SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Paul Smietan
-- Create date: 
-- Description:	
-- =============================================
ALTER PROCEDURE FixID
	@myTable nvarchar(40),
	@myIdCol nvarchar(40)
AS
BEGIN
	SET NOCOUNT ON
	print 'Table: ' + @myTable
	EXECUTE('DECLARE c1 CURSOR FOR SELECT * FROM ' + @myTable);
	
	OPEN c1
	FETCH NEXT FROM c1
	DECLARE @TmpID as int
	set @TmpID=0;
	
	-- Traverse each record using cursor and update column's value.
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'ID: ' + CAST(@TmpID AS NVARCHAR)
		EXECUTE('UPDATE ' + @myTable + ' SET ' + @myIdCol + '=' +  @TmpID + ' WHERE CURRENT OF c1')
		FETCH NEXT FROM c1
		set @TmpID = @TmpID + 1
	END

	CLOSE c1
	DEALLOCATE c1
END
GO