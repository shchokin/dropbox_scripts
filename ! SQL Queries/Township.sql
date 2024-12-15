select * from VG48999.TOWNSHIP


select top 250 parcel_id, legal_desc, is_city_parcel from VG51013.appraisal

select top 250 * from VG51013.appraisal where is_city_parcel = 1

SELECT parcel_id
FROM VG51013.appraisal
where is_city_parcel = 1
ORDER BY parcel_id
OFFSET 2 ROWS FETCH NEXT 100 ROWS ONLY

SELECT parcel_id 
FROM VG51013.appraisal 
WHERE parcel_id > (
SELECT parcel_id 
FROM VG51013.appraisal 
WHERE parcel_id = '01003010'  
)


select * 
from VG48999.DM_EXTENDED de
left join VANGUARD.BEHAVIOUR_FLAG bf on bf.bf_id = de.document_status
where DM_ID in 
(
	select DM_ID from VG48999.ORDER_ITEM
	where order_id in 
	(
		select order_id from VG48999.[ORDER]
		where order_num='20241106000014'
	) 
)
order by dm_id asc

---------------------------------------

declare @order_number varchar(60)
set @order_number = '20241107000001'

select payment_date from VG51013.order_payment 
where order_id in 
(
  select order_id from VG51013.[ORDER]
  where order_num=@order_number
) 


select finalize_date from VG51013.order_event
where order_id in 
(
  select order_id from VG51013.[ORDER]
  where order_num=@order_number
) 
-------------------------------------------

declare @order_number_2 varchar(60)
set @order_number_2 = '20241107000002'

select payment_date from VG39035.order_payment 
where order_id in 
(
  select order_id from VG39035.[ORDER]
  where order_num=@order_number_2
) 


select finalize_date from VG39035.order_event
where order_id in 
(
  select order_id from VG39035.[ORDER]
  where order_num=@order_number_2
) 
-----------------------------------------------





















SELECT
	oe.ORDER_ID
	, p.PAYMENT_DATE
	, oe.FINALIZE_DATE
	, DATEDIFF(MINUTE, p.PAYMENT_DATE, oe.FINALIZE_DATE) AS DIFF_IN_MINUTES
FROM
	VG51013.ORDER_EVENT AS oe
	OUTER APPLY (
		SELECT
			TOP(1)
			op.PAYMENT_DATE
		FROM
			VG51013.ORDER_PAYMENT AS op
		WHERE
			op.ORDER_ID = oe.ORDER_ID
		ORDER BY
			op.ORDER_PAYMENT_ID
	) AS p
WHERE
	oe.FINALIZE_DATE >= '2024-10-20'
	AND oe.FINALIZE_DATE < '2024-11-08'









