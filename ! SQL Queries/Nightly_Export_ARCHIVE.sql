--[VG69999].[GetExportAtArchiveDeptDocuments]
--[VG69999].[GetExportAtArchiveDocContents]

select * from VANGUARD.SCHEDULE_JOB  where TENANT_ID=26 and  SCHEDULE_JOB_CODE like'%ExportNightlyAtArchive%'

-------------------------------------------------------------------------------------------
DECLARE @YesterdayDate datetime = DATEADD(d, DATEDIFF(d, 0, GETDATE()) - 1, 0)

UPDATE VANGUARD.SCHEDULE_JOB
   SET NEXT_EXECUTE_DATE = DATEADD(s, 3, GETDATE()), SCHEDULER_NAME = null, LOCK_DATE = null, [STATUS] = 2, IS_CANCELED =0, 
   PREVIOUS_EXECUTE_RESULT ='<NightlyExportAtArchiveResult>
   <ExportDate>' + CONVERT(varchar(23), @YesterdayDate, 121) + '</ExportDate>
   <PendingDocTypes />
   <CompletedDocTypes />
   <Status>Finished</Status>
   </NightlyExportAtArchiveResult>'
   WHERE SCHEDULE_JOB_ID=28724


--<ExportDate>2023-10-04</ExportDate>
<ExportDate>' + CONVERT(varchar(23), @YesterdayDate, 121) + '</ExportDate>
-------------------------------------------------------------------------------------------

update VANGUARD.SCHEDULE_JOB 
set NEXT_EXECUTE_DATE = DATEADD(s, 3, GETDATE()), SCHEDULER_NAME = null, LOCK_DATE = null, [STATUS] = 2, IS_CANCELED =0
,PREVIOUS_EXECUTE_RESULT = ''
  --<IndexDataUpdateDate>2023-06-21T16:55:42.94</IndexDataUpdateDate>
--</EsExportResult>'
where SCHEDULE_JOB_ID = 28724


------------------------------------------------------------------------------------------

update VANGUARD.SCHEDULE_JOB 
set NEXT_EXECUTE_DATE = DATEADD(s, 3, GETDATE()), SCHEDULER_NAME = null, LOCK_DATE = null, [STATUS] = 2, IS_CANCELED =0
--,PREVIOUS_EXECUTE_RESULT = ''
  --<IndexDataUpdateDate>2023-06-21T16:55:42.94</IndexDataUpdateDate>
--</EsExportResult>'
where SCHEDULE_JOB_ID = 28724


-------------------

select top 10 * from VANGUARD.SCHEDULE_JOB_HISTORY order by schedule_job_history_id desc



-------------------------------

select * from VG69999.[NIGHTLY_EXPORT_AT_ARCHIVE]


delete from VG69999.[NIGHTLY_EXPORT_AT_ARCHIVE]

select dm_vcinstnum from VG69999.doc_master where dm_id in (237358, 237369, 237081, 237032)

select * from VG69999.[order]
where order_id in
(
 select order_id from VG69999.order_item
 where dm_id in ( 237032) --237081, --

)


--select * from Vg69999.order_history where order_id = 378263
select * from Vg69999.order_item_history where order_item_id = 556656  

select * from VG69999.DM_CONTENT
where DM_ID in (
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num='20231009000001'
) )

2fb9a5bf-50e2-45ab-81d1-013e9a5824ef_Recorded.tiff

update VG69999.DM_CONTENT
set DMC_PATH = ''
where DM_ID = 237296

in (
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num='20231006000005'
) )

select * from VG69999.order_item 
where order_id in 
( select order_id
  from VG69999.[ORDER]
  where order_num='20231009000001')

update VG69999.order_item 
set workflow_step_id = 4
where order_id in 
( select order_id
  from VG69999.[ORDER]
  where order_num='20231009000001')

 