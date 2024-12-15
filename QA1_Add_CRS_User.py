import subprocess
import pymssql
import os
from Data import QA1_DB

os.system('cls')

print('\n ----------------------------------Connecting to VPN------------------------------------------------------\n')

subprocess.call([r"D:\Dropbox\Kofile\dropbox_scripts\Bat\QA1_VPN_On.bat"])

print('\n ----------------------------------Connecting to DB--------------------------------------------------------\n')

conn = pymssql.connect(server=QA1_DB.host, user=QA1_DB.user, password=QA1_DB.password, database=QA1_DB.database)
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

addresses = [" 'Artem Shchokin', '16 Wall Street', 'SCHENECTADY', 33, '12345-6789', '5555555555'",
             " 'Artem Shchokin', '612 West Broad St', 'NEWTON FALLS', 36, '44444-4444', '6666666666' ",
             " 'Artem Shchokin', '125 Snowman Ln', 'NORTH POLE', 51, '88888-8888', '7777777777' "]

emails = ['artyomzp@gmail.com', 'artyomzp@yahoo.com', 'artyom.shchokin@volo.global']
i = 0
for email in emails:
    cursor.execute(f''' select * from VANGUARD.[TENANT_USER] 
                        where TENANT_ID in
                        (
                          select TENANT_ID from VANGUARD.[TENANT]
                          where TENANT_CODE = '{tenant}'
                        )
                        and USER_ID  in
                        (
                           select ID from VANGUARD.[USER]
                           where EMAIL_ID = '{email}'
                        )
                  ''')
    result = cursor.fetchone()
    if not result:
        print(f"\nEmail User '{email}' is added")
        cursor.execute(f'''
                            declare @tenant_id int
                            declare @user_id int

                            select @tenant_id = TENANT_ID from VANGUARD.[TENANT]  where TENANT_CODE = '{tenant}'
                            select @user_id = ID from VANGUARD.[USER] where EMAIL_ID = '{email}'
                            
                            insert into VANGUARD.[TENANT_USER] values (@tenant_id, @user_id)
                       ''')
        conn.commit()
    else:
        print(f"\nEmail User '{email}' is already exists")
        # print(f"{result[0]}\t{result[1]}\t{result[2]}")

    cursor.execute(f'''
                      select * from VG{tenant}.USER_ADDRESS 
                      where USER_ID  in
                      (
                        select ID from VANGUARD.[USER]
                        where EMAIL_ID = '{email}'
                      )
                   ''')
    result = cursor.fetchone()
    if result:
        cursor.execute(f'''
                           delete from VG{tenant}.USER_ADDRESS 
                           where USER_ID  in
                           (
                             select ID from VANGUARD.[USER]
                             where EMAIL_ID = '{email}'
                           )
                       ''')
        conn.commit()
        print("\nAddress is deleted")
    else:
        pass

    cursor.execute(f'''
                            DECLARE @ADDRESS_ID INT
                            DECLARE @USER_ID int
                            
                            SELECT @USER_ID = ID from VANGUARD.[USER] where EMAIL_ID = '{email}'
                            
                            INSERT INTO [VG{tenant}].[ADDRESS]
                            ([NAME], [ADDRESS1], [CITY], [STATE_ID], [ZIP], [PHONE_NUMBER])
                            VALUES ({addresses[i]})
                            SET @ADDRESS_ID = @@IDENTITY
                            
                            INSERT INTO [VG{tenant}].USER_ADDRESS values (@USER_ID, @ADDRESS_ID)
                               
                       ''')
    conn.commit()
    i += 1
    print("\nAddress is added")

conn.close()

print('\n ---------------------------------Disconnecting VPN--------------------------------------------------------\n')

subprocess.call(["rasdial", "VPN Connection QA1", "/disconnect"])

print('\n-----------------------------------------------------------------------------------------------------------\n')

input("Press Enter to continue...")
