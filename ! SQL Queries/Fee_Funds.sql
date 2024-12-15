declare @order_number varchar(60)
set @order_number = '20241004000036'

-----------------Recording Fee Funds-----------------------------

select 
      oiff.order_item_fee_fund_id,  
	  oiff.feefund_id,
      ff.FEEFUND_DESC,
      oiff.OIFF_TOTAL
from VG48999.order_item_fee_fund oiff
join VG48999.fee_fund ff on oiff.feefund_id=ff.feefund_id
where order_item_id in
(
     select ORDER_ITEM_ID from VG48999.ORDER_ITEM
	 where ORDER_ID in
	 (
	   select ORDER_ID from VG48999.[order]
	   where order_num = @order_number
	 )
  )
order by oiff.order_item_fee_fund_id asc

--delete from VG48999.order_item_fee_fund where order_item_fee_fund_id = 204151
--update VG48999.order_item_fee_fund set oiff_total = 20  where order_item_fee_fund_id = 204114

----------------Additional Fee Funds---------------------

SELECT 
         oiaff.order_item_additional_fee_fund_id, 
		 oiaff.feefund_id,
		 af.ADDITIONAL_FEE_NAME,
         oiaff.OIAFF_TOTAL 
  FROM VG48999.ORDER_ITEM_ADDITIONAL_FEE_FUND oiaff
  join VG48999.ADDITIONAL_FEE af on oiaff.ADDITIONAL_FEE_ID = af.ADDITIONAL_FEE_ID
  WHERE ORDER_ITEM_ID in
  (
     select ORDER_ITEM_ID from VG48999.ORDER_ITEM
	 where ORDER_ID in
	 (
	   select ORDER_ID from VG48999.[order]
	   where order_num = @order_number
	 )
  )

--delete from VG48999.ORDER_ITEM_ADDITIONAL_FEE_FUND where order_item_additional_fee_fund_id = 3377
--update VG48999.ORDER_ITEM_ADDITIONAL_FEE_FUND set oiaff_total = 5 where order_item_additional_fee_fund_id = 3345
---------------------------------------------------

select * from VG48999.REDISTRIBUTION_HISTORY order by id desc

select * from vg48999.ORDER_ITEM_TYPE_FEE_FUND where order_item_type_id = 39 order by oitff_seq asc
--change config fund per oit---
--update vg48999.ORDER_ITEM_TYPE_FEE_FUND set oitff_value = 50 where order_item_type_fee_fund_id = 68

select * from vg48999.ORDER_ITEM_TYPE_FEE_FUND where order_item_type_id = 1 order by oitff_seq asc
--update vg48999.ORDER_ITEM_TYPE_FEE_FUND set oitff_value = 10 where order_item_type_fee_fund_id = 1
















----------------------------------------------------

select * from VG48999.ad_user where aduser_id = 8






declare @order_number_2 varchar(60)
set @order_number_2 = '20241003000003'

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
from VG48999.order_payment op
join VG48999.payment_method pm 
     on op.payment_method_id = pm.payment_method_id 
join VG48999.order_payment_type opt
     on op.payment_type_id = opt.id
join VG48999.order_payment_status ops
     on op.payment_status_id = ops.order_payment_status_id
where order_id in 
(
  select order_id from VG48999.[ORDER]
  where order_num=@order_number_2
) 
-------------Payment Audit-------------------------------

select * 
from VG48999.order_payment_audit
where order_id in 
(
  select order_id from VG48999.[ORDER]
  where order_num=@order_number_2
) 

-----------Order-level Fee Funds----------------------

/* select ORDER_ID, orff.FEEFUND_ID, TOTAL, FEEFUND_DESC, IS_CONVENIENCE_FEE, * from VG48999.ORDER_FEE_FUND orff 
inner join VG48999.FEE_FUND ff on orff.FEEFUND_ID = ff.FEEFUND_ID where ORDER_ID in
(select ORDER_ID from VG48999.[ORDER] where ORDER_NUM = '20241003000003')

------------OI-level Fees----------------------------

select ORDER_ITEM_ID, oifc.FEE_CODE_PARAMETER_ID, FEE_CODE_PARAMETER_NAME, CLERK_INPUT_VALUE, * from VG48999.ORDER_ITEM_FEE_CRITERIA oifc
inner join VG48999.FEE_CODE_PARAMETER fcp on oifc.FEE_CODE_PARAMETER_ID = fcp.FEE_CODE_PARAMETER_ID
where ORDER_ITEM_ID in
(select ORDER_ITEM_ID from VG48999.ORDER_ITEM where ORDER_ID in
(select ORDER_ID from VG48999.[ORDER] where ORDER_NUM = '20241003000003'))

------------OI-level Funds----------------------------

select ORDER_ITEM_ID, oiff.FEEFUND_ID, FEEFUND_CODE, OIFF_SEQ, OIFF_TOTAL,* from VG48999.ORDER_ITEM_FEE_FUND oiff
inner join VG48999.FEE_FUND ff on oiff.FEEFUND_ID = ff.FEEFUND_ID
where ORDER_ITEM_ID in
(select ORDER_ITEM_ID from VG48999.ORDER_ITEM where ORDER_ID in
(select ORDER_ID from VG48999.[ORDER] where ORDER_NUM = '20241003000003'))  
*/

-----------------------

/*
declare @order_number varchar(60)
set @order_number = 'XXXXXXXXXXXXX'

select * from VG69999.ORDER_ITEM_ORF_HISTORY
where order_item_id in
(
     select ORDER_ITEM_ID from VG69999.ORDER_ITEM
	 where ORDER_ID in
	 (
	   select ORDER_ID from VG69999.[order]
	   where order_num = @order_number
	 )
  )
order by id desc  */

