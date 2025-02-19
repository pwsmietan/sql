select * from sys.tables

SELECT  'DROP TABLE [' + name + '];'
FROM    sys.tables


EXEC sp_MSforeachtable @command1 = "DROP TABLE ?"