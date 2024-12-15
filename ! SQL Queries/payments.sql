select
  dm.DEPT_ID,
   d.dept_desc,
  oit.ORDER_ITEM_TYPE_ID,
  oit.ORDER_ITEM_TYPE_DISPLAY_NAME,
  oi.doc_group_id,
  dg.doc_group_desc,
  dt.doc_type_id,
  dt.doc_type_desc,
  dm.DM_YEAR, 
  dm.DM_BK,
  dm.DM_PAGE,
  dm.CF_VCINSTNUM,
  pt.PTYPE_DESC,
  dmp.PARTY_NAME1,
  dmp.PARTY_NAME2
from VG48999.doc_master dm
join VANGUARD.DEPT d  on dm.dept_id=d.dept_id
join VG48999.order_item oi on dm.dm_id = oi.dm_id
join VG48999.order_item_type oit on oit.ORDER_ITEM_TYPE_ID = oi.ORDER_ITEM_TYPE_ID
join VG48999.doc_group dg on oi.doc_group_id = dg.doc_group_id
join VG48999.doc_type dt on dm.doc_type_id = dt.doc_type_id
join VG48999.DM_PARTIES dmp on dmp.DM_ID = dm.DM_ID
join VG48999.PARTY_TYPE pt on pt.PTYPE_ID = dmp.PTYPE_ID
where dm.dm_id in
(
select DM_ID from VG48999.ORDER_ITEM
where order_id in (
select order_id from VG48999.[ORDER]
where order_num='20230310000006'
) )

select * from VG48999.order_item_type where ORDER_ITEM_TYPE_NAME like '%historical%'

select * from VANGUARD.dept where DEPT_ID=6
select * from VG48999.[ORDER]    where order_num='20230310000006' 

select * from VG48999.ORDER_ITEM where ORDER_ID = 845

select * from VG48999.doc_group where DOC_GROUP_ID = 6 

select * from VG48999.DOCGROUP_DOCTYPE where DOC_GROUP_ID = 4 

select * from VG48999.DOC_MASTER where  dm_id = 439

select * from VG48999.DOC_TYPE where DOC_TYPE_CODE = 'MARRIAGE'



select
       op.order_payment_id,
	   op.order_id,
	   op.amount,
	   pm.payment_method_description,
	   pm.is_refundable,
	   pm.refund_days,
	   pm.is_voidable,
	   op.is_voided,
	   opt.type_name,
	   ops.order_payment_status_desc
from VG48999.order_payment op
join VG48999.payment_method pm on op.payment_method_id = pm.payment_method_id
join VG48999.order_payment_type opt on opt.id = op.payment_type_id
join VG48999.order_payment_status ops on ops.order_payment_status_id = op.payment_status_id
--join VG48999.order_payment_audit opa on opa.ORDER_PAYMENT_ID = op.ORDER_PAYMENT_ID
where op.order_id in 
(
  select order_id from VG48999.[order]
  where order_num = '20230309000012'
)


select * from VG48999.order_payment
select * from VG48999.payment_method
select * from VG48999.order_payment_type
select * from VG48999.order_payment_status

select * from VG48999.order_payment_audit
where order_id in 
(
  select order_id from VG48999.[order]
  where order_num = '20230309000012'
)

--select * from VG48999.ORDER_PAYMENT_SUBSTITUTION

--select * from VG48999.ORDER_ITEM_TYPE_PAYMENT_METHOD