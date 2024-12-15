--SELECT * FROM [VG69999].[GetAccountBalance](2, DEFAULT) AS AccountBalance 
--SELECT * FROM [VG69999].account


declare @order_number varchar(60)
set @order_number = '20240708000010'

----------------Payment details--------------------

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
order by payment_date desc

-------------Payment Audit---------------

select * 
from VG69999.order_payment_audit
where order_id in 
(
  select order_id from VG69999.[ORDER]
  where order_num=@order_number
) 
AND ORDER_PAYMENT_COLUMN = 'AMOUNT'
order by order_payment_audit_id desc


select * from Vg69999.order_item_fee_fund
where ORDER_ITEM_ID in
(
	select ORDER_ITEM_ID from VG69999.ORDER_ITEM
	where ORDER_ID in
	(
		select order_id from VG69999.[ORDER]
		where order_num='20240708000010'
    )
)

