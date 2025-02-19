USE Northwind
GO

SET NOCOUNT ON

DECLARE @sql1 varchar(8000), @sql2 varchar(8000), @TABLE_NAME sysname, @TABLE_SCHEMA sysname

DECLARE myCursor99 CURSOR 
  FOR 
 SELECT TABLE_SCHEMA, TABLE_NAME 
   FROM INFORMATION_SCHEMA.Tables 
  WHERE TABLE_TYPE = 'BASE TABLE'
    AND TABLE_NAME LIKE 'O%'

OPEN myCursor99
FETCH NEXT FROM myCursor99 INTO @TABLE_SCHEMA, @TABLE_NAME

WHILE @@FETCH_STATUS = 0
  BEGIN

 SELECT @sql2 = ' UNION ALL SELECT ', @sql1 = null
 
 SELECT @sql1 = COALESCE(@sql1 + ', '+''''+'"'+''''+'+'+'''','') + COLUMN_NAME + ''''+'+'+''''+'"'+''''+' AS '+ COLUMN_NAME
   FROM INFORMATION_SCHEMA.Columns
  WHERE TABLE_NAME = @TABLE_NAME
    AND TABLE_SCHEMA = @TABLE_SCHEMA
 
 SELECT @sql2 = CASE 
       WHEN DATA_TYPE IN ('datetime','smalldatetime')
       THEN @sql2 + ', '+''''+'"'+''''+'+CONVERT(varchar(24),' + COLUMN_NAME + ',126)+' + ''''+ '"' + '''' + 'AS ' + COLUMN_NAME
       WHEN DATA_TYPE IN ('bigint','int','smallint','tinyint','money','float','real')
       THEN @sql2 + ', '+''''+'"'+''''+'+CONVERT(varchar(15),' + COLUMN_NAME + ')+' + ''''+ '"' + '''' + 'AS ' + COLUMN_NAME
       WHEN DATA_TYPE IN ('char','varchar','nchar','nvarchar')
       THEN @sql2 + ', '+''''+'"'+''''+'+' + COLUMN_NAME + '+' + ''''+ '"' + '''' + 'AS ' + COLUMN_NAME
         END
   FROM INFORMATION_SCHEMA.Columns
  WHERE TABLE_NAME = @TABLE_NAME
    AND TABLE_SCHEMA = @TABLE_SCHEMA
 
 SELECT @sql1 = 'CREATE VIEW ' + REPLACE('['+@TABLE_SCHEMA+'].[v_'+@TABLE_NAME+'_99]',' ','_') 
   + ' AS SELECT '+''''+'"'+''''+'+'+''''
   + @sql1 + REPLACE(@sql2,'UNION ALL SELECT ,','UNION ALL SELECT ') 
   + ' FROM ['+@TABLE_SCHEMA+'].['+@TABLE_NAME+']'
 
 SELECT @sql1
 
 EXEC(@sql1)
 
-- SELECT * FROM myView99
 
 DECLARE @cmd varchar(8000)
 
 SELECT @cmd = 'bcp ' + db_name() + '.' + REPLACE('['+@TABLE_SCHEMA+'].[v_'+@TABLE_NAME+'_99] ',' ','_')
   +' OUT '
   +REPLACE(@TABLE_SCHEMA+'_'+@TABLE_NAME,' ','_')
   +'_hdr.txt -c -S -Usa -P'
 SELECT @cmd 
 EXEC master..xp_cmdshell @cmd
 
 SELECT @sql2 = 'DROP VIEW ' + REPLACE('['+@TABLE_SCHEMA+'].[v_'+@TABLE_NAME+'_99]',' ','_')
 EXEC(@sql2)

 FETCH NEXT FROM myCursor99 INTO @TABLE_SCHEMA, @TABLE_NAME
  END
CLOSE myCursor99
DEALLOCATE myCursor99
GO

