--DECLARE @BatchXML XML; 
--SET @BatchXML= (
--SELECT top 100 *
--  FROM [ETLKioskOps].[dbo].[PickupSession]
--  ORDER BY [PickupSessionId]
--FOR XML PATH('TableRow'), ROOT('TableBatch') , ELEMENTS, TYPE
--)

--update H
--SET SessionRowId       = n.e.value('SessionRowId[1]', 'bigint'),
--  PickupSessionId      = n.e.value('PickupSessionId[1]', 'bigint'),
--  KioskPickupSessionId = n.e.value('KioskPickupSessionId[1]', 'int'),
--  MachinePlacementId   = n.e.value('MachinePlacementId[1]', 'int'),
--  BinTypeId            = n.e.value('BinTypeId[1]', 'tinyint'),
--  PickupId             = n.e.value('PickupId[1]', 'int'),
--  PickupDate           = n.e.value('PickupDate[1]', 'int'),
--  KioskPickupStartTime = n.e.value('KioskPickupStartTime[1]', 'datetimeoffset'),
--  KioskPickupEndTime   = n.e.value('KioskPickupEndTime[1]', 'datetimeoffset'),
--  PreviousBalance      = n.e.value('PreviousBalance[1]', 'money'),
--  TotalRemoved         = n.e.value('TotalRemoved[1]', 'money'),
--  NewBalance           = n.e.value('NewBalance[1]', 'money'),
--  BinsFull             = n.e.value('BinsFull[1]', 'tinyint'),
--  BinsFullPercent      = n.e.value('BinsFullPercent[1]', 'money'),
--  UserPIN              = n.e.value('UserPIN[1]', 'varchar'),
--  UserDAC              = n.e.value('UserDAC[1]', 'varchar'),
--  RecordCreationTime   = n.e.value('RecordCreationTime[1]', 'datetimeoffset'),
--  RecordUpdateTime     = n.e.value('RecordUpdateTime[1]', 'datetimeoffset'),
--  IsNvm                = n.e.value('IsNvm[1]', 'tinyint')
--FROM dbo.PickupSession H
--  INNER JOIN @BatchXML.nodes('/TableBatch/TableRow') n (e)
--    ON n.e.value('PickupSessionId[1]', 'bigint') = H.PickupSessionId;


go
begin
DECLARE @BatchXML XML;
SET @BatchXML = '
<TableBatch>
    <TableRow>
        <PickupSessionId>100000039</PickupSessionId>
        <KioskPickupSessionId>1</KioskPickupSessionId>
        <MachinePlacementId>32372</MachinePlacementId>
        <BinTypeId>1</BinTypeId>
        <KioskPickupStartTime>2017-03-30T10:25:10.5585937-06:00</KioskPickupStartTime>
        <KioskPickupEndTime>2017-03-30T10:26:35.8261718-06:00</KioskPickupEndTime>
        <PreviousBalance>13094.3700</PreviousBalance>
        <TotalRemoved>13094.3700</TotalRemoved>
        <NewBalance>0.0000</NewBalance>
        <BinsFull>1</BinsFull>
        <BinsFullPercent>84.93</BinsFullPercent>
        <UserPIN>3940</UserPIN>
        <LastEventLogId>1708900024</LastEventLogId>
        <RecordCreationTime>2017-03-30T09:26:02.1253228-07:00</RecordCreationTime>
        <RecordUpdateTime>2017-05-16T15:06:23.4408380-07:00</RecordUpdateTime>
        <EppsExportLockTime>2017-03-30T09:37:25.6117337-07:00</EppsExportLockTime>
        <EppsExportedTime>2017-05-16T15:06:23.4408380-07:00</EppsExportedTime>
        <HasErrors>0</HasErrors>
        <IsNvm>0</IsNvm>
    </TableRow>
    <TableRow>
    <PickupSessionId>100000049</PickupSessionId>
    <KioskPickupSessionId>1</KioskPickupSessionId>
    <MachinePlacementId>31966</MachinePlacementId>
    <BinTypeId>1</BinTypeId>
    <KioskPickupStartTime>2017-04-17T10:26:08.4067422-07:00</KioskPickupStartTime>
    <KioskPickupEndTime>2017-04-17T10:27:59.0835000-07:00</KioskPickupEndTime>
    <PreviousBalance>9084.4400</PreviousBalance>
    <TotalRemoved>9084.4400</TotalRemoved>
    <NewBalance>0.0000</NewBalance>
    <BinsFull>1</BinsFull>
    <BinsFullPercent>100.05</BinsFullPercent>
    <UserPIN>3940</UserPIN>
    <LastEventLogId>1710700031</LastEventLogId>
    <RecordCreationTime>2017-04-17T10:26:41.3705859-07:00</RecordCreationTime>
    <RecordUpdateTime>2017-05-16T15:06:23.4408380-07:00</RecordUpdateTime>
    <EppsExportLockTime>2017-04-17T10:37:13.6188657-07:00</EppsExportLockTime>
    <EppsExportedTime>2017-05-16T15:06:23.4408380-07:00</EppsExportedTime>
    <HasErrors>0</HasErrors>
	</TableRow>
</TableBatch>';
update H
SET 
  PickupSessionId      = n.e.value('PickupSessionId[1]', 'bigint'),
  KioskPickupSessionId = n.e.value('KioskPickupSessionId[1]', 'int'),
  MachinePlacementId   = n.e.value('MachinePlacementId[1]', 'int'),
  BinTypeId            = n.e.value('BinTypeId[1]', 'tinyint'),
  PickupId             = n.e.value('PickupId[1]', 'int'),
  PickupDate           = n.e.value('PickupDate[1]', 'int'),
  KioskPickupStartTime = n.e.value('KioskPickupStartTime[1]', 'datetimeoffset'),
  KioskPickupEndTime   = n.e.value('KioskPickupEndTime[1]', 'datetimeoffset'),
  PreviousBalance      = n.e.value('PreviousBalance[1]', 'money'),
  TotalRemoved         = n.e.value('TotalRemoved[1]', 'money'),
  NewBalance           = n.e.value('NewBalance[1]', 'money'),
  BinsFull             = n.e.value('BinsFull[1]', 'tinyint'),
  BinsFullPercent      = n.e.value('BinsFullPercent[1]', 'money'),
  UserPIN              = n.e.value('UserPIN[1]', 'varchar'),
  UserDAC              = n.e.value('UserDAC[1]', 'varchar'),
  RecordCreationTime   = n.e.value('RecordCreationTime[1]', 'datetimeoffset'),
  RecordUpdateTime     = n.e.value('RecordUpdateTime[1]', 'datetimeoffset'),
  IsNvm                = n.e.value('IsNvm[1]', 'tinyint')
FROM dbo.PickupSession H
  INNER JOIN @BatchXML.nodes('/TableBatch/TableRow') n (e)
    ON n.e.value('PickupSessionId[1]', 'bigint') = H.PickupSessionId;

end

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



