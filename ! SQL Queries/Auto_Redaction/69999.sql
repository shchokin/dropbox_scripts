----Auto-Redaction--------

select GETDATE()     

select * from VANGUARD.tenant where tenant_code = 48999

select * from VANGUARD.SCHEDULE_JOB where TENANT_ID = 26 and SCHEDULE_JOB_CODE like '%Auto%'
select top 50 * from VANGUARD.SCHEDULE_JOB_HISTORY order by schedule_job_history_id desc

select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID = 28388  --AutoRedactionExport
select * from VANGUARD.SCHEDULE_JOB where schedule_job_id = 28631  --AutoRedactionListenner
select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID = 28390   --AutoRedactionImport

select * from VANGUARD.SCHEDULE_JOB where SCHEDULE_JOB_ID =   --OrderItemContentExport



--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28388  --AutoRedactionExport
--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28631  --AutoRedactionListenner
--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28390  --AutoRedactionImport

--UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID =   --OrderItemContentExport

--------------

--10 - Ready to export (waiting for export job to send image to OCR)
--20 - Ready to listen (Waiting for listener job to retrieve OCR result)
--30 - Ready to import (Waiting for import job to apply candidates and redacts to image)
--100 - Finish

DECLARE @order_item INT = 583003
select * from VG48999.AUTO_REDACTION_TASK where order_item_id = @order_item
select * from VG48999.AUTO_REDACTION_ORDER_ITEM where order_item_id = @order_item

---------------

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
where o.order_num = '20240506000028'

select * from vanguard.auto_redaction_status



--------------

select top 5 * from VG48999.AUTO_REDACTION_TASK order by  order_item_id desc

---------------

select order_num from VG48999.[order]
where order_id in
(
  select order_id from  VG48999.order_item
  where order_item_id = 80918  
)

----

select order_item_id from  VG48999.order_item
where order_id in
(
   select order_id from VG48999.[order]
   where order_num = '20240409000041' 
)

-------------

select * from VG69999.payment_method where is_refundable=1

--update  VG69999.payment_method set refund_days=180 where is_refundable=1
