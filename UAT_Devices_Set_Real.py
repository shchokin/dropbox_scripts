import subprocess
import pymssql
import os
from Data import UAT_DB

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
                "id = {:5d} \t name = {:44s} \t active = {:2d} \t type = {:2d}".format(result_[0], result_[3],
                                                                                       result_[5], result_[4]))
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
    device_id = int(input("\n Enter device id to change name > "))
    while device_id not in device_ids:
        print(f"\n\t\t\t id = {device_id} is not available")
        device_id = int(input("\n Enter device id to change name > "))

    answer = input("\n Change Name ? [y/n] > ")
    if answer in ["y", "Y"]:
        cursor.execute(f""" select device_type_id from VG{tenant}.device where device_id = {device_id}""")
        result = cursor.fetchone()
        device_type_id = result[0]
        cursor.execute(f""" select DEVICE_DESC from VG{tenant}.device where device_id = {device_id}""")
        result = cursor.fetchone()
        device_desc = result[0]
        if device_type_id == 2:
            if device_desc == 'Microsoft XPS Document Writer':
                cursor.execute(f""" update VG{tenant}.device set DEVICE_DESC='HP LaserJet Pro MFP M127-M128 PCLmS' 
                                    where device_id = {device_id} """)
            else:
                cursor.execute(f""" update VG{tenant}.device set DEVICE_DESC='Microsoft XPS Document Writer' 
                                    where device_id = {device_id}""")
            conn.commit()
            print("\n Name is  changed")
            device_ids = print_device_list(tenant)
        elif device_type_id == 3:
            if device_desc == 'Label Printer':
                cursor.execute(f""" update VG{tenant}.device set DEVICE_DESC='ZDesigner GX420t' 
                                    where device_id = {device_id} """)
            else:
                cursor.execute(f""" update VG{tenant}.device set DEVICE_DESC='Label Printer' 
                                    where device_id = {device_id}""")
            conn.commit()
            print("\n Name is  changed")
            device_ids = print_device_list(tenant)
        elif device_type_id == 4:
            if device_desc == 'Receipt Printer':
                cursor.execute(f""" update VG{tenant}.device set DEVICE_DESC='EPSON TM-H6000IV Receipt' 
                                    where device_id = {device_id} """)
            else:
                cursor.execute(f""" update VG{tenant}.device set DEVICE_DESC='Receipt Printer' 
                                    where device_id = {device_id}""")
            conn.commit()
            print("\n Name is  changed")
            device_ids = print_device_list(tenant)
        else:
            print('\nChanging name is not supported for this device type')

    else:
        print("\n Name is not changed")

    answer = input("\n Repeat? [y/n] ")
    while answer not in ['y', 'Y', 'n', 'N']:
        answer = input("\n Repeat? [y/n] ")
    if answer in ["n", "N"]:
        is_exit = 1


conn.close()

# print('\n -------------------------------Disconnecting VPN--------------------------------------------------------\n')
#
# subprocess.call(["rasdial", "VPN Connection UAT", "/disconnect"])

print('\n-----------------------------------------------------------------------------------------------------------\n')

input("Press Enter to continue...")
