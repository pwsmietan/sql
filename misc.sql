select * from DP_Config_Group
select * from DP_Config_Table
select * from DP_Config_Table_SQL
select * from DP_Config_Template

declare @parameter1 nvarchar(50)
declare @parameter2 nvarchar(50)
exec('exec OPENDATASOURCE(''sqloledb'',''Data Source=servername; User ID=loginid;Password=password'').databasename.schema.storedprocedurename''' + @parameter1 +''','+ @parameter2 +'')