--void todays report

select * from VG48999.ORDER_PAYMENT where ORDER_ID = 62560

select * from VG48999.ORDER_PAYMENT where ORDER_ID = 62566



select 
       aduser_id,
	   aduser_domain,
	   aduser_emailid
from VG48999.ad_user where aduser_id in (22, 24)

------------------------------------------------------------

select * from VG48999.ORDER_PAYMENT where ORDER_ID = 62569



select * from VG48999.ORDER_PAYMENT_AUDIT where ORDER_ID = 62560


-------void prior  report

select * from VG48999.ORDER_PAYMENT where ORDER_ID = 62481

select 
       bs.*,
	   au.aduser_domain,
	   au.aduser_emailid
from VG48999.BM_BALANCESESSION bs
join VG48999.ad_user au on au.aduser_id = bs.aduser_id
where balancesession_id = 4357









select  * from VG48999.bm_balance --where balancesession_id = 4385
select top 10 * from VG48999.bm_balancedetail
select  * from VG48999.BM_BALANCEPOST where balancesession_id in (4385)




----------------------------



select top 5 * from VG48999.BM_BALANCESESSION where aduser_id = 22 order by balancesession_id desc

select * from VG48999.ORDER_PAYMENT where 






--Change Finalize Date to Yesterdays date to emulate yesterdays order


SELECT  * FROM VG48999.ORDER_EVENT where order_id = 62569

--update VG48999.ORDER_EVENT set finalize_date = '2024-08-15 04:08:27.600' where order_id = 62569



SELECT oe.FINALIZE_DATE,
op.BALANCESESSION_ID,
op.ORDER_PAYMENT_ID,
op.PAYMENT_STATUS_ID,
op.AMOUNT,
bb.BALANCESESSION_ID,
ADUSER_FIRSTNAME + ' ' + ADUSER_LASTNAME,
d.DEVICE_ID,
d.DEVICE_HOST_NAME,
d.DEVICE_DESC
 FROM VG48025.[ORDER] o
 JOIN VG48025.ORDER_EVENT oe ON oe.ORDER_ID = o.ORDER_ID
 JOIN VG48025.ORDER_PAYMENT op ON op.ORDER_ID = o.ORDER_ID
JOIN VG48025.BM_BALANCESESSION bb ON bb.BALANCESESSION_ID = op.BALANCESESSION_ID
JOIN VG48085.AD_USER au ON au.ADUSER_ID = bb.ADUSER_ID
JOIN VG48085.DEVICE d ON d.DEVICE_ID = bb.DEVICE_ID
 WHERE ORDER_NUM = '20240813000001'



 ----------------------------------------------------


