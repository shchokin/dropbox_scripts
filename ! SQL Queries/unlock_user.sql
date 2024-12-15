declare @order_num varchar(50) = '20240925000038' 

select cle.*, au.aduser_domain, au.aduser_firstname, au.aduser_lastname 
from VG48999.crs_locked_element cle
join VG48999.ad_user au on cle.aduser_id = au.aduser_id
where element_id in
(
  select order_id from VG48999.[order]
  where order_num = @order_num
)
-----------------------------------------------
select o.process_aduser_id, o.process_workstation_id, o.aduser_id, o.order_id, o.order_status_id, o.order_num, o.last_modified_date, au.aduser_domain, au.aduser_firstname, au.aduser_lastname  
from VG48999.[order] o
join VG48999.ad_user au on o.process_aduser_id = au.aduser_id
where order_num = @order_num

-----------------------------------------------
select agent_id, aduser_name, last_update_date, order_id, order_num, origin_desc, order_status_id, order_status_group_name
from VG48999.order_queue 
where order_id in 
(
  select order_id from VG48999.[order]
  where order_num = @order_num 
)
------------------------------------------------

--select * from VG48999.admin_key_activity
--UPDATE VG48999.admin_key_activity set hold_on=0 where aduser_id = 









--select aduser_id, aduser_domain from VG48999.ad_user where aduser_domain like '%artyom.shchokin%' or aduser_domain like '%user1%'


