

-- Goal: call view and persist in to its counterpart reporting db table
-- vRetailTransaction -> RetailTransaction
-- vRetailSession -> RetailSession

-- 9-MAY
-- David/Donn: we'll split up the insert and update templates into callable discreet code
-- since we're dealing with source & destination servers that are not sitting on the same
-- infrastructure (e.g. going over the wire to separate servers).

select * from [vRetailTransaction]
select * from vRetailSession

-- First, try this table and export to Reporting:
select * from pickupsession

SELECT * FROM [ETLKioskOps].[dbo].[PickupSession]
  ORDER BY [PickupSessionId]
  FOR XML PATH('TableRow'), ROOT('TableBatch'), ELEMENTS, TYPE;

