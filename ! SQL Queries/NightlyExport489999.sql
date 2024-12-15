--select * from VG48999.doc_group
select 
        dg.doc_group_id,
		dg.doc_group_code,
		dg.doc_group_desc
from VG48999.dept_docgroup dd
join VG48999.doc_group dg on dd.doc_group_id = dg.doc_group_id
where dd.dept_id = 1
---------------------
select
o.order_num, 
dm.CF_VCINSTNUM as 'doc#',
d.dept_desc,
d.dept_id,
dg.doc_group_desc,
dg.doc_group_id,
dt.doc_type_desc,
o.order_date,
o.workflow_step_id,
dm.DM_IS_SEALED
--au.aduser_domain
--dmp.township
from VG48999.doc_master dm
join VG48999.order_item oi on oi.dm_id = dm.dm_id
join VG48999.[order] o on o.order_id = oi.order_id
--join VG48999.DM_PROPADDRESS dmp on dmp.dm_id = dm.dm_id
join VANGUARD.DEPT d  on dm.dept_id=d.dept_id
join VG48999.doc_group dg on oi.doc_group_id = dg.doc_group_id
join VG48999.doc_type dt on dm.doc_type_id = dt.doc_type_id
--join VG48999.ad_user au on au.aduser_id = o.aduser_id
where o.order_num = '20241213000010'    
 
--------------------------------------

select * from VANGUARD.SCHEDULE_JOB where TENANT_ID = 63 and SCHEDULE_JOB_CODE='OrderItemContentExport'

--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28674


--Check DM_CONTENT-------------------------------

select * from VG48999.DM_CONTENT
where DM_ID in 
(
	select DM_ID from VG48999.ORDER_ITEM
	where order_id in 
	(
		select order_id from VG48999.[ORDER]
		where order_num='20241213000008'
	) 
) order by dmc_id asc

-----------------------------------------------

select   GETDATE()  

SELECT * from VANGUARD.TENANT where tenant_code = 48999  --63

select * from VANGUARD.dept where dept_desc = 'Land Records'  --1

select * from [VANGUARD].[TENANT_DEPT] where tenant_id = 63 AND dept_id = 1

--update [VANGUARD].[TENANT_DEPT] set td_to_date = '2024-12-12' where tenant_id = 63 AND dept_id = 1

--update 'td_to_date' to 'CurrentDate' without time
--update [VANGUARD].[TENANT_DEPT] set td_to_date = CAST(GETDATE() AS Date) where dept_id = 1 and tenant_id = 63

------ExportNightlyDept1---------------------

select * from VANGUARD.SCHEDULE_JOB  where TENANT_ID=63 and  SCHEDULE_JOB_CODE like'%ExportNightlyDept1%'

DECLARE @YesterdayDate datetime = DATEADD(d, DATEDIFF(d, 0, GETDATE()) - 1, 0)

UPDATE VANGUARD.SCHEDULE_JOB
   SET PREVIOUS_EXECUTE_RESULT ='<NightlyExportResult>
   <ExportDate>' + CONVERT(varchar(23), @YesterdayDate, 121) + '</ExportDate>
   <PendingDocTypes />
   <CompletedDocTypes />
   <Status>Finished</Status>
   <ReCaptureExportDate>' + CONVERT(VARCHAR(20), CAST(CAST(GETDATE() AS DATE) AS DATETIME), 120) + '</ReCaptureExportDate>
   </NightlyExportResult>', NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), IS_CANCELED=0, SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2
   WHERE SCHEDULE_JOB_ID=28896

---------

update VANGUARD.SCHEDULE_JOB 
set PREVIOUS_EXECUTE_RESULT = '
<NightlyExportResult>
<ExportDate>2024-12-10T00:00:00</ExportDate>
<Status>Finished</Status>
<ReCaptureExportDate>2024-12-11T00:00:00</ReCaptureExportDate>
<CaptureUploadExportDate>2024-12-11T00:00:00</CaptureUploadExportDate>
</NightlyExportResult>'
where TENANT_ID = 63 and SCHEDULE_JOB_CODE like 'ExportNightlyDept2'


---------------










--1-------Auto_Redaction-------------------

select * from VANGUARD.SCHEDULE_JOB where TENANT_ID = 63 and SCHEDULE_JOB_CODE like '%Auto%'

select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID = 28625  --AutoRedactionExport
select * from VANGUARD.SCHEDULE_JOB where schedule_job_id = 28631  --AutoRedactionListenner
select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID = 28627  --AutoRedactionImport

--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28625  --AutoRedactionExport
--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28631  --AutoRedactionListenner
--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28627  --AutoRedactionImport

--10 - Ready to export (waiting for export job to send image to OCR)
--20 - Ready to listen (Waiting for listener job to retrieve OCR result)
--30 - Ready to import (Waiting for import job to apply candidates and redacts to image)
--100 - Done

select *
   --   art.order_item_id,
	  --ars.status_id,
	  --ars.name,
	  --art.create_date,
	  --art.update_date,
	  --aroi.ocr_filtered_result
from VG48999.auto_redaction_task art
join VG48999.[order] o on o.order_id = art.order_id
join vanguard.auto_redaction_status ars on art.status_id = ars.status_id
join vg48999.auto_redaction_order_item aroi on aroi.order_item_id = art.order_item_id
where o.order_num = '20241211000009'



--delete from VG48999.DM_CONTENT where DM_ID = 70810
select * from VG48999.DM_OCR_PROCESS where DMC_ID = 58450
--delete from VG48999.DM_OCR_PROCESS where DMÑ_ID = 58450



------Blocks orders---------

select 
      o.order_num as 'blocks_order_num',
	  dm.cf_vcinstnum as 'doc#',
	  dt.doc_type_desc,
	  o.order_date,
	  o.workflow_step_id,
	  au.aduser_domain
from VG48999.[order] o
join VG48999.order_item oi on oi.order_id = o.order_id
join VG48999.doc_master dm on dm.dm_id = oi.dm_id
join VG48999.doc_type dt on dm.doc_type_id = dt.doc_type_id
join VG48999.ad_user au on au.aduser_id = o.aduser_id
where o.workflow_step_id  = 2  and CONVERT(date, order_date) = '2024-12-10' and DEPARTMENT_ID = 1 
order by o.order_num asc

-----Exported orders---------

select 
      o.order_num as 'export_order_num',
	  dm.cf_vcinstnum as 'doc#',
	  dt.doc_type_desc,
	  o.order_date,
	  o.workflow_step_id,
	  au.aduser_domain
from VG48999.[order] o
join VG48999.order_item oi on oi.order_id = o.order_id
join VG48999.doc_master dm on dm.dm_id = oi.dm_id
join VG48999.doc_type dt on dm.doc_type_id = dt.doc_type_id
join VG48999.ad_user au on au.aduser_id = o.aduser_id
where o.workflow_step_id  in (3,4,5) and CONVERT(date, order_date) = '2024-12-10' and DEPARTMENT_ID = 1 
order by dm.cf_vcinstnum asc

-----------------------------

select * from VANGUARD.SCHEDULE_JOB_HISTORY where schedule_job_id = 28896 order by schedule_job_history_id desc

--delete from VANGUARD.SCHEDULE_JOB where schedule_job_id = 28897
--delete from VANGUARD.SCHEDULE_JOB_HISTORY where schedule_job_id = 28897
----------------------------------------------------------


select * from VG48999.DOC_MASTER
where DM_ID in 
(
	select DM_ID from VG48999.ORDER_ITEM
	where order_id in 
	(
		select order_id from VG48999.[ORDER]
		where order_num='20241210000029'
	) 
)

----Delete Doc Master related Data------------------------

DECLARE @dm_id INT = 70810

delete from VG48999.DM_DMPRIMARY_NUM where DM_ID = @dm_id
delete  from VG48999.DM_EXTENDED where DM_ID = @dm_id
delete  from VG48999.DM_JUDGMENT_DETAILS where DM_ID = @dm_id
delete  from VG48999.DM_PROPADDRESS where DM_ID = @dm_id
delete  from VG48999.DOC_MASTER_ML_DETAILS where DM_ID = @dm_id
delete  from VG48999.DOC_MASTER_DECLARATION_DETAILS where DM_ID = @dm_id
delete  from VG48999.SCANNED_FILE_ORIGINAL where DM_ID = @dm_id

delete from VG48999.DOC_MASTER where DM_ID = @dm_id


---Delete order related data-------

select * from VG48999.[order] where order_num = '20241017000002'

DECLARE @order_id INT = 65168

delete from VG48999.audit_receipt where order_id = @order_id 
delete from VG48999.order_details where order_id = @order_id
delete from VG48999.order_event where order_id = @order_id
delete from VG48999.verification_task where order_id = @order_id
delete from VG48999.indexing_task where order_id = @order_id
delete from VG48999.ORDER_ER where order_id = @order_id

delete from VG48999.[order] where order_num = '20241017000002'

select * from VG48999.[order] where order_num = '20241022000008' --65283

select * from VG48999.order_item where order_id = 65283  --70935

select * from VG48999.doc_master where dm_id = 70935

select * from VG48999.DM_CONTENT where dm_id = 70935



