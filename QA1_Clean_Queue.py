import subprocess
import pymssql
import sys
from Data import QA1_DB

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

print('\n --------------------------------Clean Queue------------------------------------------------\n')

cursor.execute("""
                  update VG""" + tenant + """.ORDER_ITEM_STATUS set ORDER_ITEM_STATUS = 1 where ORDER_ITEM_STATUS in (10, 11, 12, 20, 21, 22, 30, 31, 32) 
               """)
cursor.execute("""
                  update VG""" + tenant + """.[order] set workflow_step_id = 5 where workflow_step_id in (1, 2, 3, 4) 
               """)
print("\nDone")

conn.commit()
conn.close()

print('\n ---------------------------------Disconnecting VPN--------------------------------------------------------\n')

subprocess.call(["rasdial", "VPN Connection QA1", "/disconnect"])

print('\n-----------------------------------------------------------------------------------------------------------\n')

input("Press Enter to continue...")
