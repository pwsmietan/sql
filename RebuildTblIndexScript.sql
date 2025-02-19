USE M2k
DECLARE @TableName varchar(255)
DECLARE TableCursor CURSOR FOR

SELECT table_name FROM information_schema.tables
WHERE table_type = 'base table'

OPEN TableCursor
	FETCH NEXT FROM TableCursor INTO @TableName

WHILE @@FETCH_STATUS = 0
BEGIN
	if( charindex(@TableName, 'Table') = 0)
	begin
		print @TableName
		DBCC DBREINDEX(@TableName,' ',90)
		FETCH NEXT FROM TableCursor INTO @TableName
	end 
END

CLOSE TableCursor

DEALLOCATE TableCursor


OR:

DECLARE @id INT
SET @id = 0
UPDATE AreaCodes
SET @id = id = @id + 1
GO

---
drop column and then:
ALTER TABLE AreaCodes ADD id INT IDENTITY(1,1)
GO
