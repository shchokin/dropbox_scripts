/*UPDATE VG69999.AD_USER_AD_USERGROUP SET AD_USERGROUP_ID = 10
where ADUSER_ID in(
select ADUSER_ID from VG69999.AD_USER
where ADUSER_LASTNAME='Shchokin'
)*/



select 
      oia.*,
	  ois.order_item_status_desc
from VG48999.order_item_audit oia
join VANGUARD.ORDER_ITEM_STATUS ois on oia.value = ois.order_item_status_id and oia.order_item_column = 'STATUS'
where ORDER_ID in
 (
   select order_id from VG48999.[ORDER]
    where order_num='20240607000006'
 ) 
order by order_item_audit_id desc


 SELECT aduser_id, aduser_firstname, aduser_lastname FROM VG48999.ad_user
where aduser_id in (33, 24)


select * from VG48999.order_item_audit where order_id = 55645

------------------------------------------

select 
      oia.*,
	  ois.order_item_status_desc
from VG69999.order_item_audit oia
join VANGUARD.ORDER_ITEM_STATUS ois on oia.value = ois.order_item_status_id 
where ORDER_ID in
 (
   select order_id from VG69999.[ORDER]
    where order_num='20240530000006'
 ) 
order by order_item_audit_id desc



































