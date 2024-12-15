# -----------------------Add New User Script----------------------------------------------------
# Notes:
# The followings settings should be used in sql script file because here is validation part with these values:
# DeviceServiceId = 1
# LocationId = 2
# UserGroupId = 2

import re
import subprocess
import pymssql
import database_settings

# ---------------------Connecting to VPN---------------------------------------------------------

print('\n' + '-'*20 + 'Connecting to VPN' + '-'*20 + '\n')
subprocess.call(["rasdial", "VanGuard-Halo2"])

# ---------------------Connecting to DB----------------------------------------------------------

print('\n' + '-'*20 + 'Connecting to DB' + '-'*20 + '\n')
conn = pymssql.connect(server=database_settings.host, user=database_settings.user,
                       password=database_settings.password, database=database_settings.database)
cursor = conn.cursor()

# ---------------------All available tenants-----------------------------------------------------

print('\n' + '-'*20 + 'All available tenants' + '-'*20 + '\n')

cursor.execute('''
                      select tenant_code, tenant_desc 
                      from VANGUARD.tenant
                      order by tenant_desc asc 

                   ''')
result = cursor.fetchone()
while result:
    print("code = %s    desc = %s" % (result[0], result[1]))
    result = cursor.fetchone()

# -----------------------Verify tenant code-----------------------------------------------------

while True:

    try:
        tenant_code = input("\nEnter tenant code > ")
        cursor.execute("""select * from VG""" + tenant_code + """.location""")
        result = cursor.fetchone()
        break
    except Exception as msg:
        print(f"\n{msg}")
        print("\n\t\t\t*** Tenant Id is not correct. Try again. ***")

# ---------------------Create User Script----------------------------------------------------------

print('\n' + '-'*20 + 'Create User Script' + '-'*20 + '\n')

path = "Create_User_1.sql"
with open(path) as file:
    content = file.readlines()

query = ""
for line in content:
    if not line.startswith("--") and not line.startswith("print") and len(line.strip()) != 0:
        line = re.sub(r"vg\d+", "vg"+str(tenant_code), line)
        query += line
#print(query)

# -------------------Run Script---------------------------------------------------------------------

# test tenat codes: 48391, 48273, 48325, 48031
try:
    cursor.execute('''select * from VG'''+str(tenant_code)+'''.DEVICE_SERVICE where device_service_id = 1''')
    result = cursor.fetchone()
    # Verify that Device Service with Id = 1 is available
    if result is not None:
        print("\t...Device Service with Id = 1 is detected")
        cursor.execute('''select * from VG'''+str(tenant_code)+'''.location where LOCATION_ID = 2''')
        result = cursor.fetchone()
        # Verify that Location with Id = 2 is available
        if result is not None:
            print("\t...Location with Id = 2 is detected")
            cursor.execute('''select * from VG'''+str(tenant_code)+'''.ad_usergroup where AD_USERGROUP_ID = 2''')
            result = cursor.fetchone()
            # Verify that User Group with Id = 2 is available
            if result is not None:
                print("\t...User Group with Id = 2 is detected")
                # Execute Create User Script
                cursor.execute(query)
                conn.commit()
                #result = cursor.fetchone() # try with new tenant without this line : here is exception as query has no result rows
                print("\n\t! User is created !")
                input("\nPress Enter to continue...")

            else:
                print("\n\t\t\t*** User Group with ID = 2 is not available ***")
        else:
            print("\n\t\t\t*** Location with ID = 2 is not available ***")
    else:
        print("\n\t\t\t*** Device Service with ID = 1 is not available ***")

except Exception as msg:
    print(msg)

# ---------------------Disconnecting VPN-------------------------------------------------------

print(print('\n' + '-'*20 + 'Disconnecting VPN' + '-'*20 + '\n'))
subprocess.call(["rasdial", "VanGuard-Halo2", "/disconnect"])

# ---------------------Connecting to DB----------------------------------------------------------
