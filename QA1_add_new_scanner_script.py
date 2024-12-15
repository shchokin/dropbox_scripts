# ---------------------Add scanner script-------------------------------------------------------

import subprocess
import pymssql
from Data import QA1_DB, QA1_CRS

# ---------------------Connecting to VPN---------------------------------------------------------

print('\n' + '-'*20 + 'Connecting to VPN' + '-'*20 + '\n')

subprocess.call([r"D:\Dropbox\Kofile\dropbox_scripts\Bat\QA1_VPN_On.bat"])

# ---------------------Connecting to DB----------------------------------------------------------

print('\n' + '-'*20 + 'Connecting to DB' + '-'*20 + '\n')
conn = pymssql.connect(server=QA1_DB.host, user=QA1_DB.user,
                       password=QA1_DB.password, database=QA1_DB.database)
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

# ------------------------------------- AdUserId selection----------------------------------------------------------

cursor.execute("select ADUSER_ID from VG" + str(tenant_code) + ".AD_USER where ADUSER_LASTNAME = 'Shchokin' ")
result = cursor.fetchone()
ad_user_id = result[0]
print(f"\n\t ad_user_id = {ad_user_id}")

# -------------------------------------- WorkStationId selection-----------------------------------------------------

cursor.execute(f"select WORK_STATION_ID from VG" + str(tenant_code) +
               f".WORK_STATION where WORK_STATION_ADDRESS = '{QA1_CRS.ip}' "
               f"AND WORK_STATION_DESC != 'Guest account'")
result = cursor.fetchone()
try:

    workstation_id = result[0]
    print(f"\n\t workstation_id = {workstation_id}")

    # ---------------------------------------Add Scanner-------------------------------------------------------------

    cursor.execute("select scanner_id from VG" + str(tenant_code) + ".SCANNER_WORKSTATION where workstation_id = "
                   + str(workstation_id))
    result = cursor.fetchone()
    is_new = False
    # If scanner doesn't exit -> add new one

    if result is None:
        cursor.execute('''
                          DECLARE @workstationId INT = ''' + str(workstation_id) + '''
                          DECLARE @scannerId INT
                          INSERT INTO VG''' + str(tenant_code) + '''.SCANNER
                                  ( SCANNER_NAME ,
                                    SCANNER_STATUS ,
                                    CREATED_AT
                                  )
                          VALUES  ( 'XPCTWAIN TIFF/JPEG Scanner' , -- SCANNER_NAME - varchar(100)
                                    1, -- SCANNER_STATUS - int
                                    GETDATE()  -- CREATED_AT - datetime
                                  )
                          SET @scannerId = SCOPE_IDENTITY()
                          INSERT INTO VG''' + str(tenant_code) + ''' .SCANNER_WORKSTATION
                            ( WORKSTATION_ID ,
                              SCANNER_ID
                            )
                          VALUES  ( @workstationId , -- WORKSTATION_ID - smallint
                                    @scannerId  -- SCANNER_ID - int
                                  )
                          SELECT @scannerId
                       ''')
        conn.commit()
        cursor.execute("select scanner_id from VG" + str(tenant_code) + ".SCANNER_WORKSTATION where workstation_id = "
                       + str(workstation_id))
        result = cursor.fetchone()
        is_new = True
    # Select already added scanner

    scanner_id = result[0]
    if is_new:
        print(f"\n\t Added scanner_id = {scanner_id}")
    else:
        print(f"\n\t Existing scanner_id = {scanner_id}")
    input("\nPress Enter to continue...")

except Exception as msg:
    print(f"\n{msg}")
    print("\n Work Station is not available. Check/Change your workstation IP...")

# ---------------------Disconnecting VPN-------------------------------------------------------

print('\n' + '-'*20 + 'Disconnecting VPN' + '-'*20 + '\n')

subprocess.call(["rasdial", "VPN Connection QA1", "/disconnect"])

# ---------------------------------------------------------------------------------------------

