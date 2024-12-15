select * from VG69999.doc_type where DOC_TYPE_DESC = 'DEED'

select * from VG69999.doc_type where doc_type_code = 'DQC'

select * from VG69999.doc_type_additional_fee


select 
       dt.DOC_TYPE_DESC,
	   af.ADDITIONAL_FEE_NAME,
	   af.ADDITIONAL_FEE_COST
from VG69999.doc_type_additional_fee dtaf
join VG69999.doc_type dt on dtaf.doc_type_id = dt.doc_type_id
join VG69999.additional_fee af on af.additional_fee_id = dtaf.additional_fee_id
where  dtaf.is_mandatory = 1


select 
      additional_fee_id,
      additional_fee_name,
	  additional_fee_cost,
	  additional_fee_is_mandatary 
from VG69999.additional_fee 
where additional_fee_is_mandatary = 1

select *  
from VG69999.additional_fee 

select *  
from VG69999.order_item_type_additional_fee 
where order_item_type_id = 282



--select * from VG69999.ORDER_ITEM_TYPE_DOC_TYPE where order_item_type_id = 282
--update VG69999.ORDER_ITEM_TYPE_DOC_TYPE set is_default = 1 where order_item_type_id = 282 and DOC_TYPE_ID_DOC=28201


select * from VG69999.intranet_device where device_desc like '%Artyom%'
