declare @verification_task_id int
set @verification_task_id = 272
-------------------------------------
--update VG48085.VERIFICATION_QUEUE set VERIFICATION_TASK_PRIORITY = 1 where verification_task_id = @verification_task_id		
--update VG48085.VERIFICATION_QUEUE_SESSION  set RECORDED_DATE = '2022-02-16 00:00:00.000' where verification_task_id = @verification_task_id  


select top 5* from VG48085.VERIFICATION_QUEUE_SESSION 
order by RECORDED_DATE asc

select * from VG48085.VERIFICATION_QUEUE_SESSION 
where verification_task_id = @verification_task_id


select 
      order_num, 
      verification_task_id,
      verification_task_priority
from VG48085.VERIFICATION_QUEUE
where verification_task_id = @verification_task_id	

 