import subprocess
import pymssql
import sys
from Data import QA1_DB
import logging

IP_home = '10.11.252.23'
IP_office = '10.0.2.247'

logging.basicConfig(filename=r'D:\Dropbox\logs\qa1_change_ip.log', level=logging.INFO, filemode="a",
                    format='%(asctime)s - %(levelname)s - %(message)s')


print('\n ----------------------------------Connecting to VPN-------------------------------------------------------\n')

subprocess.call([r"D:\Dropbox\Kofile\dropbox_scripts\Bat\QA1_VPN_On.bat"])

print('\n ----------------------------------Connecting to DB--------------------------------------------------------\n')

conn = pymssql.connect(server=QA1_DB.host, user=QA1_DB.user,
                       password=QA1_DB.password, database=QA1_DB.database)
cursor = conn.cursor()

# Available tenants

print("\n\t\t\tAll available tenants : \n")

cursor.execute('''
                  select tenant_code, tenant_desc 
                  from VANGUARD.tenant
                  order by tenant_desc asc 

               ''')

result = cursor.fetchone()

while result:
    print("code = %s    desc = %s" % (result[0], result[1]))
    result = cursor.fetchone()

isCorrectTenantId = 0
while isCorrectTenantId == 0:

    tenant = input("\nEnter tenant id  > ")

    # Available Locations

    try:
        cursor.execute("""
                  select location_id, location_name from VG""" + tenant + """.location 
                  order by location_id asc
               """)

        result = cursor.fetchone()
        isCorrectTenantId = 1

    except Exception as x:
        sys.stderr.write(str(x))
        print("\n\t\t\t*** Tenant Id is not correct. Try again. ***")

print('\n --------------------------------Select Current WorkStation------------------------------------------------\n')

cursor.execute("""
                  select * from VG""" + tenant + """.work_station where WORK_STATION_ADDRESS = '""" + IP_office + """'
                  AND WORK_STATION_DESC != 'Guest account'
               """)
result = cursor.fetchone()

if result is not None:
    print("Office workstation :    id = %d    ip = %s" % (result[0], result[1]))
    answer = input("\nChange to Home workstation ? [y / n] > ")
    if answer in ['y', 'Y']:
        cursor.execute("""
                          update VG""" + tenant + """.work_station set work_station_name = '""" + IP_home + """' where WORK_STATION_ADDRESS = '""" + IP_office + """'         
                               """)
        cursor.execute("""
                          update VG""" + tenant + """.work_station set work_station_address = '""" + IP_home + """' where WORK_STATION_ADDRESS = '""" + IP_office + """' 
                                       """)
        cursor.execute("""
                          update VG""" + tenant + """.INTRANET_DEVICE set device_host_name = '""" + IP_home + """' where device_host_addr = '""" + IP_office + """'       
                       """)
        cursor.execute("""
                                  update VG""" + tenant + """.INTRANET_DEVICE set device_host_addr = '""" + IP_home + """' where device_host_addr = '""" + IP_office + """'       
                       """)
        cursor.execute("""
                              select * from VG""" + tenant + """.work_station where WORK_STATION_ADDRESS = '""" + IP_home + """'
                              AND WORK_STATION_DESC != 'Guest account'
                       """)
        result = cursor.fetchone()
        print("\nHome workstation :    id = %d    ip = %s" % (result[0], result[1]))
        logging.info(f"{tenant} - Set Home IP -> [10.11.252.23]")
    else:
        print("\nNo Changes")
else:
    cursor.execute("""
                      select * from VG""" + tenant + """.work_station where WORK_STATION_ADDRESS = '""" + IP_home + """'
                      AND WORK_STATION_DESC != 'Guest account'
                   """)
    result = cursor.fetchone()
    print("Home workstation :    id = %d    ip = %s" % (result[0], result[1]))
    answer = input("\nChange to Office workstation ? [y / n] > ")
    if answer in ['y', 'Y']:
        cursor.execute("""
                          update VG""" + tenant + """.work_station set work_station_name = '""" + IP_office + """' where WORK_STATION_ADDRESS = '""" + IP_home + """'         
                      """)
        cursor.execute("""
                          update VG""" + tenant + """.work_station set work_station_address = '""" + IP_office + """' where WORK_STATION_ADDRESS = '""" + IP_home + """' 
                       """)
        cursor.execute("""
                          update VG""" + tenant + """.INTRANET_DEVICE set device_host_name = '""" + IP_office + """' where device_host_addr = '""" + IP_home + """'       
                       """)
        cursor.execute("""
                          update VG""" + tenant + """.INTRANET_DEVICE set device_host_addr = '""" + IP_office + """' where device_host_addr = '""" + IP_home + """'       
                       """)

        cursor.execute("""
                              select * from VG""" + tenant + """.work_station where WORK_STATION_ADDRESS = '""" + IP_office + """'
                              AND WORK_STATION_DESC != 'Guest account'
                       """)
        result = cursor.fetchone()
        print("\nOffice workstation :    id = %d    ip = %s" % (result[0], result[1]))
        logging.info(f"{tenant} - Set Office IP -> [10.0.2.247] ")
    else:
        print("\nNo Changes")

conn.commit()
conn.close()

print('\n ---------------------------------Disconnecting VPN--------------------------------------------------------\n')

subprocess.call(["rasdial", "VPN Connection QA1", "/disconnect"])

print('\n-----------------------------------------------------------------------------------------------------------\n')

input("Press Enter to continue...")
