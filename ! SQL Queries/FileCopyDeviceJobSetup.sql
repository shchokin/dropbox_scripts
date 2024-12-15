----------------device_service----------------

---1. Add device with Forti VPN (used in def update_device_job_for_ocr) and device_type_id = 10 and link to device service 

--insert into  VG48999.DEVICE values ('volo-dc\artyom.shchokin', '10.11.252.23', 'File Copy', 10, 1, NULL, 1, 2)

select * from VG48999.DEVICE where device_host_name like '%artyom.shchokin%'

SELECT DEVICE_ID
FROM VANGUARD_TX_QA.VG48999.DEVICE
WHERE DEVICE_HOST_ADDR = '10.11.252.23'
AND DEVICE_TYPE_ID = 10

--2. Link added device to workstation

--insert into VG48999.work_station_device values (312, 25,1,1)

select * from VG48999.work_station_device 
where work_station_id in 
(
   select work_station_id from VG48999.work_station
   where work_station_name = '10.11.252.23'
)

--2. Add FileCopy device job--------------

/*INSERT INTO [VG48999].[DEVICE_JOB]
           ([DEVICE_ID]
           , [CREATED_DATE]
           , [EXECUTION_DATE]
           , [RESULT]
           , [DEVICE_JOB_CONFIG]
           , [ERROR]
           , [DEVICE_JOB_STATUS]
           , [DEVICE_JOB_RECURRING_TYPE]
           , [FREQUENCY]
           , [NEXT_EXECUTION_DATE])
     VALUES
           (312
           , GETDATE()
           , NULL
           , NULL
           , '<FileCopyJobConfig>
   </FileCopyJobConfig>'
           , NULL
           , 1
           , 2
           , 300
           , NULL)
GO */

select * from VG48999.DEVICE_JOB WHERE CAST(DEVICE_JOB_CONFIG AS NVARCHAR(MAX)) LIKE '%FileCopyJobConfig%' order by device_job_id desc

select * from VG48999.DEVICE_JOB
              WHERE CAST(DEVICE_JOB_CONFIG AS NVARCHAR(MAX)) LIKE '%FileCopyJobConfig%'
                AND DEVICE_ID IN (
                    SELECT DEVICE_ID
                    FROM VANGUARD_TX_QA.VG48999.DEVICE
                    WHERE DEVICE_HOST_ADDR = '10.11.252.23'
                        AND DEVICE_TYPE_ID = 10)

--3. Upfate next execute date if needed

/* UPDATE VANGUARD_TX_QA.VG48999.DEVICE_JOB
            SET DEVICE_JOB_STATUS = 1, NEXT_EXECUTION_DATE = DATEADD(SECOND, 1, GETDATE())
            WHERE CAST(DEVICE_JOB_CONFIG AS NVARCHAR(MAX)) LIKE '%FileCopyJobConfig%'
                AND DEVICE_ID IN (
                    SELECT DEVICE_ID
                    FROM VANGUARD_TX_QA.VG48999.DEVICE
                    WHERE DEVICE_HOST_ADDR = '10.11.252.23'
                        AND DEVICE_TYPE_ID = 10) */


--If port /8601 issue						
select * from VG48999.DEVICE_service where device_service_name = 'ArtyomVolo'   --ARTYOM-PC
--update VG48999.DEVICE_service set work_station_name = 'ARTYOM-PC' where device_service_name = 'ArtyomVolo'