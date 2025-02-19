DECLARE @xml XML ,
    @RowCount BIGINT
CREATE TABLE #Table
    (
      Column#1 INT ,
      Column2 NVARCHAR(MAX) ,
      Column3 DECIMAL(15, 2)
    )
CREATE TABLE #TempTable
    (
      RowID BIGINT ,
      CellId BIGINT ,
      Value NVARCHAR(MAX) ,
      ColumnName NVARCHAR(MAX)
    )
DECLARE @sSQl NVARCHAR(MAX)= 'SELECT (SELECT DISTINCT ColumnName FROM #TempTable WHERE CellId=Cell.CellId) as ColumnName,'
INSERT  INTO #Table
        SELECT  5 ,
                'Column_1_Test_String' ,
                99.99
INSERT  INTO #Table
        SELECT  9 ,
                'Column_2_Test_String' ,
                NULL


SET @xml = ( SELECT * ,
                    Row_Number() OVER ( ORDER BY ( SELECT   1
                                                 ) ) Rn
             FROM   #Table Row
           FOR
             XML AUTO,
                 ROOT('Root') ,
                 ELEMENTS XSINIL
           ) ;
WITH XMLNAMESPACES('http://www.w3.org/2001/XMLSchema-instance' AS xsi),RC AS
   (SELECT COUNT(Row.value('.', 'nvarchar(MAX)')) [RowCount]
   FROM @xml.nodes('Root/Row') AS WTable(Row))
,c AS(
SELECT b.value('local-name(.)','nvarchar(max)') ColumnName,
  b.value('.[not(@xsi:nil = "true")]','nvarchar(max)') Value,
  b.value('../Rn[1]','nvarchar(max)') Rn,
  ROW_NUMBER() OVER (PARTITION BY b.value('../Rn[1]','nvarchar(max)') ORDER BY (SELECT 1)) Cell
FROM
 @xml.nodes('//Root/Row/*[local-name(.)!="Rn"]') a(b)

 ),Cols AS (
 SELECT  DISTINCT c.ColumnName,
  c.Cell
 FROM c
 )
 INSERT INTO #TempTable (CellId,RowID,Value,ColumnName)
 SELECT Cell,Rn,Value,REPLACE(c.ColumnName,'_x0023_','#')
 FROM c
 
SELECT  @sSQL = @sSQl
        + '(SELECT T2.Value FROM #Temptable T2 WHERE T2.CellId=Cell.CellID AND T2.Rowid='
        + CAST(T.RowId AS NVARCHAR) + ') AS Row_' + CAST(T.RowID AS NVARCHAR)
        + ','
FROM    ( SELECT DISTINCT
                    RowId
          FROM      #TempTable
        ) T
SET @sSQl = LEFT(@sSQL, LEN(@sSQL) - 1)
    + ' FROM (SELECT DISTINCT CellId FROM #TempTable) Cell'
EXECUTE sp_Executesql @sSQl
--here you will have your output
DROP TABLE #Table
DROP TABLE #TempTable