import subprocess
import pymssql
from Data import QA1_DB
import xml.etree.ElementTree as et
from os.path import join
import re
import os
import shutil
from Libs.VPN import vpn_connect, vpn_disconnect
from Libs.DB import db_connect
from termcolor import colored

os.system('cls')

print('\n ----------------------------------Connecting to VPN------------------------------------------------------\n')

# subprocess.call([r"D:\Dropbox\Kofile\dropbox_scripts\Bat\QA1_VPN_On.bat"])
vpn_connect("QA1")

print('\n ----------------------------------Connecting to DB--------------------------------------------------------\n')

# conn = pymssql.connect(server=QA1_DB.host, user=QA1_DB.user, password=QA1_DB.password, database=QA1_DB.database)
# cursor = conn.cursor()

if db_connect("QA1") is not None:
    conn = db_connect("QA1")
    cursor = conn.cursor()
    print(colored("\nDB is connected successfully...", "green"))
else:
    print(colored("\nDB is not connected", "red"))

print('\n ----------------------------------------------------------------------------------------------------------\n')

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

while tenant not in codes and tenant != "":
    print(colored("\n\t\t\t*** Tenant Id is not available. Repeat entering. ***", "red"))
    tenant = input("\nEnter tenant id  > ")
if tenant == "":
    tenant = "69999"
    print("\nTenant " + colored(f"{tenant}", "green") + " is selected by default")
else:
    print("\nTenant " + colored(f"{tenant}", "green") + " is selected")

erproxy_path = "D:\\Dropbox\\Kofile\\dropbox_scripts\\Data\\erproxy"
tree = et.parse(join(erproxy_path, "erProxyTester.exe.config"))
root = tree.getroot()
tags = root.findall('appSettings/add')
for tag in tags:
    if tag.get('key') == 'ProxyURL':
        config_tenant = (re.findall(r'/(\d+)', tag.get('value')))
        print(f"\nOld Url = {tag.get('value')}")
        tag.set('value', f'http://erproxy.qa-1.kofile.systems/{tenant}/')
        print(f"New Url = {tag.get('value')}")
        tree.write(join(erproxy_path, "erProxyTester.exe.config"), encoding='utf-8', xml_declaration=True)

cursor.execute(f" select * from VG{tenant}.account where ACCT_CODE = 'ART777' ")
result = cursor.fetchone()
if result:
    executor_path = f"{erproxy_path}\\Payloads\\ART777-1111\\"
    print("\n'ART777' Company is available")
    if os.path.exists(f"{erproxy_path}\\Payloads\\SIMPLIFILE-SIMPLIFILE"):
        os.rename(f"{erproxy_path}\\Payloads\\SIMPLIFILE-SIMPLIFILE", f"{erproxy_path}\\Payloads\\ART777-1111\\")
else:
    print("\n'ART777' Company is not available")
    cursor.execute(f" select * from VG{tenant}.account where ACCT_CODE = 'SIMPLIFILE' ")
    result = cursor.fetchone()
    if result:
        executor_path = f"{erproxy_path}\\Payloads\\SIMPLIFILE-SIMPLIFILE\\"
        print("\n'SIMPLIFILE' Company is available")
        if os.path.exists(f"{erproxy_path}\\Payloads\\ART777-1111"):
            os.rename(f"{erproxy_path}\\Payloads\\ART777-1111", f"{erproxy_path}\\Payloads\\SIMPLIFILE-SIMPLIFILE\\")
    else:
        print("\n'SIMPLIFILE' Company is not available")

er_type = input("\nEnter type of erProxy: 'Simple' or 'DS' > ").lower().strip()
if er_type not in ("simple", "ds") or er_type == "":
    print("\nEntered type of erProxy is incorrect. 'Simple' type will be by default")
    er_type = "simple"

if er_type == "simple":
    print("\nOrigin " + colored("erProxy ", "green") + "is selected")
else:
    print("\nOrigin " + colored("erProxyDS ", "green") + "is selected")

with open(f'{executor_path}\\generate_packages.sh', 'r+') as f:
    content = f.read()
    # print(content)
    config_num_of_orders = re.findall(r'..(\d+)', content)
    is_correct = False
    is_new_num_of_orders = False
    while not is_correct:
        try:
            print("\n" + "-" * 80)
            num_of_orders = input("\nEnter 'Number Of Orders' > ")
            if not num_of_orders:
                num_of_orders = 1
                print("\nNumber Of Orders is " + colored("1", "green") + " by default")
            if num_of_orders != config_num_of_orders[1]:
                print(f"\nOld Number Of Orders = {config_num_of_orders[1]}")
                print(f"New Number Of Orders = {num_of_orders}")
                is_new_num_of_orders = True
            else:
                print("\n'Number Of Orders' is actual")
            is_correct = True
            int(num_of_orders)
        except ValueError or TypeError as msg:
            print(msg)
            print("\n\t" + colored("Wrong format. Repeat entering...", "red"))
            is_correct = False

    config_num_of_oits = re.findall(r'../(\d+)', content)
    config_er_type = re.findall(r'type_(\w+)', content)
    # print(config_er_type[0])

    is_correct = False
    is_new_num_of_oits = False
    while not is_correct:
        try:
            print("\n" + "-" * 80)
            num_of_oits = input("\nEnter 'Number Of OITs' in range (1-3) > ")
            if not num_of_oits:
                num_of_oits = 1
                print("\nNumber Of OITs is " + colored("1", "green") + " by default")
            if int(num_of_oits) < 1 or int(num_of_oits) > 3:
                print("\n" + colored(" Number Of OITs should be in range (1-3). Repeat entering...", "red"))
            else:
                if num_of_oits != config_num_of_oits[0] or ((num_of_oits == config_num_of_oits[0]) and er_type != config_er_type[0]):
                    print(f"\nOld Number Of OITs = {config_num_of_oits[0]}")
                    print(f"New Number Of OITs = {num_of_oits}")
                    print(f"\nOld Type of erProxy = {config_er_type[0]}")
                    print(f"New Type of erProxy = {er_type}")
                    is_new_num_of_oits = True
                else:
                    print("\n'Number Of OITs' and Type of erProxy are actual")
                is_correct = True
        except ValueError or TypeError as msg:
            print(msg)
            print("\n\t" + colored("Wrong format. Repeat entering...", "red"))

    is_correct = False
    while not is_correct:
        try:
            print("\n" + "-" * 80)
            num_of_pages = input("\nEnter 'Number Of Pages' in range (1-10) > ")
            if not num_of_pages:
                num_of_pages = 1
                print("\n'Number Of Pages is " + colored("1", "green") + " by default'")
            if int(num_of_pages) < 1 or int(num_of_pages) > 10:
                print("\n" + colored(" Number Of Pages should be in range (1-10). Repeat entering...", "red"))
            else:
                if int(num_of_pages) == 1 or int(num_of_pages) == 10:
                    shutil.copy2(f"{erproxy_path}\\images\\{num_of_pages}.tiff", f"{erproxy_path}\\embfile.tif")
                else:
                    shutil.copy2(f"{erproxy_path}\\images\\1-{num_of_pages}.tiff", f"{erproxy_path}\\embfile.tif")
                is_correct = True
        except ValueError or TypeError as msg:
            print(msg)
            print("\n\t" + colored("Wrong format. Repeat entering...", "red"))

    if is_new_num_of_orders and is_new_num_of_oits:
        if er_type == "simple":
            content = f'''d=$(date "+%m_%d_%Y_%I_%M %p"); for i in {{1..{num_of_orders}}};
                          do cp ../../type_simple/{num_of_oits}oit.xml "ARTYOM_$d-$i.xml"; 
                          done;cd ../.. ; start erProxyTester.exe ; cd -'''
        else:
            content = f'''d=$(date "+%m_%d_%Y_%I_%M %p"); for i in {{1..{num_of_orders}}}; 
                          do cp ../../type_ds/{num_of_oits}oit.xml "ARTYOM_$d-$i.xml"; 
                          done;cd ../.. ; start erProxyTester.exe ; cd -'''
        print("\n'Generate Packages' file  is updated with new Number Of Orders and OITs")
    elif is_new_num_of_orders and not is_new_num_of_oits:
        if er_type == "simple":
            content = f'''d=$(date "+%m_%d_%Y_%I_%M %p"); for i in {{1..{num_of_orders}}}; 
                          do cp ../../type_simple/{config_num_of_oits[0]}oit.xml "ARTYOM_$d-$i.xml"; 
                          done;cd ../.. ; start erProxyTester.exe ; cd -'''
        else:
            content = f'''d=$(date "+%m_%d_%Y_%I_%M %p"); for i in {{1..{num_of_orders}}}; 
                          do cp ../../type_ds/{config_num_of_oits[0]}oit.xml "ARTYOM_$d-$i.xml"; 
                          done;cd ../.. ; start erProxyTester.exe ; cd -'''
        print("\n'Generate Packages' file  is updated with new Number Of Orders")
    elif not is_new_num_of_orders and is_new_num_of_oits:
        if er_type == "simple":
            content = f'''d=$(date "+%m_%d_%Y_%I_%M %p"); for i in {{1..{config_num_of_orders[1]}}}; 
                          do cp ../../type_simple/{num_of_oits}oit.xml "ARTYOM_$d-$i.xml"; 
                          done;cd ../.. ; start erProxyTester.exe ; cd -'''
        else:
            content = f'''d=$(date "+%m_%d_%Y_%I_%M %p"); for i in {{1..{config_num_of_orders[1]}}}; 
                          do cp ../../type_ds/{num_of_oits}oit.xml "ARTYOM_$d-$i.xml"; 
                          done;cd ../.. ; start erProxyTester.exe ; cd -'''
        print("\n'Generate Packages' file  is updated with new Number Of OITs")
    else:
        print("\n No Changes in 'Generate Packages' file ")

    # print(content)
    f.seek(0)
    f.write(content)
    f.close()

# delete previous created packages
packages = os.listdir(executor_path)
for item in packages:
    if item.endswith(".xml"):
        os.remove(os.path.join(executor_path, item))

# generate new packages and run submitter
subprocess.Popen("start.bat", cwd=executor_path, shell=True)


'''
Account Code/Password check -> 1 func: check er_schema, pass, checkbox front office (is flag) 
Update Account Balance !!!
Specify Doc Type
Logs
Check status 4/8 - retrieving
Delete Retrieved folder
'''

conn.close()

print('\n ---------------------------------Disconnecting VPN--------------------------------------------------------\n')

# subprocess.call(["rasdial", "VPN Connection QA1", "/disconnect"])
# vpn_disconnect("QA1")

print('\n-----------------------------------------------------------------------------------------------------------\n')

# input("Press Enter to continue...")
input("\nPress " + colored("Enter", "green") + " to finish script...")
