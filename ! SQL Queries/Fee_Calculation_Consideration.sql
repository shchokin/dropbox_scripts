select  
      af.ADDITIONAL_FEE_NAME,
	  afp.ADDITIONAL_FEE_PARAMETER_NAME,
	  afp.ADDITIONAL_FEE_PARAMETER_VALUE
from VG69999.additional_fee af
join VG69999.ADDITIONAL_FEE_ADDITIONAL_FEE_PARAMETER  afafp on
     af.ADDITIONAL_FEE_ID = afafp.ADDITIONAL_FEE_ID
join VG69999.ADDITIONAL_FEE_PARAMETER afp on
     afp.ADDITIONAL_FEE_PARAMETER_ID = afafp.ADDITIONAL_FEE_PARAMETER_ID 
where additional_fee_name like '%County Transfer Tax%'
      AND afp.ADDITIONAL_FEE_PARAMETER_NAME in ('TaxRate', 'Increment', 'MinConsideration')



---------------------------------------------------------------------------------------

--- Consideration amount more than MinConsideration

---                 Tax = (Consideration  Amount / increment )  *  tax_rate
---  County Transfer Tax =           (    1500   / 500 )         *  0.55       = 1.65
---                                  (    2000   / 500 )         *  0.55       = 2.2
---                                  (    2500   / 500 )         *  0.55       = 2.75

-----------------------------------------------------------------------------------------------

--- Consideration amount less than MinConsideration e.g 500, 600, 700 etc.

--                  Tax = (Min Consideration Amount / increment )  *  tax_rate         
--                                           (1000 / 500)          *  0.55     = 1.1
--  County Transfer Tax =


-----------------------------------------------------------------------------------------------

--- Consideration amount more than MinConsideration

---                 Tax = (Consideration  Amount / increment )  *  tax_rate
---  State Transfer Tax =           (    1500   / 500 )         *  1.3        = 3.9
---                                 (    2000   / 500 )         *  1.3        = 5.2
---                                 (    2500   / 500 )         *  1.3        = 6.5

-----------------------------------------------------------------------------------------------

--- Consideration amount less than MinConsideration e.g 500, 600, 700 etc.

--                  Tax = (Min Consideration Amount / increment )  *  tax_rate         
--                                           (1000 / 500)          *  1.3       = 2.6
--  State Transfer Tax =


SELECT af.ADDITIONAL_FEE_NAME,
         oiaff.OIAFF_TOTAL 
  FROM VG69999.ORDER_ITEM_ADDITIONAL_FEE_FUND oiaff
  join VG69999.ADDITIONAL_FEE af on oiaff.ADDITIONAL_FEE_ID = af.ADDITIONAL_FEE_ID
  WHERE ORDER_ITEM_ID in
  (
     select ORDER_ITEM_ID from VG69999.ORDER_ITEM
	 where ORDER_ID in
	 (
	   select ORDER_ID from VG69999.[order]
	   where order_num = '20230214000023'
	 )
  )


------------------------------------------------------48999------------------------------------------------------------------

select  
      af.ADDITIONAL_FEE_NAME,
	  afp.ADDITIONAL_FEE_PARAMETER_NAME,
	  afp.ADDITIONAL_FEE_PARAMETER_VALUE
from VG48999.additional_fee af
join VG48999.ADDITIONAL_FEE_ADDITIONAL_FEE_PARAMETER  afafp on
     af.ADDITIONAL_FEE_ID = afafp.ADDITIONAL_FEE_ID
join VG48999.ADDITIONAL_FEE_PARAMETER afp on
     afp.ADDITIONAL_FEE_PARAMETER_ID = afafp.ADDITIONAL_FEE_PARAMETER_ID 
where additional_fee_name like '%Conveyance Fee OH%'
      AND afp.ADDITIONAL_FEE_PARAMETER_NAME in ('TaxRate', 'Increment', 'MinConsideration')

---------------------------------------------------------------------------------------

--- Consideration amount more than MinConsideration

---                 Tax = (Consideration  Amount / increment )  *  tax_rate

--- Conveyance Fee OH =              (    2000   / 1000 )         *  4       = 8
---                                  (    3000   / 1000 )         *  4       = 12
---                                  (    4000   / 1000 )         *  4       = 16

-----------------------------------------------------------------------------------------------

--- Consideration amount less than MinConsideration e.g 500, 600, 700 etc.

--                  Tax = (Min Consideration Amount / increment )  *  tax_rate         

-- Conveyance Fee OH                         (1000 / 1000)          * 4     = 4


SELECT af.ADDITIONAL_FEE_NAME,
         oiaff.OIAFF_TOTAL 
  FROM VG48999.ORDER_ITEM_ADDITIONAL_FEE_FUND oiaff
  join VG48999.ADDITIONAL_FEE af on oiaff.ADDITIONAL_FEE_ID = af.ADDITIONAL_FEE_ID
  WHERE ORDER_ITEM_ID in
  (
     select ORDER_ITEM_ID from VG48999.ORDER_ITEM
	 where ORDER_ID in
	 (
	   select ORDER_ID from VG48999.[order]
	   where order_num = '20230214000007'
	 )
  )







-------------------------------------------------------------------------------------------------
select * from VG69999.additional_fee where ADDITIONAL_FEE_NAME like '%Transfer%'
select * from VG69999.ADDITIONAL_FEE_ADDITIONAL_FEE_PARAMETER 
select * from VG69999.ADDITIONAL_FEE_PARAMETER where additional_fee_parameter_name in ('TaxRate', 'Increment', 'MinConsideration')
--update VG69999.ADDITIONAL_FEE_PARAMETER set ADDITIONAL_FEE_PARAMETER_VALUE = 1000 where additional_fee_parameter_name = 'MinConsideration' 

-----------------------
select 
      ADDITIONAL_FEE_NAME,
	  ADDITIONAL_FEE_TAX_RATE,
	  PRE_DETERMINED_INCREMENT,
	  IS_TAX_TYPE
from VG69999.additional_fee where additional_fee_name = 'County Transfer Tax' 


 
select * from VG69999.order_item_type where order_item_type_id = 249  --Real Property With Transfer Tax SC 
select * from VG69999.order_item_type where order_item_type_id = 318  --Real Property OH




SELECT * FROM VG69999.ORDER_ITEM_ADDITIONAL_FEE_FUND WHERE ORDER_ITEM_ID = 550353


-----------------

select * from VG48999.order_item_type where order_item_type_id = 318  --Real Property OH
