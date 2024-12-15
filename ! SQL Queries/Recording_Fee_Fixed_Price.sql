select * from Vg51013.erdoctype_doctype where erdoctype_desc = 'ELRDCCN'
select * from Vg51013.doc_type where doc_type_code = 'ELRDCCN'



--------Fee Calc: fixed price-----------------

select * from Vg51013.doc_type where doc_type_code = 'LRDCCN'


SELECT *
FROM VG51013.ORDER_ITEM_TYPE_DOC_TYPE oitdt
JOIN VG51013.DOC_TYPE dt ON dt.DOC_TYPE_ID = oitdt.DOC_TYPE_ID_DOC
WHERE order_item_type_id = 362
      and dt.doc_type_code = 'LRDCCN' 

--update VG51013.ORDER_ITEM_TYPE_DOC_TYPE set is_default = 1 where order_item_type_id = 362 and doc_type_id_doc = 240

----------------------------------------------------


select * from VG51013.doc_type where doc_type_id in (83, 145, 240, 241) 
select * from VG51013.doc_type_fee_code_parameter
select * from VG51013.fee_code_parameter where fee_code_parameter_id in (231111, 231122)


---------------------------------------






go
select
ORDER_ITEM_TYPE_ID,
CONCAT('Workflow_',ORDER_ITEM_TYPE_NAME,'.xml') as CONFIGURATION,
IS_ACTIVE,
ORDER_ITEM_TYPE_DISPLAY_NAME,
HAS_COVER_PAGE
from VG51013.ORDER_ITEM_TYPE
WHERE ORDER_ITEM_TYPE_ID=39



------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM VG48999.ERDOCTYPE_DOCTYPE ed
inner join VG48999.DOC_TYPE dt on ed.doc_type_desc = dt.doc_type_desc
inner join vg48999.DOCGROUP_DOCTYPE dgdt on dt.DOC_TYPE_ID = dgdt.DOC_TYPE_ID
inner join VG48999.WORKFLOW w on dgdt.DOC_GROUP_ID = w.DOC_GROUP_ID
where w.ORDER_ITEM_TYPE_ID in (318, 321)
