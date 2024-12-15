select * from VG48999.device where device_host_name like '%artyom%' and device_type_id =1

--Active Balance Session
select * from VG48999.bm_balancesession
where device_id in 
(
  select device_id from VG48999.device 
  where device_host_name like '%artyom%' and device_type_id =1
)
order by BALANCESESSION_ID desc

--Device per Workstation
select * from VG48999.WORK_STATION_DEVICE
where device_id in 
(
  select device_id from VG48999.device 
  where device_host_name like '%artyom%' and device_type_id =1
)

--Device per User
select * from VG48999.AD_USER_DEVICE
where device_id in 
(
  select device_id from VG48999.device 
  where device_host_name like '%artyom%' and device_type_id =1
)

--If Balance Drawer (device_type_id = 1) is connected to User and Workstation -> will be per User (if config type in app server is also per User)
                                                                             --> will be per Workstation (if config type in app server is also per Workstation)
																			                                        