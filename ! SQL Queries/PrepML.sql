select * from VG69999.DOCGROUP_NUMPOOL_BOOKPOOL where DOC_GROUP_ID = 6
--update VG69999.DOCGROUP_NUMPOOL_BOOKPOOL set APNP_ID = 1 where DOC_GROUP_ID = 6
--select * from VG69999.NUM_POOL where NP_ID = 9
select * from VG69999.APP_NUM_POOL


--select * from VG69999.DM_EXTENDED --where dm_id = 232839
--select * from VG69999.NUM_POOL_RESERVED
insert into VG69999.NUM_POOL_RESERVED values (9,'100') 

select
  dm.DEPT_ID,
  oi.doc_group_id,
  dg.doc_group_desc,
  dt.doc_type_id,
  dt.doc_type_desc,
  dm.DM_YEAR, 
  dm.DM_BK,
  dm.DM_PAGE,
  dm.CF_VCINSTNUM,
  dm.DM_ID,
  oi.DOCUMENT,
  de.APP_NUM
from VG69999.doc_master dm
join VG69999.order_item oi on dm.dm_id = oi.dm_id
join VG69999.doc_group dg on oi.doc_group_id = dg.doc_group_id
join VG69999.doc_type dt on dm.doc_type_id = dt.doc_type_id
join VG69999.DM_EXTENDED de on de.dm_id = dm.dm_id
where dm.dm_id in
(
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num='20230116000005'
) )


select * from VG69999.PREP_ML_DOC_HISTORY order by number desc

