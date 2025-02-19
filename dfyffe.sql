USE [Tech_Grp]
GO
/****** Object:  StoredProcedure [dbo].[FixID]    Script Date: 07/17/2007 09:52:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FixID] (@fixTab nvarchar(40))
AS
DECLARE @SQLStatement varchar (4096)
DECLARE @ParmDefinition nvarchar(500);

SET @SQLStatement = '
DECLARE @TmpID as int

DECLARE c1 CURSOR FAST_FORWARD READ_ONLY
      FOR SELECT TGID FROM @fixTab

OPEN c1
FETCH NEXT FROM c1 INTO @TmpID

set @TmpID=0;
PRINT ''Starting ID: '' + @TmpID  -- dfyffe: need double quotes here since we’re already nested in single quotes.

WHILE @@FETCH_STATUS = 0
BEGIN
      UPDATE '+@fixTab+'             -- dfyffe: Need to concatenate the variable into the string here.
        SET TGID = @TmpID WHERE CURRENT OF c1
      FETCH NEXT FROM c1
      set @TmpID = @TmpID + 1
END

CLOSE c1
DEALLOCATE c1
'

--Dfyffe:  you can also additionally PRINT or SELECT @SQLStatement here for debugging purposes.
--EXECUTE @SQLStatement

SET @ParmDefinition = N'@fixTab nvarchar';
exec sp_executesql @SQLStatement, @ParmDefinition, @fixTab

--sp_executesql

exec FixID 'Adder'
