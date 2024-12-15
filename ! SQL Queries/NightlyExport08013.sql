select   GETDATE()  

SELECT * from VANGUARD.TENANT where tenant_code = 08013  --85

select * from VANGUARD.dept where dept_desc = 'Land Records'  --1

select * from [VANGUARD].[TENANT_DEPT] where tenant_id = 85 AND dept_id = 1

--update 'td_to_date' to 'CurrentDate' without time
--update [VANGUARD].[TENANT_DEPT] set td_to_date = CAST(GETDATE() AS Date) where dept_id = 1 and tenant_id = 85

select * from VANGUARD.SCHEDULE_JOB where TENANT_ID = 85 and SCHEDULE_JOB_CODE='EsExportDep1'
--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28726
select * from VANGUARD.SCHEDULE_JOB where TENANT_ID = 85 and SCHEDULE_JOB_CODE='OrderItemContentExport'
--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28750

select * from VANGUARD.SCHEDULE_JOB  where TENANT_ID=85 and  SCHEDULE_JOB_CODE like'%ExportNightlyAtArchiveDep1%'

DECLARE @YesterdayDate datetime = DATEADD(d, DATEDIFF(d, 0, GETDATE()) - 1, 0)

UPDATE VANGUARD.SCHEDULE_JOB
   SET PREVIOUS_EXECUTE_RESULT ='<NightlyExportResult>
   <ExportDate>' + CONVERT(varchar(23), @YesterdayDate, 121) + '</ExportDate>
   <PendingDocTypes />
   <CompletedDocTypes />
   <Status>Finished</Status>
   <ReCaptureExportDate>' + CONVERT(VARCHAR(20), CAST(CAST(GETDATE() AS DATE) AS DATETIME), 120) + '</ReCaptureExportDate>
   </NightlyExportResult>', NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), IS_CANCELED=0, SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2
   WHERE SCHEDULE_JOB_ID=28767

------Blocks orders---------

select 
      o.order_num as 'blocks_order_num',
	  dm.cf_vcinstnum as 'doc#',
	  dt.doc_type_desc,
	  o.order_date,
	  o.workflow_step_id,
	  au.aduser_domain
from VG08013.[order] o
join VG08013.order_item oi on oi.order_id = o.order_id
join VG08013.doc_master dm on dm.dm_id = oi.dm_id
join VG08013.doc_type dt on dm.doc_type_id = dt.doc_type_id
join VG08013.ad_user au on au.aduser_id = o.aduser_id
where o.workflow_step_id  = 2  and CONVERT(date, order_date) = '2024-10-06' and DEPARTMENT_ID = 1 
order by o.order_num asc

-----Exported orders---------

select 
      o.order_num as 'export_order_num',
	  dm.cf_vcinstnum as 'doc#',
	  dt.doc_type_desc,
	  o.order_date,
	  o.workflow_step_id,
	  au.aduser_domain
from VG08013.[order] o
join VG08013.order_item oi on oi.order_id = o.order_id
join VG08013.doc_master dm on dm.dm_id = oi.dm_id
join VG08013.doc_type dt on dm.doc_type_id = dt.doc_type_id
join VG08013.ad_user au on au.aduser_id = o.aduser_id
where o.workflow_step_id  in (3,4,5) and CONVERT(date, order_date) = '2024-10-06' and DEPARTMENT_ID = 1 
order by dm.cf_vcinstnum asc

-----------------------------

select * from VANGUARD.SCHEDULE_JOB_HISTORY where schedule_job_id = 28767 order by schedule_job_history_id desc

--delete from VANGUARD.SCHEDULE_JOB where schedule_job_id = 28897
--delete from VANGUARD.SCHEDULE_JOB_HISTORY where schedule_job_id = 28897
----------------------------------------------------------

select
o.order_num, 
dm.CF_VCINSTNUM as 'doc#',
d.dept_desc,
dg.doc_group_desc,
dt.doc_type_desc,
o.order_date,
o.workflow_step_id,
au.aduser_domain
--dmp.township
from VG08013.doc_master dm
join VG08013.order_item oi on oi.dm_id = dm.dm_id
join VG08013.[order] o on o.order_id = oi.order_id
--join VG08013.DM_PROPADDRESS dmp on dmp.dm_id = dm.dm_id
join VANGUARD.DEPT d  on dm.dept_id=d.dept_id
join VG08013.doc_group dg on oi.doc_group_id = dg.doc_group_id
join VG08013.doc_type dt on dm.doc_type_id = dt.doc_type_id
join VG08013.ad_user au on au.aduser_id = o.aduser_id
where o.order_num = '20241006000001'

select * from VG08013.DM_CONTENT
where DM_ID in 
(
	select DM_ID from VG08013.ORDER_ITEM
	where order_id in 
	(
		select order_id from VG08013.[ORDER]
		where order_num='20241006000001'
	) 
)
