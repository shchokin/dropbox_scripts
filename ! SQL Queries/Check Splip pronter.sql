---------------------------Slip Printer--------------------------

--1. Add device and connect to device service

--INSERT INTO  [VG69999].[DEVICE] ([DEVICE_HOST_NAME], [DEVICE_HOST_ADDR], [DEVICE_DESC], [DEVICE_TYPE_ID], [DEVICE_ACTIVE], [DEVICE_STATUS_ID],  [DEVICE_SERVICE_ID])
--VALUES ('VOLO-DC\artyom.shchokin', '10.0.2.247', 'TM-H6000IV Slip', 9, 1, 1, 3)

--2. Connect created device to your workstation-----

--INSERT INTO [VG69999].[WORK_STATION_DEVICE] ( [DEVICE_ID], [WORK_STATION_ID], [WSD_ENABLED], [IS_DEFAULT])
--VALUES (1612, 68 , 1, 1)


SELECT * FROM VG69999.device where device_host_name like '%artyom.shchokin%' and device_type_id = 9

SELECT * FROM VG69999.templates where template_content like '%slip%'   --template_id = 38

SELECT * FROM VG69999.ORDER_ITEM_TYPE_TEMPLATE WHERE template_id = 38

--G:\wwwroot\QA\Content\App_Data\Tenants\69999\PrintTemplates\SlipPrinterConfig.xml
--Finalize order with 'Check' payment method->click on the 'Endorse Check(s)' link

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
      where [ORDER_NUM] ='20240906000003'     
   )
) 
order by DEVICE_JOB_ID desc
