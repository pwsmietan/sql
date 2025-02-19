SELECT  SERVERPROPERTY('productversion'), SERVERPROPERTY ('productlevel'), SERVERPROPERTY ('edition')

use Tech_Grp
go
select * from sys.tables where substring(name,1,5) <> 'aspnet'
go

select substring(name,1,3) from sys.tables


select * from sys.tables where name not like 'asp%' order by name

CREATE TABLE doc_exa (column_a INT) ;
GO
ALTER TABLE doc_exa ADD column_b int NULL ;
GO
EXEC sp_help doc_exa ;
GO
DROP TABLE doc_exa ;
GO

