---------------------------69999----------------------------------

-- (287) RP - ERecording Arlington  --> (167) DQC  -> configured Consideration, Override Recording/Additional Fees actions   DSC + Assesed Value


---------------------------ErProxy--------------

select * from VG69999.order_item_type
where order_item_type_id in
(
  select order_item_type_id from VG69999.workflow
  where tenant_origin_id in
  (
	select tenant_origin_id from VG69999.tenant_origin
	where origin_id = 5 --erProxy (VANGUARD)
  )
)

---------------------------example: 'Deed'

SELECT * FROM VG69999.ERDOCTYPE_DOCTYPE ed
inner join VG69999.DOC_TYPE dt on ed.doc_type_desc = dt.doc_type_desc
inner join vg69999.DOCGROUP_DOCTYPE dgdt on dt.DOC_TYPE_ID = dgdt.DOC_TYPE_ID
inner join VG69999.WORKFLOW w on dgdt.DOC_GROUP_ID = w.DOC_GROUP_ID
where w.ORDER_ITEM_TYPE_ID = 287

---------------------------ErProxyDS------------

select * from VG69999.order_item_type
where order_item_type_id in
(
  select order_item_type_id from VG69999.workflow
  where tenant_origin_id in
  (
	select tenant_origin_id from VG69999.tenant_origin
	where origin_id = 20 --erProxyDS (VANGUARD)
  )
)

---------------------------example: 'Deed'

SELECT * FROM VG69999.ERDOCTYPE_DOCTYPE ed
inner join VG69999.DOC_TYPE dt on ed.doc_type_desc = dt.doc_type_desc
inner join vg69999.DOCGROUP_DOCTYPE dgdt on dt.DOC_TYPE_ID = dgdt.DOC_TYPE_ID
inner join VG69999.WORKFLOW w on dgdt.DOC_GROUP_ID = w.DOC_GROUP_ID
where w.ORDER_ITEM_TYPE_ID = 270 

---------------------------48999----------------------------------

---------------------------ErProxy---------------

select * from VG48999.order_item_type
where order_item_type_id in
(
  select order_item_type_id from VG48999.workflow
  where tenant_origin_id in
  (
	select tenant_origin_id from VG48999.tenant_origin
	where origin_id = 5 --erProxy (VANGUARD)
  )
)

---------------------------example: 'DeedOfTrust'

SELECT * FROM VG48999.ERDOCTYPE_DOCTYPE ed
inner join VG48999.DOC_TYPE dt on ed.doc_type_desc = dt.doc_type_desc
inner join vg48999.DOCGROUP_DOCTYPE dgdt on dt.DOC_TYPE_ID = dgdt.DOC_TYPE_ID
inner join VG48999.WORKFLOW w on dgdt.DOC_GROUP_ID = w.DOC_GROUP_ID
where w.ORDER_ITEM_TYPE_ID = 39 

---------------------------ErProxyDS-------------

select * from VG48999.order_item_type
where order_item_type_id in
(
  select order_item_type_id from VG48999.workflow
  where tenant_origin_id in
  (
	select tenant_origin_id from VG48999.tenant_origin
	where origin_id = 20 --erProxyDS (VANGUARD)
  )
)

---------------------------example: 'DEED - AFFIDAVIT'

SELECT * FROM VG48999.ERDOCTYPE_DOCTYPE ed
inner join VG48999.DOC_TYPE dt on ed.doc_type_desc = dt.doc_type_desc
inner join vg48999.DOCGROUP_DOCTYPE dgdt on dt.DOC_TYPE_ID = dgdt.DOC_TYPE_ID
inner join VG48999.WORKFLOW w on dgdt.DOC_GROUP_ID = w.DOC_GROUP_ID
where w.ORDER_ITEM_TYPE_ID = 333


---------------------------51013----------------------------------

--(39)RP - ERecording -> (5)ELRB&S   -> Configured Consideration, Assesed Value, No Fee, Configured Override Recording/Additional Fees    
                            --ELRASSUMPT    


---------------------------ErProxy--------------

select * from VG51013.order_item_type
where order_item_type_id in
(
  select order_item_type_id from VG51013.workflow
  where tenant_origin_id in
  (
	select tenant_origin_id from VG51013.tenant_origin
	where origin_id = 5 
  )
)

---------------------------

SELECT * FROM VG51013.ERDOCTYPE_DOCTYPE ed
inner join VG51013.DOC_TYPE dt on ed.doc_type_desc = dt.doc_type_desc
inner join vg51013.DOCGROUP_DOCTYPE dgdt on dt.DOC_TYPE_ID = dgdt.DOC_TYPE_ID
inner join VG51013.WORKFLOW w on dgdt.DOC_GROUP_ID = w.DOC_GROUP_ID
where w.ORDER_ITEM_TYPE_ID = 39

-----------------------------------

SELECT * FROM VG51013.ERDOCTYPE_DOCTYPE

select 
* 
from Vg51013.DOCGROUP_DOCTYPE dd
join Vg51013.doc_type dt on dt.doc_type_id = dd.doc_type_id
where doc_group_id = 1


SELECT * FROM VG51013.appraisal


GETDATE