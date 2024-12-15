declare @order_number varchar(60)
set @order_number = '20240521000050'

select --oioh.ID,
       oioh.RECORD_DATE,
	   oioh.ADUSER_ID,
	   oioh.WORKSTATION_ID,
	   oioh.LOCATION_ID,
	   oioh.FEEFUND_ID,
	   oioh.ORDER_ITEM_ID,
	   ff.FEEFUND_DESC,
	   oioh.OIFF_TOTAL--,
	   --oitff.oitff_seq
from VG69999.ORDER_ITEM_ORF_HISTORY oioh
join VG69999.fee_fund ff on oioh.feefund_id=ff.feefund_id
--join VG69999.ORDER_ITEM oi on oioh.order_item_id = oi.order_item_id
--join VG69999.ORDER_ITEM_TYPE_FEE_FUND oitff on oitff.order_item_type_id = oi.order_item_type_id
where oioh.order_item_id in
(
     select ORDER_ITEM_ID from VG69999.ORDER_ITEM
	 where ORDER_ID in
	 (
	   select ORDER_ID from VG69999.[order]
	   where order_num = @order_number
	 )
  )
order by  oioh.RECORD_DATE desc, oioh.FEEFUND_ID asc

--------------------------------------------------

--select * from VG69999.ORDER_ITEM_TYPE_FEE_FUND
--select * from VG69999.ORDER_ITEM_FEE_FUND 

/*
select * from VG69999.ORDER_ITEM_TYPE_FEE_FUND
where  ORDER_ITEM_TYPE_ID in 
(
  select ORDER_ITEM_TYPE_ID from VG69999.ORDER_ITEM
	 where ORDER_ID in
	 (
	   select ORDER_ID from VG69999.[order]
	   where order_num = '20240517000012'
	 )
)*/


--select * from VG69999.ORDER_ITEM_ORF_HISTORY order by record_date desc







-------------------------------------------------

--select * from VG69999.ORDER_ITEM_ORF_HISTORY