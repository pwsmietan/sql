SELECT RowNo = (@@CURSOR_ROWS), UnitName
INTO unit_name
FROM OriginUnits

/* Add ID numbers to Parts table */
DECLARE @New_Id INT

SET @New_Id = 0

DECLARE id_cursor CURSOR
FOR
SELECT *
FROM unit_name

OPEN id_cursor

FETCH NEXT
FROM id_cursor

SET @New_Id = @New_Id + 1

UPDATE unit_name
SET RowNo = @New_Id
WHERE CURRENT OF id_cursor

WHILE @@FETCH_STATUS = 0
BEGIN
	FETCH NEXT
	FROM id_cursor

	SET @New_Id = @New_Id + 1

	UPDATE unit_name
	SET RowNo = @New_Id
	WHERE CURRENT OF id_cursor
END

CLOSE id_cursor

DEALLOCATE id_cursor

/*********************************************************************************/
SELECT UnitName
FROM unit_name

SELECT a.UnitName, b.
FROM unit_name AS a
LEFT JOIN CR_Log AS b ON Orders.CustomerID = Customers.CustomerID;

DELETE
FROM CRLogv2

DELETE
FROM ADTPatients

SELECT *
FROM CRLogv2

SELECT *
FROM ADTPatients

SELECT *
FROM PatientBreakOut

SELECT *
FROM FacilityUnits

SELECT *
FROM CRLogv2

-- show history of patient (possible multiple room/facility moves.
SELECT adt_id, Last_Name, First_Name, Facility, Origin
FROM CRLogv2
WHERE Last_Name = 'Smith'
	AND First_Name = 'John'

-- show all patients in their current disposition
SELECT *
FROM ADTPatients
WHERE len(fullname) > 0
ORDER BY p_id

-- here's all patients with each ADT event broken out
SELECT *
FROM PatientBreakOut
ORDER BY p_id

SELECT a.FacilityID, a.UnitName, b.chkNoChange, b.Origin, c.Name
FROM FacilityUnits a
LEFT JOIN CRLogv2 b ON b.Origin = a.UnitName
INNER JOIN Facilities c ON a.FacilityID = c.ID
ORDER BY a.FacilityID

SELECT adt_id, FacilityIdx, origin, chkNoChange, Facility
FROM CRLogv2
ORDER BY FacilityIdx

SELECT adt_id, FacilityIdx, Origin, chkNoChange, Facility
FROM CRLogv2
WHERE adt_id IN (
		SELECT max(adt_id) AS LastID
		FROM CRLogv2
		GROUP BY Origin
		)

SELECT a.FacilityID, a.UnitName, b.chkNoChange, b.Facility
FROM FacilityUnits a
LEFT JOIN (
	SELECT adt_id, FacilityIdx, Origin, chkNoChange, Facility
	FROM CRLogv2
	WHERE adt_id IN (
			SELECT max(adt_id) AS LastID
			FROM CRLogv2
			GROUP BY Origin
			)
	) b ON a.FacilityID = b.FacilityIdx
	AND a.UnitName = b.Origin
ORDER BY FacilityID

SELECT *
FROM FacilityUnits
ORDER BY FacilityID, UnitName

SELECT p_id
FROM ADTPatients
WHERE len(FullName) > 0

SELECT *
INTO foo
FROM CRLogv2 a
WHERE adt_id IN (
		SELECT p_id
		FROM ADTPatients
		WHERE len(FullName) > 0
		)

SELECT *
FROM CRLogv2

DELETE
FROM patientbreakout

SELECT *
FROM patientbreakout

SELECT count(facilityid) AS SubTotalFacility, FacilityID, Facility
FROM ADTPatients
GROUP BY FacilityID, Facility
ORDER BY FacilityID
