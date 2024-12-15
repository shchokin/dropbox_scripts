select    
          dj.device_job_id,
          dj.device_id,
		  d.device_desc,
          dj.device_job_status, 
		  --djs.device_job_status,
          dj.CREATED_DATE,
          dj.DEVICE_JOB_CONFIG
from [VG48999].[DEVICE_JOB] dj
--join VANGUARD.device_job_status djs on djs.device_job_status_id = dj.device_job_status
join VG48999.device d on d.device_id = dj.device_id
where device_job_id in 
(
   select device_job_id
   from [VG48999].[DEVICE_JOB]
   where ORDER_ID in 
   (
      select order_id from [VG48999].[order]
      where [ORDER_NUM] ='20240716000027'     
   )
) 
order by DEVICE_JOB_ID desc

---------------------------------------------------------------------------------------------

select * from VG48999.audit_receipt
where ORDER_ID in 
(
	select order_id from [VG48999].[order]
	where [ORDER_NUM] ='20240716000005'     
)
order by ID desc



