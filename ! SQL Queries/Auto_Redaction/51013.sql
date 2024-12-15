----Auto-Redaction--------

select GETDATE()     

select * from VANGUARD.tenant where tenant_code = 51013

select * from VANGUARD.SCHEDULE_JOB where TENANT_ID = 86 and SCHEDULE_JOB_CODE like '%Auto%'

select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID = 28823  --AutoRedactionExport
select * from VANGUARD.SCHEDULE_JOB where schedule_job_id = 28631  --AutoRedactionListenner
select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID = 28825  --AutoRedactionImport

select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID = 28796  --OrderItemContentExport

--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28823  --AutoRedactionExport
--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28631  --AutoRedactionListenner
--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28825  --AutoRedactionImport

--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28796  --OrderItemContentExport

--------------

--10 - Ready to export (waiting for export job to send image to OCR)
--20 - Ready to listen (Waiting for listener job to retrieve OCR result)
--30 - Ready to import (Waiting for import job to apply candidates and redacts to image)
--100 - Done

DECLARE @order_item INT = 85710
select * from VG51013.AUTO_REDACTION_TASK where order_item_id = @order_item
select * from VG51013.AUTO_REDACTION_ORDER_ITEM where order_item_id = @order_item

--------------------

select 
      art.order_item_id,
	  ars.status_id,
	  ars.name,
	  art.create_date,
	  art.update_date,
	  aroi.ocr_filtered_result
from VG51013.auto_redaction_task art
join VG51013.[order] o on o.order_id = art.order_id
join vanguard.auto_redaction_status ars on art.status_id = ars.status_id
join vg51013.auto_redaction_order_item aroi on aroi.order_item_id = art.order_item_id
where o.order_num = '20241015000002'

select * from vanguard.auto_redaction_status

--------------------

select top 5 * from VG51013.AUTO_REDACTION_TASK order by  order_item_id desc

---------------

select order_num from VG51013.[order]
where order_id in
(
  select order_id from  VG51013.order_item
  where order_item_id = 80918  
)

----

----

select order_item_id from  VG51013.order_item
where order_id in
(
   select order_id from VG51013.[order]
   where order_num = '20240410000027' 
)

-------------------------------

select 
      ADUSER_FIRSTNAME,
	  ADUSER_MIDDLENAME,
	  ADUSER_LASTNAME,
	  AD_USER.ADUSER_SUFFIX,
	  ADUSER_EMAILID
from VG51013.ad_user

select * from VG51013.ad_user where aduser_id = 14
--update VG51013.ad_user set aduser_enabled = 0 where aduser_id = 14


select * from VG51013.scanner where scanner_id = 6


select * from VG69999.AD_USERGROUP


select * from VG51013.appraisal

--update VG51013.appraisal set is_city_parcel = 1 where parcel_id = '01001007' 


---------------------------

SELECT ORDER_ITEM_ID, COUNT(*) AS CNT FROM VG69999.AUTO_REDACTION_TASK GROUP BY ORDER_ITEM_ID
HAVING COUNT(*) > 1


SELECT * FROM VG69999.AUTO_REDACTION_TASK WHERE UPDATE_DATE IS NULL

----------------------------

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
from VG51013.doc_master dm
join VG51013.order_item oi on oi.dm_id = dm.dm_id
join VG51013.[order] o on o.order_id = oi.order_id
--join VG51013.DM_PROPADDRESS dmp on dmp.dm_id = dm.dm_id
join VANGUARD.DEPT d  on dm.dept_id=d.dept_id
join VG51013.doc_group dg on oi.doc_group_id = dg.doc_group_id
join VG51013.doc_type dt on dm.doc_type_id = dt.doc_type_id
join VG51013.ad_user au on au.aduser_id = o.aduser_id
where o.order_num = '20241015000002'

select * from VG51013.DM_CONTENT
where DM_ID in 
(
	select DM_ID from VG51013.ORDER_ITEM
	where order_id in 
	(
		select order_id from VG51013.[ORDER]
		where order_num='20241015000002'
	) 
) order by dmc_id asc