USE [Tech_Grp]
GO
/****** Object:  StoredProcedure [dbo].[FixID]    Script Date: 07/17/2007 09:52:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FixID] (@fixID varchar(40))
AS
print 'Table: ' + @fixID
DECLARE @TmpID as int
DECLARE c1 CURSOR FAST_FORWARD READ_ONLY
	FOR SELECT TGID FROM fixID

OPEN c1
FETCH NEXT FROM c1 INTO @TmpID

set @TmpID=0;
PRINT 'Starting ID: ' + @TmpID

WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE fixID
	  SET TGID = @TmpID WHERE CURRENT OF c1
	FETCH NEXT FROM c1
	set @TmpID = @TmpID + 1
END

CLOSE c1
DEALLOCATE c1
