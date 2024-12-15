import subprocess
import pymssql
from Data import database_settings, crs_user_settings

print('\n ----------------------------------Connecting to VPN-------------------------------------------------------\n')

subprocess.call(["rasdial", "VanGuard-Halo2"])

print('\n ----------------------------------Connecting to DB--------------------------------------------------------\n')

conn = pymssql.connect(server=database_settings.host, user=database_settings.user,
                       password=database_settings.password, database=database_settings.database)
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

    tenant = input("\nEnter tenant id for update location & user group > ")  # Add  validation!

    # Available Locations

    try:
        cursor.execute("""
                  select location_id, location_name from VG""" + tenant + """.location 
                  order by location_id asc
               """)

        result = cursor.fetchone()
        isCorrectTenantId = 1

    except:
        print("\n\t\t\t*** Tenant Id is not correct. Try again. ***")

print("\n ----------------------------------Available Locations on VG" + tenant+" : --------------------------------\n")
while result:
    print("id = %d    name = %s" % (result[0], result[1]))
    result = cursor.fetchone()

# Current Location

print("\nYour current location : ", end='')

'''
cursor.execute("""
                  select location_id from VG""" + tenant +""".LOCATION_WORK_STATION 
                  where WORK_STATION_ID in 
                  ( select WORK_STATION_ID from VG""" + tenant + """.WORK_STATION 
                    where WORK_STATION_ADDRESS='"""+crs_user_settings.ip +"""'
                  )
              """)   
result = cursor.fetchone() 
print("%d" %result) 
'''

cursor.execute(""" 
                   select lw.location_id,
                          l.location_name
                   from VG""" + tenant + """.LOCATION_WORK_STATION lw
                   join VG""" + tenant + """.location l
                   on lw.location_id =l.location_id
                   where WORK_STATION_ID in
                   (
                     select WORK_STATION_ID from VG""" + tenant + """.WORK_STATION
                     where WORK_STATION_ADDRESS='"""+crs_user_settings.ip + """'
                   )
               """)

result = cursor.fetchone()
print("%d == %s ==" % (result[0], result[1]))

# Update Location

isCorrectLocationId = 0

while isCorrectLocationId == 0:
    location = input("\nEnter location id for update > ")  # Add validation!

    try:

        cursor.execute("""
                  UPDATE VG""" + tenant + """.LOCATION_WORK_STATION
                  SET LOCATION_ID = """ + location + """
                  where WORK_STATION_ID in
                  ( select WORK_STATION_ID from VG""" + tenant + """.WORK_STATION 
                    where WORK_STATION_ADDRESS='"""+crs_user_settings.ip + """' 
                  )
                """)
        isCorrectLocationId = 1
    except:
        print("\n\t\t\t*** Location Id is not correct. Try again. ***")

'''
cursor.execute("""
                  select location_id from VG""" + tenant +""".LOCATION_WORK_STATION
                  where WORK_STATION_ID in
                  ( select WORK_STATION_ID from VG""" + tenant + """.WORK_STATION
                    where WORK_STATION_ADDRESS='"""+crs_user_settings.ip +"""' 
                   )
               """)  

result = cursor.fetchone() 
print("%d" %result) 
'''

cursor.execute(""" 
                   select lw.location_id,
                          l.location_name
                   from VG""" + tenant + """.LOCATION_WORK_STATION lw
                   join VG""" + tenant + """.location l
                   on lw.location_id =l.location_id
                   where WORK_STATION_ID in
                   (
                     select WORK_STATION_ID from VG""" + tenant + """.WORK_STATION
                     where WORK_STATION_ADDRESS='"""+crs_user_settings.ip + """'
                   )
               """)

result = cursor.fetchone()
print("\nYour updated location : ", end='')
print("%d == %s ==" % (result[0], result[1]))

# Available UserGroups

print("\n ----------------------------------Available UserGroups on VG" + tenant+" : -------------------------------\n")

cursor.execute("""
                  select AD_USERGROUP_ID, AD_USERGROUP_NAME from VG""" + tenant + """.ad_usergroup 
                  order by AD_USERGROUP_ID asc
               """)

result = cursor.fetchone()

while result:
    print("id = %d    name = %s" % (result[0], result[1]))
    result = cursor.fetchone()

# Current UserGroup

print("\nYour current user group : ", end='')

''' 
cursor.execute("""
                  select AD_USERGROUP_ID from VG""" + tenant + """.AD_USER_AD_USERGROUP 
                  where ADUSER_ID in
                  ( select ADUSER_ID from VG"""+ tenant + """.AD_USER 
                    where ADUSER_LASTNAME='"""+crs_user_settings.last_name+ """' 
                   )
               """) 
result = cursor.fetchone() 
print("%d" %result)  
'''

cursor.execute("""
                  select auau.AD_usergroup_id,
                         au.ad_usergroup_name
                  from VG""" + tenant + """.AD_USER_AD_USERGROUP auau
                  join VG""" + tenant + """.ad_usergroup au
                  on auau.ad_usergroup_id = au.ad_usergroup_id
                  where ADUSER_ID in
                  (
                    select ADUSER_ID from VG""" + tenant + """.AD_USER
                    where ADUSER_LASTNAME='"""+crs_user_settings.last_name + """'
                  )  
              """)

result = cursor.fetchone()
print("%d == %s == " % (result[0], result[1]))

# Update UserGroup
    
isCorrectUserGroupId = 0
while isCorrectUserGroupId == 0:

    user_group = input("\nEnter user group id for update > ")  # Add  validation!

    try:

        cursor.execute(""" 
                  UPDATE VG""" + tenant + """.AD_USER_AD_USERGROUP
                  SET AD_USERGROUP_ID = """ + user_group + """
                  where ADUSER_ID in
                  ( select ADUSER_ID from VG""" + tenant + """.AD_USER  
                    where ADUSER_LASTNAME='"""+crs_user_settings.last_name + """' 
                  )
             """)

        isCorrectUserGroupId = 1
    except:
        print("\n\t\t\t*** User Group Id is not correct. Try again. ***")

'''
cursor.execute("""
                  select AD_USERGROUP_ID from VG""" + tenant + """.AD_USER_AD_USERGROUP 
                  where ADUSER_ID in
                  ( select ADUSER_ID from VG"""+ tenant + """.AD_USER 
                    where ADUSER_LASTNAME='"""+crs_user_settings.last_name+ """' 
                  )
              """) 
result = cursor.fetchone() 
print("%d" %result) 
'''

cursor.execute("""
                  select auau.AD_usergroup_id,
                         au.ad_usergroup_name
                  from VG""" + tenant + """.AD_USER_AD_USERGROUP auau
                  join VG""" + tenant + """.ad_usergroup au
                  on auau.ad_usergroup_id = au.ad_usergroup_id
                  where ADUSER_ID in
                  (
                    select ADUSER_ID from VG""" + tenant + """.AD_USER
                    where ADUSER_LASTNAME='"""+crs_user_settings.last_name + """'
                  )  
              """)

result = cursor.fetchone()
print("\nYour updated user group : ", end='')
print("%d == %s == " % (result[0], result[1]))

conn.commit()
conn.close()

print('\n ---------------------------------Disconnecting VPN--------------------------------------------------------\n')

subprocess.call(["rasdial", "VanGuard-Halo2", "/disconnect"])

print('\n-----------------------------------------------------------------------------------------------------------\n')


