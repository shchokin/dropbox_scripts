import subprocess
import pymssql
from Data import QA1_DB
import os


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

cursor.execute(f'''
                    DECLARE @USER_ID INT
                    DECLARE @ADDRESS_ID INT
                    DECLARE @ACC_ID INT
                    DECLARE @CONFIG_ID INT

                    select @USER_ID = ID from VANGUARD.[USER] where EMAIL_ID = 'artyomzp@gmail.com'

                    --ADDING THE ADDRESS
                    INSERT VG{tenant}.ADDRESS ( CODE , NAME , ADDRESS1 , ADDRESS2 , CITY , STATE_ID , ZIP , COUNTY , COUNTRY , COUNTRY_ID , STATE_PROVINCE )
                    VALUES  ( '' , -- CODE - varchar(15)
                              'Artem Shchokin' , -- NAME - varchar(128)
                              'Lemmon Ave' , -- ADDRESS1 - varchar(128)
                              '' , -- ADDRESS2 - varchar(128)
                              'Dallas' , -- CITY - varchar(128)
                              3 , -- STATE_ID - smallint
                              '75001' , -- ZIP - varchar(10)
                              '' , -- COUNTY - varchar(50)
                              '' , -- COUNTRY - varchar(50)
                              NULL , -- COUNTRY_ID - int
                              N''  -- STATE_PROVINCE - nvarchar(150)
                            )
                    SET @ADDRESS_ID = @@IDENTITY


                    --ADDING THE ACCOUNT
                    INSERT [VG{tenant}].[ACCOUNT] ([ACCT_CODE], [ACCT_ENABLED], [ACCT_NAME], [ACCT_BALANCE], [ACCT_ALLOW_CREDIT], [ACCT_MIN_BALANCE], [COMPANY_SUBSCRIPTION_PLAN_ID], [ACCT_ADDRESS_ID], [IS_erSUBMITTER], [erSUBMITTER_PASSWORD], [ALLOW_ORDERING], [PRIMARY_PHONE], [ACCT_FEEFUND_ID], [IS_SYSTEMACCOUNT], [ALLOW_ORDER_USER_TRANSFORMATION], [ALLOW_PUBLICSEARCH])
                    VALUES (N'ART777', 1, N'Artem Test Company', CAST(0.00 AS Decimal(9, 2)), 1, CAST(20000.00 AS Decimal(9, 2)), NULL, @ADDRESS_ID, 1, N'1111', 1, N'1594854541', 47, 0, 0, 0)
                    SET @ACC_ID = @@IDENTITY

                    --ADDING THE ACCOUNT - USER RELATIONSHIP
                    INSERT [VG{tenant}].[ACCOUNT_USER] ([ACCT_ID], [USER_ID], [AU_MAX_DAILY_AMT], [AU_ACTIVATE_DATE], [AU_SEARCH_ECOM_ENABLE], [AU_MAX_SEARCH_DAILY_AMT], [AU_ERECORD_ENABLE], [AU_RECORD_ENABLE], [AU_MAX_RECORD_DAILY_AMT], [FD_ID], [IS_ADMIN], [IS_ENABLED], [IS_NEW_PUBLIC_SEARCH], [IS_DISASSOCIATED])
                    VALUES (@ACC_ID, @USER_ID, CAST(0.00 AS Decimal(6, 2)), CAST(N'2017-04-25 17:06:41.567' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0)

                    --ADDING THE CONFIGURATION
                    INSERT INTO VG{tenant}.CONFIGURATION( CONFIG_XML, IS_ACTIVE, NAME )
                    VALUES  ( N'<?xml version="1.0" encoding="utf-8" ?>', 1, 'ER_Schema')
                    SET @CONFIG_ID = @@IDENTITY

                    --ADDING THE ER_SCHEMA
                    INSERT INTO VG{tenant}.ER_SCHEMA (ER_SCHEMA_NAME, CONFIG_ID, ACCOUNT_ID)
                    VALUES (N'Default', @CONFIG_ID, @ACC_ID)
                 ''')
conn.commit()
conn.close()
print("\n'ART777' CA is added")

print('\n ---------------------------------Disconnecting VPN--------------------------------------------------------\n')

subprocess.call(["rasdial", "VPN Connection QA1", "/disconnect"])

print('\n-----------------------------------------------------------------------------------------------------------\n')

input("Press Enter to continue...")
