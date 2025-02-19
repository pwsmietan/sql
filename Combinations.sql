WITH t1(N) AS (SELECT 1 UNION ALL SELECT 1),
t2(N) AS (SELECT 1 FROM t1 x, t1 y),
t3(N) AS (SELECT 1 FROM t2 x, t2 y),
Tally(N) AS (SELECT TOP 98 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM t3 x, t3 y),
Tally2(N) AS (SELECT TOP 5 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM t3 x, t3 y),
Combinations(N) AS (SELECT DISTINCT LTRIM(RTRIM(RTRIM(SUBSTRING(poss,a.N,2)) + SUBSTRING(vowels,b.N,1)))
                    FROM Tally a
                    CROSS JOIN Tally2 b
                    CROSS APPLY (SELECT 'B C D F G H J K L M N P R S T V W Z SCSKKNSNSPSTBLCLFLGLPLSLBRCRDRFRGRPRTRVRSHSMGHCHPHRHWHBWCWSWTW') d(poss)
                    CROSS APPLY (SELECT 'AEIOU') e(vowels))
SELECT IDENTITY(INT,1,1) AS ID, a.N + b.N AS N
INTO #testNames
FROM Combinations a 
CROSS JOIN Combinations b;

select * from #testNames

SELECT IDENTITY(INT,1,1) AS ID, firstName, secondName
INTO #testNames2
FROM (SELECT firstName, secondName
      FROM (SELECT TOP 1000 --1000 * 1000 = 1,000,000 rows
            N AS firstName
            FROM #testNames
            ORDER BY NEWID()) a
      CROSS JOIN (SELECT TOP 1000 --1000 * 1000 = 1,000,000 rows
                  N AS secondName
                  FROM #testNames
                  ORDER BY NEWID()) b) innerQ;

select * from #testNames2

SELECT firstName, secondName,
firstName + '.' + secondName + '@fake.com' AS eMail,
CAST((ABS(CHECKSUM(NEWID())) % 250) + 1 AS VARCHAR(3)) + ' ' AS mailAddress,
(ABS(CHECKSUM(NEWID())) % 152100) + 1 AS jID,
IDENTITY(INT,1,1) AS ID
INTO #testNames3
FROM #testNames2

SELECT IDENTITY(INT,1,1) AS ID, firstName, secondName, eMail, 
mailAddress + b.N + b.N AS mailAddress
INTO testEnvironment
FROM #testNames3 a
INNER JOIN #testNames b ON a.jID = b.ID;

--CLEAN UP USELESS TABLES
DROP TABLE #testNames;
DROP TABLE #testNames2;
DROP TABLE #testNames3;