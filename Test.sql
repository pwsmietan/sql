CREATE TABLE #Example1 (
    ValueInt    INT
) ;

INSERT INTO #Example1
SELECT 
    ABS(CHECKSUM(NewId())) % 20
GO 10

select NEWID()

select * from #Example1



SELECT CONVERT(VARCHAR(32),GETDATE(),121) as StartTimeStamp ;
 
select 
    SUM(ValueInt) as SumOfValues,
    MIN(ValueInt) as MinValue,
    MAX(ValueInt) as MaxValue
FROM 
    #Example1
;
 
SELECT CONVERT(VARCHAR(32),GETDATE(),121) as EndTimeStamp ;
 
