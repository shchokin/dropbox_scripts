	select * from VG48029.order_item_type
	where order_item_type_id in
	(
	  select order_item_type_id from VG48029.workflow
	  where tenant_origin_id in
	  (
		select tenant_origin_id from VG48029.tenant_origin
		where origin_id = 5 --erProxy (VANGUARD)
	  )
	)



	SELECT * FROM VG48029.ERDOCTYPE_DOCTYPE ed
	inner join VG48029.DOC_TYPE dt on ed.doc_type_desc = dt.doc_type_desc
	inner join vg48029.DOCGROUP_DOCTYPE dgdt on dt.DOC_TYPE_ID = dgdt.DOC_TYPE_ID
	inner join VG48029.WORKFLOW w on dgdt.DOC_GROUP_ID = w.DOC_GROUP_ID
    where w.ORDER_ITEM_TYPE_ID = 39


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
  dm.CF_VCINSTNUM
  --pt.PTYPE_DESC,
  --dmp.PARTY_NAME1,
  --dmp.PARTY_NAME2
from VG48029.doc_master dm
join VANGUARD.DEPT d  on dm.dept_id=d.dept_id
join VG48029.order_item oi on dm.dm_id = oi.dm_id
join VG48029.order_item_type oit on oit.ORDER_ITEM_TYPE_ID = oi.ORDER_ITEM_TYPE_ID
join VG48029.doc_group dg on oi.doc_group_id = dg.doc_group_id
join VG48029.doc_type dt on dm.doc_type_id = dt.doc_type_id
--join VG48029.DM_PARTIES dmp on dmp.DM_ID = dm.DM_ID
--join VG48029.PARTY_TYPE pt on pt.PTYPE_ID = dmp.PTYPE_ID
where dm.dm_id in
(
select DM_ID from VG48029.ORDER_ITEM
where order_id in (
select order_id from VG48029.[ORDER]
where order_num='20241128000006'
) )


-------------

select 
      vq.order_id,
	  vq.order_num,
	  dm.dm_recorded,
	  vq.department_name,
	  vq.verification_task_status_group_name,
	  vq.origin_desc,
	  vq.verification_task_id,
	  vq.verification_task_priority,
	  vq.verification_task_status_id
from VG48029.verification_queue vq 
join VG48029.order_item oi on oi.order_id = vq.order_id
join VG48029.doc_master dm on dm.dm_id = oi.dm_id
order by vq.department_name ASC, dm.dm_recorded ASC

--20241128000001            