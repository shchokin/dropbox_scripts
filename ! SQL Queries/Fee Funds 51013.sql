declare @order_number varchar(60)
set @order_number = '20241009000003'

-----------------Recording Fee Funds-----------------------------

select 
      oiff.order_item_fee_fund_id,  
	  --oiff.feefund_id,
      ff.FEEFUND_DESC,
      oiff.OIFF_TOTAL
from VG51013.order_item_fee_fund oiff
join VG51013.fee_fund ff on oiff.feefund_id=ff.feefund_id
where order_item_id in
(
     select ORDER_ITEM_ID from VG51013.ORDER_ITEM
	 where ORDER_ID in
	 (
	   select ORDER_ID from VG51013.[order]
	   where order_num = @order_number
	 )
  )


--delete from VG51013.order_item_fee_fund where order_item_fee_fund_id = 2407
--update VG51013.order_item_fee_fund set oiff_total = 20  where order_item_fee_fund_id = 204114

----------------Additional Fee Funds---------------------

SELECT 
         oiaff.order_item_additional_fee_fund_id, 
		 --oiaff.feefund_id,
		 af.ADDITIONAL_FEE_NAME,
         oiaff.OIAFF_TOTAL 
  FROM VG51013.ORDER_ITEM_ADDITIONAL_FEE_FUND oiaff
  join VG51013.ADDITIONAL_FEE af on oiaff.ADDITIONAL_FEE_ID = af.ADDITIONAL_FEE_ID
  WHERE ORDER_ITEM_ID in
  (
     select ORDER_ITEM_ID from VG51013.ORDER_ITEM
	 where ORDER_ID in
	 (
	   select ORDER_ID from VG51013.[order]
	   where order_num = @order_number
	 )
  )
order by oiaff.feefund_id asc

--delete from VG51013.ORDER_ITEM_ADDITIONAL_FEE_FUND where order_item_additional_fee_fund_id = 15822
--update VG51013.ORDER_ITEM_ADDITIONAL_FEE_FUND set oiaff_total = 5 where order_item_additional_fee_fund_id = 3345
---------------------------------------------------

select * from VG51013.REDISTRIBUTION_HISTORY order by id desc

----------------------------------------------------------------

select * from vg51013.ORDER_ITEM_TYPE_FEE_FUND where order_item_type_id = 385 order by oitff_seq asc


--INSERT INTO vg51013.ORDER_ITEM_TYPE_FEE_FUND
--		(
--		    ORDER_ITEM_TYPE_ID,
--		    FEEFUND_ID,
--		    OITFF_VALUE,
--		    OITFF_PERCENTAGE,
--		    FEE_CODE_PARAMETER_ID,
--		    OITFF_SEQ,
--		    IS_VISIBLE_IN_RECEIPT,
--		    FEE_FUND_FORMULA,
--		    FEE_CODE_PARAMETER_ID_2,
--		    FEE_CODE_PARAMETER_ID_3,
--		    FEE_FUND_SCHEMA_1,
--		    FEE_FUND_SCHEMA_2,
--		    FEE_FUND_SCHEMA_3
--		)
--		VALUES
--		(   385,    -- ORDER_ITEM_TYPE_ID - int
--		    1,    -- FEEFUND_ID - smallint
--		    1, -- OITFF_VALUE - decimal(8, 2)
--		    100, -- OITFF_PERCENTAGE - decimal(5, 2)
--		    null,    -- FEE_CODE_PARAMETER_ID - int
--		    1,    -- OITFF_SEQ - int
--		    1, -- IS_VISIBLE_IN_RECEIPT - bit
--		    null,   -- FEE_FUND_FORMULA - varchar(50)
--		    null,    -- FEE_CODE_PARAMETER_ID_2 - int
--		    null,    -- FEE_CODE_PARAMETER_ID_3 - int
--		    null,    -- FEE_FUND_SCHEMA_1 - smallint
--		    null,    -- FEE_FUND_SCHEMA_2 - smallint
--		    null     -- FEE_FUND_SCHEMA_3 - smallint
--		    )

--update vg51013.ORDER_ITEM_TYPE_FEE_FUND set oitff_value = 9999 where order_item_type_fee_fund_id = 542
--UPDATE vg51013.ORDER_ITEM_TYPE_FEE_FUND SET OITFF_SEQ = 1 WHERE ORDER_ITEM_TYPE_ID = 362



--change config fund per oit---

--delete from vg51013.ORDER_ITEM_TYPE_FEE_FUND where order_item_type_fee_fund_id = 541


















----------------------------------------------------

select * from VG51013.ad_user where aduser_id = 8






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
from VG51013.order_payment op
join VG51013.payment_method pm 
     on op.payment_method_id = pm.payment_method_id 
join VG51013.order_payment_type opt
     on op.payment_type_id = opt.id
join VG51013.order_payment_status ops
     on op.payment_status_id = ops.order_payment_status_id
where order_id in 
(
  select order_id from VG51013.[ORDER]
  where order_num=@order_number_2
) 
-------------Payment Audit-------------------------------

select * 
from VG51013.order_payment_audit
where order_id in 
(
  select order_id from VG51013.[ORDER]
  where order_num=@order_number_2
) 

-----------Order-level Fee Funds----------------------

/* select ORDER_ID, orff.FEEFUND_ID, TOTAL, FEEFUND_DESC, IS_CONVENIENCE_FEE, * from VG51013.ORDER_FEE_FUND orff 
inner join VG51013.FEE_FUND ff on orff.FEEFUND_ID = ff.FEEFUND_ID where ORDER_ID in
(select ORDER_ID from VG51013.[ORDER] where ORDER_NUM = '20241003000003')

------------OI-level Fees----------------------------

select ORDER_ITEM_ID, oifc.FEE_CODE_PARAMETER_ID, FEE_CODE_PARAMETER_NAME, CLERK_INPUT_VALUE, * from VG51013.ORDER_ITEM_FEE_CRITERIA oifc
inner join VG51013.FEE_CODE_PARAMETER fcp on oifc.FEE_CODE_PARAMETER_ID = fcp.FEE_CODE_PARAMETER_ID
where ORDER_ITEM_ID in
(select ORDER_ITEM_ID from VG51013.ORDER_ITEM where ORDER_ID in
(select ORDER_ID from VG51013.[ORDER] where ORDER_NUM = '20241003000003'))

------------OI-level Funds----------------------------

select ORDER_ITEM_ID, oiff.FEEFUND_ID, FEEFUND_CODE, OIFF_SEQ, OIFF_TOTAL,* from VG51013.ORDER_ITEM_FEE_FUND oiff
inner join VG51013.FEE_FUND ff on oiff.FEEFUND_ID = ff.FEEFUND_ID
where ORDER_ITEM_ID in
(select ORDER_ITEM_ID from VG51013.ORDER_ITEM where ORDER_ID in
(select ORDER_ID from VG51013.[ORDER] where ORDER_NUM = '20241003000003'))  
*/

-----------------------

/*
declare @order_number varchar(60)
set @order_number = 'XXXXXXXXXXXXX'

select * from VG51013.ORDER_ITEM_ORF_HISTORY
where order_item_id in
(
     select ORDER_ITEM_ID from VG51013.ORDER_ITEM
	 where ORDER_ID in
	 (
	   select ORDER_ID from VG51013.[order]
	   where order_num = @order_number
	 )
  )
order by id desc  */




--select 
--             op.order_id,
--	  op.payment_method_id,
--	  pm.payment_method_name,
--	  op.payment_type_id,
--	  opt.type_name,
--	  op.payment_status_id,
--	  ops.order_payment_status_desc,
--	  op.amount,
--	  op.payment_date,
--	  op.is_voided
--from VG51013.order_payment op
--join VG51013.payment_method pm 
--     on op.payment_method_id = pm.payment_method_id 
--join VG51013.order_payment_type opt
--     on op.payment_type_id = opt.id
--join VG51013.order_payment_status ops
--     on op.payment_status_id = ops.order_payment_status_id
--where order_id in 
--(
--  select order_id from VG51013.[ORDER]
--  where order_num='20241009000002'
--) 
--order by payment_date desc

