SELECT *
FROM Historical

SELECT *
FROM FormVCHCA_IncidentReport01

SELECT *
FROM FormVCMC_Security01

SELECT *
FROM FormVCMC_Security01
WHERE incident_date > '1/1/2014'

SELECT *
FROM FormVCMC_Security01
ORDER BY incident_date

SELECT *
FROM Weighted

-- Create Weighted table
DROP TABLE Weighted

SELECT DS__keywords,
	COUNT(DS__keywords) AS TotalIncidents,
	CONVERT(DECIMAL(5, 2), CAST(COUNT(DS__keywords) AS DECIMAL) / (
			SELECT COUNT(*) * .01
			FROM FormVCMC_Security01
			)) AS [Weight]
INTO Weighted
FROM FormVCMC_Security01
WHERE incident_date BETWEEN '1/1/2014'
		AND '3/20/2014'
GROUP BY DS__keywords
ORDER BY Weight DESC

-- Insert our "Other" bucket those values less than our acceptable threshold.
INSERT INTO Weighted (
	DS__keywords,
	TotalIncidents,
	[Weight]
	)
VALUES (
	'Low Frequency Events',
	(
		SELECT SUM(TotalIncidents)
		FROM Weighted
		WHERE Weight < 5.0
		),
	(
		SELECT SUM(Weight)
		FROM Weighted
		WHERE Weight < 5.0
		)
	)

-- Our threshold query to display in pie chart.
SELECT *
FROM Weighted
WHERE Weight >= 5.0
ORDER BY Weight DESC

SELECT *
FROM FormVCMC_Security01
WHERE incident_date BETWEEN '1/1/2014'
		AND '3/20/2014'

-------------------------
SELECT DS__keywords,
	COUNT(DS__keywords) AS TotalIncidents,
	CONVERT(DECIMAL(5, 2), CAST(COUNT(DS__keywords) AS DECIMAL) * 100 / (
			SELECT COUNT(*)
			FROM FormVCMC_Security01
			)) AS [Percentage]
FROM FormVCMC_Security01
WHERE incident_date BETWEEN '1/1/2014'
		AND '3/20/2014'
GROUP BY DS__keywords
ORDER BY Percentage DESC

SELECT COUNT(*)
FROM FormVCMC_Security01

---------------------------------------------------------------------
DECLARE @TotalCount INT

SET @TotalCount = (
		SELECT COUNT(DS__keywords)
		FROM FormVCMC_Security01
		)

DROP TABLE Weighted

SELECT DS__keywords,
	COUNT(DS__keywords) AS TotalIncidents,
	CONVERT(DECIMAL(5, 2), CAST(COUNT(DS__keywords) AS DECIMAL) * 100 / (
			SELECT COUNT(*)
			FROM FormVCMC_Security01
			WHERE incident_date BETWEEN '1/1/2014'
					AND '3/20/2014'
			)) AS [Percentage]
INTO Weighted
FROM FormVCMC_Security01
GROUP BY DS__keywords
ORDER BY Percentage DESC

SELECT *
FROM Weighted

-- Insert our "Other" bucket those values less than our acceptable threshold.
INSERT INTO Weighted (
	DS__keywords,
	TotalIncidents,
	Percentage
	)
VALUES (
	'Low Frequency Events',
	(
		SELECT SUM(TotalIncidents)
		FROM Weighted
		WHERE Percentage < 5.0
		),
	(
		SELECT SUM(Percentage)
		FROM Weighted
		WHERE Percentage < 5.0
		)
	)

-- Our threshold query to display in pie chart.
SELECT *
FROM Weighted
WHERE Percentage >= 5.0
ORDER BY Percentage DESC

-----------------------------------------------------------------------
DECLARE @TotalCount INT

SET @TotalCount = (
		SELECT SUM(TotalIncidents)
		FROM dbo.[weight]
		)

SELECT DS_keywords,
	TotalIncidents,
	weight,
	convert(NUMERIC(18, 2), TotalIncidents * 100 / @TotalCount) AS [Percentage]
FROM dbo.[weight]
WHERE (TotalIncidents * 100 / @TotalCount) > '5.00'

UNION

SELECT
	--'All Others' as Keywords,sum(TotalIncidents),sum(weight) as [Weight]
	'All Others' AS Keywords,
	SUM(TotalIncidents),
	SUM(weight),
	SUM(convert(NUMERIC(18, 2), TotalIncidents * 100 / @TotalCount)) AS [Percentage]
FROM dbo.[weight]
WHERE (TotalIncidents * 100 / @TotalCount) < '5.00'
ORDER BY TotalIncidents

SELECT COUNT(DS__keywords) AS TotalIncidents
FROM FormVCMC_Security01
WHERE incident_date BETWEEN '1/1/2014'
		AND '3/6/2014'
GROUP BY DS__keywords

DROP TABLE Weighted

SELECT DS__keywords,
	COUNT(DS__keywords) AS TotalIncidents,
	CONVERT(DECIMAL(5, 2), CAST(COUNT(DS__keywords) AS DECIMAL) * 100 / (
			SELECT COUNT(*)
			FROM FormVCMC_Security01
			WHERE incident_date BETWEEN '1/1/2014'
					AND '3/6/2014'
			)) AS [Weight]
INTO Weighted
FROM FormVCMC_Security01
WHERE incident_date BETWEEN '1/1/2014'
		AND '3/20/2014'
GROUP BY DS__keywords
ORDER BY Weight DESC

SELECT *
FROM Weighted

DROP TABLE Weighted

SELECT DS__keywords,
	COUNT(DS__keywords) AS TotalIncidents,
	CONVERT(DECIMAL(5, 2), CAST(COUNT(DS__keywords) AS DECIMAL) * 100 / (
			SELECT COUNT(*)
			FROM FormVCMC_Security01
			WHERE incident_date BETWEEN '1/1/2014'
					AND '3/6/2014'
			)) AS [Weight]
INTO Weighted
FROM FormVCMC_Security01
WHERE incident_date BETWEEN '1/1/2014'
		AND '3/6/2014'
GROUP BY DS__keywords
ORDER BY Weight DESC
