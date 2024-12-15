
--select * from VANGUARD.SCHEDULE_JOB where TENANT_ID=26 and SCHEDULE_JOB_CODE='EOrderPaymentStripe'

--update VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE= DATEADD(SECOND,2,GETDATE()) where TENANT_ID=26 and SCHEDULE_JOB_CODE='EOrderPaymentStripe'  

update VANGUARD.SCHEDULE_JOB    
SET NEXT_EXECUTE_DATE = DATEADD(s, 3, GETDATE()), SCHEDULER_NAME = null, LOCK_DATE = null, [STATUS] = 2, IS_CANCELED =0
where TENANT_ID=26 and SCHEDULE_JOB_CODE='EOrderPaymentStripe'

--update VANGUARD.SCHEDULE_JOB SET is_canceled=1 where TENANT_ID=26 and SCHEDULE_JOB_CODE='EOrderPaymentStripe'

--select top 10 * from VANGUARD.SCHEDULE_JOB_HISTORY where schedule_job_id = 28668 order by schedule_job_history_id desc


declare @order_number varchar(60)
set @order_number = '20231103000003'

------------------------------------

select * from VG69999.SD_PACKAGE
where order_id in 
(
  select order_id from VG69999.[ORDER]
  where order_num=@order_number
) 
----------------------------------------SD_PAYMENT_STATUS: 1 - NONE, 2- PROCESSED, 3-PRE-AUTHORIZED 

select * from Vg69999.EORDER_PAYMENT_STRIPE
where order_id in 
(
  select order_id from VG69999.[ORDER]
  where order_num=@order_number
) 


--update Vg69999.EORDER_PAYMENT_STRIPE set status = 1 where id = 105

--------------------STATUS: 1-pending, 2 - inprocess, 3- success, 4- SD error, 5 - timeout error, 6-Cancel     |    TYPE: 1-Capture, 2-Cancel, 3-Refund


select 
      op.order_id,
	  op.payment_method_id,
	  pm.payment_method_name,
	  op.payment_type_id,
	  opt.type_name,
	  op.payment_status_id,
	  ops.order_payment_status_desc,
	  op.amount,
	  op.payment_date,
	  op.is_voided
from VG69999.order_payment op
join VG69999.payment_method pm 
     on op.payment_method_id = pm.payment_method_id 
join VG69999.order_payment_type opt
     on op.payment_type_id = opt.id
join VG69999.order_payment_status ops
     on op.payment_status_id = ops.order_payment_status_id
where order_id in 
(
  select order_id from VG69999.[ORDER]
  where order_num=@order_number
) 
--------------------------------------------
select * 
from VG69999.order_payment_audit
where order_id in 
(
  select order_id from VG69999.[ORDER]
  where order_num=@order_number
) 

 

 