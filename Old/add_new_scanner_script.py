# ---------------------Add scanner script-------------------------------------------------------

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

# ------------------------------------- AdUserId selection----------------------------------------------------------

cursor.execute("select ADUSER_ID from VG" + str(tenant_code) + ".AD_USER where ADUSER_LASTNAME = 'Shchokin' ")
result = cursor.fetchone()
ad_user_id = result[0]
print(f"\n\t ad_user_id = {ad_user_id}")

# -------------------------------------- WorkStationId selection-----------------------------------------------------

cursor.execute("select WORK_STATION_ID from VG" + str(tenant_code) + ".WORK_STATION where WORK_STATION_ADDRESS = '10.0.2.247' ")
result = cursor.fetchone()
workstation_id = result[0]
print(f"\n\t workstation_id = {workstation_id}")

# ---------------------------------------Add Scanner-------------------------------------------------------------

cursor.execute("select scanner_id from VG" + str(tenant_code) + ".SCANNER_WORKSTATION where workstation_id = " + str(workstation_id))
result = cursor.fetchone()

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
    cursor.execute("select scanner_id from VG" + str(tenant_code) + ".SCANNER_WORKSTATION where workstation_id = " + str(workstation_id))
    result = cursor.fetchone()

# Select already added scanner

scanner_id = result[0]
print(f"\n\t scanner_id = {scanner_id}")
input("\nPress Enter to continue...")

# ---------------------Disconnecting VPN-------------------------------------------------------

print(print('\n' + '-'*20 + 'Disconnecting VPN' + '-'*20 + '\n'))
subprocess.call(["rasdial", "VanGuard-Halo2", "/disconnect"])

# ---------------------Connecting to DB----------------------------------------------------------

