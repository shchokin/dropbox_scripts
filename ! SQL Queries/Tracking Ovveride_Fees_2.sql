DECLARE @order_number VARCHAR(60) = '20240517000013'
DECLARE @order_item_id bigint
SELECT @order_item_id = OI.ORDER_ITEM_ID
FROM VG69999.ORDER_ITEM OI JOIN vg69999.[ORDER] O ON O.ORDER_ID = OI.ORDER_ID
WHERE O.ORDER_NUM = @order_number



select 
       oioh.RECORD_DATE,
     oioh.ADUSER_ID,
     oioh.WORKSTATION_ID,
     oioh.LOCATION_ID,
     oioh.FEEFUND_ID,
     oioh.ORDER_ITEM_ID,
     ff.FEEFUND_DESC,
     oioh.OIFF_TOTAL,
     OIFF.OIFF_SEQ
from VG69999.ORDER_ITEM_ORF_HISTORY oioh
join VG69999.fee_fund ff on oioh.feefund_id=ff.feefund_id
join VG69999.ORDER_ITEM_FEE_FUND OIFF on oioh.ORDER_ITEM_ID = OIFF.order_item_id AND OIFF.FEEFUND_ID = ff.FEEFUND_ID
where oioh.order_item_id = @order_item_id
ORDER BY OIFF.OIFF_SEQ