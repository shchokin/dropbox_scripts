from Data import UAT_DB, UAT_CRS
import subprocess
import pymssql
import sys

print('\n----------------------------------Connecting to VPN--------------------------------------------------------\n')

subprocess.call([r"D:\Dropbox\Kofile\dropbox_scripts\Bat\UAT_VPN_On.bat"])

print('\n----------------------------------Connecting to DB---------------------------------------------------------\n')

conn = pymssql.connect(server=UAT_DB.host, user=UAT_DB.user, password=UAT_DB.password,
                       database=UAT_DB.database)
cursor = conn.cursor()
print("\nDB is connected successfully...\n")

tenant = "48000"

  
# Available UserGroups

print("\n----------------------------------Available UserGroups on VG" + tenant+" : --------------------------------\n")
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
                    where ADUSER_LASTNAME='"""+UAT_CRS.last_name+ """' 
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
                    where ADUSER_LASTNAME='"""+UAT_CRS.last_name + """'
                  )  
              """)

result = cursor.fetchone()
print("%d == %s == " % (result[0], result[1]))

# Update UserGroup
    
isCorrectUserGroupId = 0
while isCorrectUserGroupId == 0:
    user_group = input("\nEnter user group id for update > ")                        # Add validation!

    try:

        cursor.execute(""" 
                  UPDATE VG""" + tenant + """.AD_USER_AD_USERGROUP
                  SET AD_USERGROUP_ID = """ + user_group + """
                  where ADUSER_ID in
                  ( select ADUSER_ID from VG""" + tenant + """.AD_USER  
                    where ADUSER_LASTNAME='"""+UAT_CRS.last_name + """' 
                  )
             """)
        isCorrectUserGroupId = 1
    except Exception as x:
        sys.stderr.write(str(x))
        print("\n\t\t\t*** User Group Id is not correct. Try again. ***")

'''
cursor.execute("""
                  select AD_USERGROUP_ID from VG""" + tenant + """.AD_USER_AD_USERGROUP 
                  where ADUSER_ID in
                  ( select ADUSER_ID from VG"""+ tenant + """.AD_USER 
                    where ADUSER_LASTNAME='"""+UAT_CRS.last_name+ """' 
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
                    where ADUSER_LASTNAME='"""+UAT_CRS.last_name + """'
                  )  
              """)

result = cursor.fetchone()
print("\nYour updated user group : ", end='')
print("%d == %s == " % (result[0], result[1]))

conn.commit()
conn.close()

# print('\n--------------------------------Disconnecting VPN--------------------------------------------------------\n')
#
# subprocess.call(["rasdial", "VPN Connection UAT", "/disconnect"])

print('\n-----------------------------------------------------------------------------------------------------------\n')
