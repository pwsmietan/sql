SELECT PartNumber AS "Part Number", Nomenclature, FAADesignApproval AS "FAA Design APPROVAL",
  InstallationEligibility AS "Installation Eligibility", Notes
FROM Parts

delete from eligibility where Note is null
select count(*) from Eligibility where Note is null
select * from Eligibility
SELECT [Installation Eligibility] FROM Eligibility WHERE Note=381

select * from parts where PartNumber like '311508-18'
delete from parts where ID=8536

/* what parts aren't in parts table? This would be a good exception report! */
select * from M2K.dbo.BEA_PS where PS_Parent_Part_NoFac not in 
(select PartNumber from Parts)

USE M2K
select * from BEA_IM order by IM_ID
select * from BEA_SOH order by soh_id
select * from BEA_SOD order by sod_cust_ord
select * from M2K.dbo.BEA_IM where IM_ID like '177892-102%' order by IM_ID
select * from M2K.dbo.BEA_IM where IM_ID like '177716-103%' order by IM_ID
select * from BEA_IM where IM_ID like '1-230-%' order by IM_ID

USE PMA
select * from Parts where PartNumber='176776-086' order by PartNumber

/* Does part have a note or exception? */
select * from stc where Stc_Nbr like '%(%'
select * from stc where Stc_Nbr like '110643-02'
select * from stc where Stc_Nbr like '311159-18%'
select * from stc.dbo.stc where Stc_Nbr like '176724-01'

select * from bea_ps where ps_parent_llc=0
select * from bea_ps order by ps_parent_part
select * from bea_ps where ps_component_part like '241703%'

select * from bea_ps where ps_component_part like '177892-102%'
select * from bea_ps where ps_parent_part_nofac='177892-102'
select * from bea_ps where ps_parent_part_nofac='178568-102' 
select * from bea_ps where ps_component_part_nofac='177892-102'
select * from bea_ps where ps_id like '177892-102%'

select * from bea_ps where ps_component_part_nofac='224315-03'
select * from bea_ps where ps_parent_part_nofac='224315-03'

select * from bea_ps 
select * from bea_ps where ps_component_part_nofac like 'S89220-1%'
select * from bea_ps where ps_id like '178248-01%'
select * from bea_ps where ps_id like '224315-03%' order by ps_id
select * from bea_ps where ps_parent_part like '176724-01%'

/* component part */
select * from bea_ps where ps_component_part_nofac='177576-526888'
/* and it's parent part - get all children of this parent */
select * from bea_ps where ps_parent_part_nofac='178248-101'
/* now compare all component parts including its parent to the Parts Table */
select * from pma.dbo.parts where PartNumber=(select ps_component_part_nofac from bea_ps where ps_component_part_nofac='177576-526888')
/* A parent part is also listed as a component part */
select * from bea_ps where ps_component_part_nofac='178248-101'
/* all children that have PMA */
select * from pma.dbo.parts where PartNumber in 
	(select ps_component_part_nofac from bea_ps where ps_parent_part_nofac='178248-101')

select * from bea_ps where ps_component_part_nofac='177576-526888'
select ps_parent_part_nofac from bea_ps where ps_component_part_nofac='177576-526888'

select * from pma.dbo.parts where PartNumber=(select ps_parent_part_nofac from bea_ps where ps_component_part_nofac='177576-526888')
select * from pma.dbo.parts where PartNumber in (select ps_parent_part_nofac from bea_ps where ps_parent_part_nofac='177576-526888')
select * from pma.dbo.parts where PartNumber like 'S89220-%'

select * from BEA_SOH order by soh_id
select * from BEA_SOH where SOH_ID='59386'
select * from BEA_SOD where SOD_SO_Nbr='59386' order by cast(SOD_Line_Nbr as int)

select * from bea_sod where sod_item_wo_gl like '178248-101%'

select count (distinct substring(sod_id,1,5)) from bea_sod 

select * from bea_im where im_id like '177576-567%'

insert into SOT (ID,TransTimeStamp) values( 1,getdate() )
delete from SOT

insert into sot_items (id, partnumber, pmaflag) values('1234','9988','False')
select * from sot_items where pmaflag='true'

select * from bea_ps where ps_component_part_nofac='177892-102' order by 
select * from bea_ps where ps_parent_part_nofac='179000-201'
select * from bea_ps where ps_component_part_nofac='170986-01'
select * from bea_ps where ps_parent_part_nofac='170986-01'

select * from bea_ps order by ps_id
	(select top 1 ps_parent_part_nofac from bea_ps where ps_component_part_nofac='306047-01')

select * from pma.dbo.parts where PartNumber in 
  (select ps_component_part_nofac from bea_ps where ps_parent_part_nofac='179000-201')

use PMA
delete from sot
delete from sot_items
delete from ApprovedParts
delete from RejectedParts
delete from FormTracking

select * from sot
select * from sot_items
select * from ApprovedParts
select * from RejectedParts
select distinct * from ApprovedParts 
select distinct PartNumber from PMA.dbo.ApprovedParts where Printed=0 and SOID='59386'

select count(*) from ApprovedParts where soid='59386' and PartNumber='S89120-26'


DROP TABLE APtmp
SELECT  DISTINCT 
sod.SOD_Line_Nbr AS Item,
sod.SOD_Description AS Description, 
SUBSTRING(sod.SOD_Item_Wo_Gl, 1, CHARINDEX('|', sod.SOD_Item_Wo_Gl) - 1) AS PartNumber, 
sod.SOD_Class_Code AS Eligibilty,
sod.SOD_Ln_Del_Qty AS Quantity,
sod.SOD_Sales_Prod_Code AS Serial,
sod.SOD_Cust_Type AS Status
INTO PMA.dbo.APtmp
FROM M2K.dbo.BEA_SOD sod 
WHERE SOD_SO_NBR='59386' 
AND SUBSTRING(sod.SOD_Item_Wo_Gl, 1, CHARINDEX('|', sod.SOD_Item_Wo_Gl) - 1) IN (SELECT DISTINCT PartNumber FROM PMA.dbo.ApprovedParts WHERE Printed=0 and SOID='59386')
ORDER BY PartNumber
ALTER TABLE APtmp ALTER COLUMN Item INT;

select distinct PartNumber from APTmp