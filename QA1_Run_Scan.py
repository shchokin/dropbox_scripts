import subprocess
import pymssql
import os
from Data import QA1_DB, QA1_CRS
import xml.etree.ElementTree as Et
from os.path import join
from psutil import process_iter, AccessDenied
from os import getlogin
import logging
from termcolor import colored
from Libs.VPN import vpn_connect, vpn_disconnect
from Libs.DB import db_connect

os.system('cls')

logging.basicConfig(filename=r'D:\Dropbox\Kofile\dropbox_scripts\logs\run_scan.log', level=logging.INFO, filemode="a",
                    format='%(asctime)s - %(levelname)s - %(message)s')


def get_scanner_process():
    for process in process_iter():
        if process.name() == "Kofile.Vanguard.ScanService.exe":
            try:
                username = process.username()
            except AccessDenied:
                continue
            if getlogin() in username:
                return process


scanner_process = get_scanner_process()

if scanner_process:
    scanner_process.terminate()
    scanner_process.wait()
    print('Previous opened scanner is closed...')

print('\n ----------------------------------Connecting to VPN-------------------------------------------------------\n')

vpn_connect("QA1")

print('\n ----------------------------------Connecting to DB--------------------------------------------------------\n')

if db_connect("QA1") is not None:
    conn = db_connect("QA1")
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


print('\n --------------------------------Select Current WorkStation------------------------------------------------\n')

query = f'''
select SCANNER_ID from VG{tenant}.SCANNER_WORKSTATION where WORKSTATION_ID in
(
  select WORK_STATION_ID from VG{tenant}.WORK_STATION where WORK_STATION_ADDRESS = '{QA1_CRS.ip}' 
  AND WORK_STATION_DESC != 'Guest account'
)
'''

cursor.execute(query)
result = cursor.fetchone()

if not result:

    print(colored("\n ScannerId is not available. Check/Change your workstation IP...", "red"))

else:

    scanner_id = result[0]
    scanner_path = 'D:\\Dropbox\\Kofile\\dropbox_scripts\\Data\\scanner'

    tree = Et.parse(join(scanner_path, "ScannerConfig.xml"))
    root = tree.getroot()

    for child in root.iter("ScannerId"):
        # print(f"\nOld ScannerId = {child.text}")
        logging.info(f"Old ScannerId = {child.text}")
        if child.text != str(scanner_id):
            child.text = str(scanner_id)
        # print(f"New ScannerId = {child.text}")
        logging.info(f"New ScannerId = {child.text}")
    tree.write(join(scanner_path, "ScannerConfig.xml"), encoding='utf-8', xml_declaration=True)

    second_tree = Et.parse(join(scanner_path, "ScannerServiceConfig.xml"))
    second_root = second_tree.getroot()

    for child in second_root.iter("BaseAddress"):
        new_text = f"http://crs.qa-1.kofile.systems/{tenant}/capturemodule/api"
        # print(f"\nOld Url = {child.text}")
        logging.info(f"Old Url = {child.text}")
        if child.text != new_text:
            child.text = new_text
        # print(f"New Url = {child.text}")
        logging.info(f"New Url = {child.text}")
    second_tree.write(join(scanner_path, "ScannerServiceConfig.xml"), encoding='utf-8', xml_declaration=True)

    while True:
        try:
            num_of_pages = input("\nEnter Number Of Pages ( 1 - 10 ) > ")
            if not num_of_pages:
                num_of_pages = 1
                print("\nNumber of Pages is " + colored("1", "green") + " by default")
                break
            elif int(num_of_pages) not in range(1, 11):
                print(colored("\n\tEntering value is  not in range. Repeat entering...", "red"))
            else:
                print("\nNumber of Pages is " + colored(num_of_pages, "green"))
                break
        except ValueError or TypeError:
            print(colored("\n\tWrong format. Repeat entering...", "red"))

    images_path = 'D:\\Dropbox\\Kofile\\dropbox_scripts\\Data\\scanner\\PredefinedImages'
    tree = Et.parse(join(images_path, "PredefinedImagesConfig.xml"))
    root = tree.getroot()
    for child in root.iter("string"):
        # print(f"\nOld Number Of Pages = {child.text}")
        logging.info(f"Old Number Of Pages = {child.text}")
        if child.text != str(num_of_pages):
            if int(num_of_pages) == 1 or int(num_of_pages) == 10:
                child.text = str(num_of_pages) + '.tiff'
            else:
                child.text = '1-' + str(num_of_pages) + '.tiff'
        # print(f"\nNew Number Of Pages = {child.text}")
        logging.info(f"New Number Of Pages = {child.text}")
    tree.write(join(images_path, "PredefinedImagesConfig.xml"), encoding='utf-8', xml_declaration=True)
    subprocess.Popen("Kofile.Vanguard.ScanService.exe", cwd=scanner_path, shell=True)

conn.close()

# print('\n -------------------------------Disconnecting VPN--------------------------------------------------------\n')

# vpn_disconnect("QA1")

logging.info('---------------------------------------------------------------------------------------------------\n')

# input("\nPress " + colored("Enter", "green") + " to finish script...")
