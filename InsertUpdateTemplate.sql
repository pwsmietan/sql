-- ********************************************************************************************
-- ********************************************************************************************
-- EXAMPLE SELECT:

--SELECT TOP(1000)
--	KioskStateHistoryId,
--	MachinePlacementId,
--	StateTime,
--	EventId,
--	EventLogId,
--	KioskStateId,
--	RecordCreationTime,
--	RecordUpdateTime
--FROM dbo.KioskStateHistory
--WHERE KioskStateHistoryId > 22137
--ORDER BY KioskStateHistoryId
--FOR XML PATH('TableRow'), ROOT('TableBatch') , ELEMENTS, TYPE;
-- ********************************************************************************************
-- ********************************************************************************************

BEGIN TRANSACTION;

	SELECT TOP({paramBatchSize})
	{paramSourceSelectColumnList}
	FROM {paramSourceSchema}.{paramSourceTableName}
	WHERE {paramWhereClause}
	ORDER BY {paramOrderByClause}
	FOR XML PATH('TableRow'), ROOT('TableBatch') , ELEMENTS, TYPE;

COMMIT TRANSACTION;


-- ********************************************************************************************
-- ********************************************************************************************
-- Sample INSERT/UPDATE script:

--UPDATE H
--SET MachinePlacementId = n.e.value('MachinePlacementId[1]', 'int'),
--StateTime = n.e.value('StateTime[1]', 'datetimeoffset'),
--EventId = n.e.value('EventId[1]', 'int'),
--EventLogId = n.e.value('EventLogId[1]', 'int'),
--KioskStateId = n.e.value('KioskStateId[1]', 'int'),
--RecordCreationTime = n.e.value('RecordCreationTime[1]', 'datetimeoffset'),
--RecordUpdateTime = n.e.value('RecordUpdateTime[1]', 'datetimeoffset')
--FROM dbo.KioskStateHistory H
--INNER JOIN @BatchXML.nodes('/TableBatch/TableRow') n(e)
--ON n.e.value('KioskStateHistoryId[1]', 'bigint') = H.KioskStateHistoryId;

--INSERT INTO dbo.KioskStateHistory
--( KioskStateHistoryId,
--  MachinePlacementId,
--  StateTime,
--  EventId,
--  EventLogId,
--  KioskStateId,
--  RecordCreationTime,
--  RecordUpdateTime )
--SELECT
--n.e.value('KioskStateHistoryId[1]', 'bigint') as KioskStateHistoryId,
--n.e.value('MachinePlacementId[1]', 'int') as MachinePlacementId,
--n.e.value('StateTime[1]', 'datetimeoffset') as StateTime,
--n.e.value('EventId[1]', 'int') as EventId,
--n.e.value('EventLogId[1]', 'int') as EventLogId,
--n.e.value('KioskStateId[1]', 'int') as KioskStateId,
--n.e.value('RecordCreationTime[1]', 'datetimeoffset') as RecordCreationTime,
--n.e.value('RecordUpdateTime[1]', 'datetimeoffset') as RecordUpdateTime
--FROM @BatchXML.nodes('/TableBatch/TableRow') n(e)
--LEFT JOIN dbo.KioskStateHistory H
--ON n.e.value('KioskStateHistoryId[1]', 'bigint') = H.KioskStateHistoryId
--WHERE H.KIoskStateHistoryId IS NULL;

BEGIN TRANSACTION;

	UPDATE H
	SET {paramSetColumnsList}
	FROM {paramDestinationSchema}.{paramDestinationTableName} H
	INNER JOIN @BatchXML.nodes('/TableBatch/TableRow') n(e)
	ON {paramMatchingColumnList};

	INSERT INTO {paramDestinationSchema}.{paramDestinationTableName}
	( {paramInsertColumnList} )
	SELECT {paramBatchSelectColumnList}
	FROM @BatchXML.nodes('/TableBatch/TableRow') n(e)
	LEFT JOIN {paramDestinationSchema}.{paramDestinationTableName} H
	ON {paramMatchingColumnList}
	WHERE H.{paramFirstMatchingColumn} IS NULL;

COMMIT TRANSACTION;


-- ********************************************************************************************
-- ********************************************************************************************
