USE tempdb;
GO

CREATE FUNCTION dbo.SplitStrings (@List NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN (
		SELECT DISTINCT Item
		FROM (
			SELECT Item = x.i.value('(./text())[1]', 'nvarchar(max)')
			FROM (
				SELECT [XML] = CONVERT(XML, '<i>' + REPLACE(@List, ',', '</i><i>') + '</i>').query('.')
				) AS a
			CROSS APPLY [XML].nodes('i') AS x(i)
			) AS y
		WHERE Item IS NOT NULL
		);
GO

CREATE TABLE dbo.[Table] (
	ID INT,
	[Column] VARCHAR(255)
	);
GO

INSERT dbo.[Table]
VALUES (
	1,
	'lactulose, Lasix (furosemide), oxazepam, propranolol, rabeprazole, sertraline,'
	),
	(
	2,
	'lactulite, Lasix (furosemide), lactulose, propranolol, rabeprazole, sertraline,'
	),
	(
	3,
	'lactulite, Lasix (furosemide), oxazepam, propranolol, rabeprazole, sertraline,'
	),
	(
	4,
	'lactulite, Lasix (furosemide), lactulose, amlodipine, rabeprazole, sertraline,'
	);

SELECT t.ID
FROM dbo.[Table] AS t
INNER JOIN dbo.SplitStrings('lactulose,amlodipine') AS s ON ', ' + t.[Column] + ',' LIKE '%, ' + s.Item + ',%'
GROUP BY t.ID;
GO


