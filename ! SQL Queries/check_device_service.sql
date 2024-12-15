-- 1. Check that device is added:    
--    1.1. Check taht DEVICE_TYPE_ID = 4 (Receipt Printer)  
--    1.2. Check that DEVICE_DESC  contains name of physical printer (EPSON TM-H6000IV Receipt) Should be the same name in Control Panel -> Printers

select * from VG48453.device 
where device_host_name like '%artyom.shchokin%' and device_type_id in
(
   select device_type_id from VANGUARD.device_type
   where device_type_name = 'Receipt Printer'
)

--2. Check that device is linked to your device service, save DEVICE_SERVICE_NAME----------------------------------------------------------------------

select * from VG48453.device_service 
where device_service_id in
(
   select device_service_id from VG48453.device 
   where device_host_name like '%artyom.shchokin%' and device_type_id = 4
)

--3. Check that device linked to your workstation------------------------------------------------------------------------------------------------------

select * from VG48453.work_station_device 
where work_station_id in 
(
   select work_station_id from VG48453.work_station
   where work_station_name = '10.11.252.23'
)
AND device_id in
(
   select device_id from VG48453.device 
   where device_host_name like '%artyom.shchokin%' and device_type_id = 4
)


--4. Open devive service folder -> AppSettings.config file -> Set DeviceService.Name = DEVICE_SERVICE_NAME (from step 2 )

--5. Check that needed tenant is added to App_Data\Tenants -> <XXXXX>

--6. Run service, execute Kofile.Vanguard.Device.Service.WindowsHost.exe (As Administartor)

--7. Finalize OIT that configured to print on Epson Printer (EpsonRecieptPrinterConfig_.txt is genereated in Azure wfcontent-XXXXX-printfolder) 
