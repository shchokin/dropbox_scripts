----Auto-Redaction--------

select GETDATE()     

select * from VANGUARD.tenant where tenant_code = 48999

select * from VANGUARD.SCHEDULE_JOB where TENANT_ID = 63 and SCHEDULE_JOB_CODE like '%Auto%'

select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID = 28625  --AutoRedactionExport
select * from VANGUARD.SCHEDULE_JOB where schedule_job_id = 28631  --AutoRedactionListenner
select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID = 28627  --AutoRedactionImport

select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID = 28674  --OrderItemContentExport

--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28625  --AutoRedactionExport
--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28631  --AutoRedactionListenner
--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28627  --AutoRedactionImport

--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28674  --OrderItemContentExport

--------------

--10 - Ready to export (waiting for export job to send image to OCR)
--20 - Ready to listen (Waiting for listener job to retrieve OCR result)
--30 - Ready to import (Waiting for import job to apply candidates and redacts to image)
--100 - Done

DECLARE @order_item INT = 85710
select * from VG48999.AUTO_REDACTION_TASK where order_item_id = @order_item
select * from VG48999.AUTO_REDACTION_ORDER_ITEM where order_item_id = @order_item

--------------------

select 
      art.order_item_id,
	  ars.status_id,
	  ars.name,
	  art.create_date,
	  art.update_date,
	  aroi.ocr_filtered_result
from VG48999.auto_redaction_task art
join VG48999.[order] o on o.order_id = art.order_id
join vanguard.auto_redaction_status ars on art.status_id = ars.status_id
join vg48999.auto_redaction_order_item aroi on aroi.order_item_id = art.order_item_id
where o.order_num = '20240506000134'

select * from vanguard.auto_redaction_status

--------------------

select top 5 * from VG48999.AUTO_REDACTION_TASK order by  order_item_id desc

---------------

select order_num from VG48999.[order]
where order_id in
(
  select order_id from  VG48999.order_item
  where order_item_id = 80918  
)

----

----

select order_item_id from  VG48999.order_item
where order_id in
(
   select order_id from VG48999.[order]
   where order_num = '20240410000027' 
)

-------------------------------

select 
      ADUSER_FIRSTNAME,
	  ADUSER_MIDDLENAME,
	  ADUSER_LASTNAME,
	  AD_USER.ADUSER_SUFFIX,
	  ADUSER_EMAILID
from VG48999.ad_user

select * from VG48999.ad_user where aduser_id = 14
--update VG48999.ad_user set aduser_enabled = 0 where aduser_id = 14


select * from VG48999.scanner where scanner_id = 6