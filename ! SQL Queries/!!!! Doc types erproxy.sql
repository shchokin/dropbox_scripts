SELECT * FROM VG69999.ERDOCTYPE_DOCTYPE ed
inner join VG69999.DOC_TYPE dt on ed.doc_type_desc = dt.doc_type_desc
inner join vg69999.DOCGROUP_DOCTYPE dgdt on dt.DOC_TYPE_ID = dgdt.DOC_TYPE_ID
inner join VG69999.WORKFLOW w on dgdt.DOC_GROUP_ID = w.DOC_GROUP_ID
where w.ORDER_ITEM_TYPE_ID = 270

select * from VG69999.order_item_type where order_item_type_id = 270

-------------

select * from VG48999.order_item_type where ORDER_ITEM_TYPE_ID in (318, 321, 357, 358)

select * from VG48999.order_item_type where order_item_type_name like '%DS%'

SELECT * FROM VG48999.ERDOCTYPE_DOCTYPE ed
inner join VG48999.DOC_TYPE dt on ed.doc_type_desc = dt.doc_type_desc
inner join vg48999.DOCGROUP_DOCTYPE dgdt on dt.DOC_TYPE_ID = dgdt.DOC_TYPE_ID
inner join VG48999.WORKFLOW w on dgdt.DOC_GROUP_ID = w.DOC_GROUP_ID
where w.ORDER_ITEM_TYPE_ID in (318, 321, 357, 358)