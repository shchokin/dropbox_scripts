import subprocess
import pymssql
import os
from Data import UAT_DB, UAT_CRS
import xml.etree.ElementTree as Et
from os.path import join
from psutil import process_iter, AccessDenied
from os import getlogin
import logging
from termcolor import colored
from Libs.VPN import vpn_connect, vpn_disconnect
from Libs.DB import db_connect

print('\n ----------------------------------Connecting to VPN-------------------------------------------------------\n')

vpn_connect("UAT")

print('\n ----------------------------------Connecting to DB--------------------------------------------------------\n')

if db_connect("UAT") is not None:
    conn = db_connect("UAT")
    cursor = conn.cursor()
else:
    print(colored("\nDB is not connected", "red"))

print('\n ----------------------------------------------------------------------------------------------------------\n')

# Available tenants

print("\n\t\t\tAll available tenants : \n")

cursor.execute("select tenant_code, tenant_desc  from VANGUARD.tenant order by tenant_desc asc")
result = cursor.fetchone()

codes = []

while result:
    print("code = {:<10} desc = {:<10}".format(result[0], result[1]))
    codes.append(int(result[0]))
    result = cursor.fetchone()

while True:
    try:
        tenant = input("\nEnter tenant id  > ")
        if not tenant:
            tenant = "69999"
            print("\nTenant " + colored("69999", "green") + " is selected by default")
            break
        elif int(tenant) not in codes:
            print(colored("\n\tTenant Id is not available. Repeat entering...\n", "red"))
        else:
            print("\nSelected tenant is " + colored(tenant, "green"))
            break
    except ValueError or TypeError:
        print(colored("\n\tWrong format. Repeat entering...\n", "red"))

# -------------------------Check if FileCopy device is available----------------------------------------------------

query = f'''
         SELECT DEVICE_ID FROM VG{tenant}.DEVICE
         WHERE DEVICE_HOST_ADDR = '10.11.252.23'
         AND DEVICE_TYPE_ID = 10 
         '''
cursor.execute(query)
result = cursor.fetchone()

if not result:
    print(colored("\nFileCopy device is not available", "red"))
    # ------------------Check if device service is available-------------------
    query = f'''
             select device_service_id, work_station_name
             from VG{tenant}.DEVICE_service 
             where device_service_name = 'ArtyomVolo' 
             '''
    cursor.execute(query)
    result = cursor.fetchone()
    if not result:
        print(colored("\nDevice service is not available", "red"))
        # ---------------Add device service--------------------------------------------
        query = f'''
                  INSERT INTO VG{tenant}.[DEVICE_SERVICE] (DEVICE_SERVICE_NAME,WORK_STATION_NAME)
                  VALUES ('ArtyomVolo', 'ARTYOM-PC')
                 '''
        cursor.execute(query)
        conn.commit()
        query = f'''
                     select device_service_id, work_station_name
                     from VG{tenant}.DEVICE_service 
                     where device_service_name = 'ArtyomVolo' 
                     '''
        cursor.execute(query)
        result = cursor.fetchone()
        print("\nDevice service is added")
        device_service_id = result[0]
    else:
        print("\nDevice service is available")
        device_service_id = result[0]
        if result[1] == 'ARTYOM-PC':
            print("\nWork station name is correct in device service")
        else:
            print(colored("\nWork station name is incorrect in device service", "red"))
            # ----------------Update work station name in device service------------------------
            query = f'''
                     update VG{tenant}.DEVICE_service set work_station_name = 'ARTYOM-PC' 
                     where device_service_name = 'ArtyomVolo'
                    '''
            cursor.execute(query)
            conn.commit()
            print("\nWork station name in device service is updated")
    # -------Add File Copy device---------------------------------------------------------------
    query = f'''
             insert into  VG{tenant}.DEVICE 
             values ('volo-dc\\artyom.shchokin', '10.11.252.23', 'File Copy', 10, 1, NULL, 1, {device_service_id})  
             '''
    cursor.execute(query)
    conn.commit()
    print("\nFileCopy device is added")
    query = f'''
             SELECT DEVICE_ID FROM VG{tenant}.DEVICE
             WHERE DEVICE_HOST_ADDR = '10.11.252.23'
             AND DEVICE_TYPE_ID = 10 
             '''
    cursor.execute(query)
    result = cursor.fetchone()
    device_id = result[0]
else:
    device_id = result[0]
    print(colored(f"\nFileCopy device is available", "green"))

# -------------------------Check connection File Copy device to workstation---------------------------------------------

query = f'''
         select work_station_id from VG{tenant}.work_station
         where work_station_name = '10.11.252.23' 
         '''
cursor.execute(query)
result = cursor.fetchone()

if not result:
    print(colored("\nWorkstation is not available! Change IP!", "red"))
else:
    work_station_id = result[0]
    print(f"\nWorkstation is available")
    query = f'''
            select * from VG{tenant}.work_station_device 
            where work_station_id in 
            (
               select work_station_id from VG{tenant}.work_station
               where work_station_name = '10.11.252.23' and device_id = {device_id}
            )
            '''
    cursor.execute(query)
    result = cursor.fetchone()
    if not result:
        print(colored('\nFileCopy device is not connected to workstation', 'red'))
        query = f'''
                insert into VG{tenant}.work_station_device values ({device_id}, {work_station_id},1,1) 
                '''
        cursor.execute(query)
        conn.commit()
        print("\nFileCopy device is connected to workstation")
    else:
        print("\nFileCopy device is connected to workstation")

    # -------------------------Check if FileCopy device_job is available------------------------------------------------

    query = f'''
             select * from VG{tenant}.DEVICE_JOB
              WHERE CAST(DEVICE_JOB_CONFIG AS NVARCHAR(MAX)) LIKE '%FileCopyJobConfig%'
                AND DEVICE_ID IN (
                    SELECT DEVICE_ID
                    FROM VG{tenant}.DEVICE
                    WHERE DEVICE_HOST_ADDR = '10.11.252.23'
                        AND DEVICE_TYPE_ID = 10)
             '''
    cursor.execute(query)
    result = cursor.fetchone()
    if not result:
        print(colored('\nFileCopy device job is not available', 'red'))
        # -------------------Add FileCopy device job--------------------------------
        query = f'''
                 INSERT INTO [VG{tenant}].[DEVICE_JOB]
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
                   ({device_id}
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
             '''
        cursor.execute(query)
        conn.commit()
        print("\nFileCopy device job is added")
    else:
        print(colored('\nFileCopy device job is available', 'green'))



















