import os
import logging
from termcolor import colored
from Libs.VPN import vpn_connect, vpn_disconnect
from Libs.DB import db_connect
import time
from termcolor import colored

os.system('cls')

# -----------------------------------------

envs = ['QA1', 'UAT']
tenants = [69999, 51013]

while True:
    try:
        env = input("Enter environment [QA1/UAT] > ")
        if not env:
            env = 'QA1'
            print("\nEnvironment " + colored("QA1", "green") + " is selected by default")
            break
        elif env.upper() not in envs:
            print(colored("\n\tEnvironment is not available. Repeat entering...\n", "red"))
        else:
            print("\nSelected environment is " + colored(env, "green"))
            break
    except ValueError or TypeError:
        print(colored("\n\tRepeat entering...\n", "red"))

print("\nAvailable tenants:\n")

for t in tenants:
    print(t)

if env.upper() == "UAT":
    tenant = '51013'
    print("\nTenant " + colored("51013", "green") + " is selected by default")
else:
    while True:
        try:
            tenant = input("\nEnter tenant id  > ")
            if not tenant:
                tenant = '69999'
                print("\nTenant " + colored("69999", "green") + " is selected by default")
                break
            elif int(tenant) not in tenants:
                print(colored("\n\tTenant Id is not available. Repeat entering...\n", "red"))
            else:
                print("\nSelected tenant is " + colored(tenant, "green"))
                break
        except ValueError or TypeError:
            print(colored("\n\tWrong format. Repeat entering...\n", "red"))

print('\n ----------------------------------Connecting to VPN-------------------------------------------------------\n')

vpn_connect(env)

print('\n ----------------------------------Connecting to DB--------------------------------------------------------\n')

if db_connect(env) is not None:
    conn = db_connect(env)
    cursor = conn.cursor()
    print(colored("\nDB is connected successfully...", "green"))

    schedule_job_codes = ['AutoRedactionExport', 'AutoRedactionListenner', 'AutoRedactionImport']

    # Get tenant_id
    query = f'''select tenant_id from VANGUARD.tenant where tenant_code = {tenant}'''
    cursor.execute(query)
    tenant_id = cursor.fetchone()
    # print(tenant_id[0])

    print('\n ----------------------------------Auto-Redaction-jobs-UPDATE-----------------------------\n')

    for i in range(0, 3):
        query_update = f'''UPDATE VANGUARD.SCHEDULE_JOB
                         SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, 
                         STATUS= 2 WHERE TENANT_ID = {tenant_id[0]} AND SCHEDULE_JOB_CODE = '{schedule_job_codes[i]}' '''
        query_select = f'''SELECT STATUS from VANGUARD.SCHEDULE_JOB
                           WHERE TENANT_ID = {tenant_id[0]} AND SCHEDULE_JOB_CODE = '{schedule_job_codes[i]}' '''
        cursor.execute(query_update)
        conn.commit()
        while True:
            time.sleep(5)
            cursor.execute(query_select)
            status = cursor.fetchone()
            if status[0] == 2:
                break
        print(f"\n{schedule_job_codes[i]}... is updated")

    conn.close()

else:
    print(colored("\nDB is not connected", "red"))


print('\n ---------------------------------Disconnecting VPN--------------------------------------------------------\n')

# vpn_disconnect(env)

logging.info('---------------------------------------------------------------------------------------------------\n')

input("\nPress " + colored("Enter", "green") + " to finish script...")
