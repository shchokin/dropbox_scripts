import subprocess
import pymssql
import os
from Data import UAT_DB
import xml.etree.ElementTree as et
from os.path import join
from distutils.dir_util import copy_tree

os.system('cls')


def print_device_list(tenant_):
    print('\n ------------------------------------------Devices-----------------------------------------------------\n')

    cursor.execute(f" select * from VG{tenant_}.device where device_host_name = 'VOLO-DC\\artyom.shchokin' ")
    result_ = cursor.fetchone()
    if not result_:
        cursor.execute(f" select * from VG{tenant_}.device where device_host_name = 'Artyom' ")
        result_ = cursor.fetchone()

    device_ids_ = []

    if result_ is not None:
        while result_:
            print(
                "id = {:5d} \t name = {:44s} \t active = {:2d} \t type = {:2d} \t service = {:2d}".format(result_[0],
                                                                     result_[3], result_[5], result_[4], result_[8]))
            device_ids_.append(int(result_[0]))
            result_ = cursor.fetchone()
    return device_ids_


print('\n ----------------------------------Connecting to VPN-------------------------------------------------------\n')

subprocess.call([r"D:\Dropbox\Kofile\dropbox_scripts\Bat\UAT_VPN_On.bat"])

print('\n ----------------------------------Connecting to DB--------------------------------------------------------\n')

conn = pymssql.connect(server=UAT_DB.host, user=UAT_DB.user, password=UAT_DB.password, database=UAT_DB.database)
cursor = conn.cursor()

# Available tenants

print("\n\t\t\tAll available tenants : \n")

cursor.execute("select tenant_code, tenant_desc  from VANGUARD.tenant order by tenant_desc asc")
result = cursor.fetchone()

codes = []

while result:
    print(f"code = {result[0]}    desc = {result[1]}")
    codes.append(result[0])
    result = cursor.fetchone()

tenant = input("\nEnter tenant id  > ")

while tenant not in codes:
    print("\n\t\t\t*** Tenant Id is not available. Repeat entering. ***")
    tenant = input("\nEnter tenant id  > ")

device_ids = print_device_list(tenant)

is_exit = 0
while not is_exit:
    device_id = int(input("\nEnter device id to connect to device service > "))
    while device_id not in device_ids:
        print(f"\n\t\t\t id = {device_id} is not available")
        device_id = int(input("\nEnter device id to connect to device service > "))

    answer = input("\nConnect to Device Service ? [y/n] > ")

    device_service_path = 'D:\\Dropbox\\Kofile\\dropbox_scripts\\Data\\uat_device_service'

    if answer in ["y", "Y"]:

        device_service_name = 'ArtyomVolo'
        cursor.execute(f""" select device_service_id from VG{tenant}.device_service 
                            where device_service_name = '""" + device_service_name + """' """)
        result = cursor.fetchone()
        if not result:
            device_service_name = 'Artyom'
            cursor.execute(f""" select device_service_id from VG{tenant}.device_service 
                                        where device_service_name = '""" + device_service_name + """' """)
            result = cursor.fetchone()
            if not result:
                device_service_name = 'ArtyomVolo'
                cursor.execute(f""" INSERT INTO [VG{tenant}].[DEVICE_SERVICE] (DEVICE_SERVICE_NAME,WORK_STATION_NAME)
                                    VALUES ('""" + device_service_name + """' , NULL) """)
                conn.commit()
                print("\n \'ArtyomVolo\' or \'Artyom\' device service is not detected.. ")
                print("\n New \'ArtyomVolo\' device service  is added")
                cursor.execute(f""" select device_service_id from VG{tenant}.device_service 
                                            where device_service_name = '""" + device_service_name + """' """)
                result = cursor.fetchone()
        device_service_id = result[0]
        # print(device_service_id)
        # -----------------------------------------------------------------------------------------------------
        cursor.execute(f""" select WORK_STATION_NAME from VG{tenant}.device_service 
                                    where device_service_name = '""" + device_service_name + """' """)
        result = cursor.fetchone()
        work_station_name = result[0]
        # work_station_name should be NULL when run script from different workstations!
        if work_station_name is not None:
            cursor.execute(f"""update VG{tenant}.DEVICE_SERVICE set work_station_name = NULL 
                               where device_service_name = '""" + device_service_name + """' """)
            conn.commit()
        # ------------------------------------------------------------------------------------------------------
        cursor.execute(f""" select device_service_id from VG{tenant}.DEVICE where device_id = {device_id} """)
        result = cursor.fetchone()
        my_device_service_id = result[0]
        # print(my_device_service_id)

        if my_device_service_id != device_service_id:
            # print("\n should be updated")
            cursor.execute(f""" update VG{tenant}.DEVICE set device_service_id = {device_service_id} 
                                where device_id = {device_id} """)
            conn.commit()
            # result = cursor.fetchone()
            print("\nDevice Service Id is updated")
            device_ids = print_device_list(tenant)
        else:
            print("\nDevice Service Id is actual")

        # Update Device Service Settings...

        tree = et.parse(join(device_service_path, "AppSettings.config"))
        root = tree.getroot()
        for child in root:
            if child.get('key') == 'TenantCode':
                if child.get('value') != tenant:
                    child.set('value', tenant)
                    print("\nTenant Code is updated in AppSettings.config")
                else:
                    print("\nTenant Code is actual in AppSettings.config")
            if child.get('key') == 'DeviceService.Name':
                if child.get('value') != device_service_name:
                    child.set('value', device_service_name)
                    print("\nDevice Service Name is updated in AppSettings.config")
                else:
                    print("\nDevice Service Name is actual in AppSettings.config")

        tree.write(join(device_service_path, "AppSettings.config"), encoding='utf-8', xml_declaration=True)

    else:
        print("\n Skipped...")

    answer = input("\n Repeat? [y/n] ")
    while answer not in ['y', 'Y', 'n', 'N']:
        answer = input("\n Repeat? [y/n] ")
    if answer in ["n", "N"]:
        is_exit = 1


conn.close()

print('\n ---------------------------------Disconnecting VPN--------------------------------------------------------\n')

subprocess.call(["rasdial", "VPN Connection UAT", "/disconnect"])

print('\n --------------------------------Run Device Service--------------------------------------------------------\n')

path = f'D:\\Dropbox\\Kofile\\dropbox_scripts\\Data\\uat_device_service\\App_Data\\Tenants\\{tenant}'
is_dir = os.path.isdir(path)
# print(is_dir)
if not is_dir:
    from_directory = "D:\\Dropbox\\Kofile\\dropbox_scripts\\Data\\uat_device_service\\App_Data\\Tenants\\69999"
    to_directory = f"D:\\Dropbox\\Kofile\\dropbox_scripts\\Data\\uat_device_service\\App_Data\\Tenants\\{tenant}"
    copy_tree(from_directory, to_directory)

subprocess.Popen("Kofile.Vanguard.Device.Service.WindowsHost.exe", cwd=device_service_path, shell=True)

print('\n-----------------------------------------------------------------------------------------------------------\n')

input("Press Enter to continue...")
