---a.-- Assigned and 'In Process' (any origin) regardless Origin Filter
select order_num, origin_desc, first_name, order_date, aduser_name, order_status_group_name from VG69999.order_queue 
where ADUSER_NAME = 'ARTYOM SHCHOKIN' AND ORDER_STATUS_GROUP_NAME = 'In Process' order by order_date asc

---b.-- Assigned and 'Pending' (any origin) regardless Origin Filter
select order_num, origin_desc, first_name, order_date, aduser_name, order_status_group_name from VG69999.order_queue 
where ADUSER_NAME = 'ARTYOM SHCHOKIN' AND ORDER_STATUS_GROUP_NAME = 'Pending' order by order_date asc

--c. Origin filtered eRproxy/erProxyDS--------------------------
select order_num, origin_desc, first_name, order_date, aduser_name, order_status_group_name from VG69999.order_queue where origin_desc in ('erProxy', 'erProxyDS') 
AND ADUSER_NAME = '' AND ORDER_STATUS_GROUP_NAME = 'Pending' AND origin_desc = 'erProxyDS' AND first_name = 'SIMPLIFILE' order by order_date asc

--d. NON-Origin filtered eRproxy/erProxyDS--------------------------

select order_num, origin_desc, first_name, order_date, aduser_name, order_status_group_name from VG69999.order_queue where origin_desc in ('erProxy', 'erProxyDS') 
AND ADUSER_NAME = '' AND ORDER_STATUS_GROUP_NAME = 'Pending' --AND (origin_desc <> 'erProxyDS' AND first_name <> 'SIMPLIFILE') order by order_date asc














 