select * from VG48453.ad_user                                                          --VG48453.AD_USER_AD_USERGROUP

select * from VG48453.work_station where work_station_address = '10.11.252.23'         --VG48453.LOCATION_WORK_STATION

select * from VG48453.device where device_host_name like '%artyom.shchokin%'

select * from VG48453.work_station_device where work_station_id in (22,23)

select * from VG48453.scanner

select * from VG48453.SCANNER_WORKSTATION

---------------------------------------------
select * from VG48453.location
select * from VG48453.ad_usergroup
---------------------------------------------Search usergroup via LastName
select auau.AD_usergroup_id,
         au.ad_usergroup_name
       from VG48453.AD_USER_AD_USERGROUP auau
          join VG48453.ad_usergroup au
          on auau.ad_usergroup_id = au.ad_usergroup_id
where ADUSER_ID in(
select ADUSER_ID from VG48453.AD_USER
where ADUSER_LASTNAME='Shchokin'
)
---------------------------------------------Search location via work station
select lw.location_id,
        l.location_name
       from VG48453.LOCATION_WORK_STATION lw
       join VG48453.location l
       on lw.location_id =l.location_id
where WORK_STATION_ID in(
select WORK_STATION_ID from VG48453.WORK_STATION
where WORK_STATION_ADDRESS='10.11.252.23'
)
---------------------------------------------Update usergroup via LastName
UPDATE VG48453.AD_USER_AD_USERGROUP SET AD_USERGROUP_ID = 2
where ADUSER_ID in(
select ADUSER_ID from VG48453.AD_USER
where ADUSER_LASTNAME='Shchokin'
)
---------------------------------------------Update location via Workstation
UPDATE VG48453.LOCATION_WORK_STATION SET LOCATION_ID = 2
where WORK_STATION_ID in(
select WORK_STATION_ID from VG48453.WORK_STATION
where WORK_STATION_ADDRESS='10.0.2.247'
)
---------------------------------------------Search usergroup via LastName
select * from VG48453.AD_USER_AD_USERGROUP
where ADUSER_ID in(
select ADUSER_ID from VG48453.AD_USER
where ADUSER_LASTNAME='Shchokin'
)
---------------------------------------------Search location via work station
select * from VG48453.LOCATION_WORK_STATION
where WORK_STATION_ID in(
select WORK_STATION_ID from VG48453.WORK_STATION
where WORK_STATION_ADDRESS='10.0.2.247'
)














