from golem import actions
from projects.test_project.tests.POM import CRS_Order_Queue
from projects.test_project.tests.POM import CRS_Add_New_Order
from projects.test_project.tests.POM import CRS_Order_Summary
from projects.test_project.tests.POM import CRS_Add_Payment
from projects.test_project.tests.POM import CRS_Order_Finalization
from projects.test_project.tests.POM import CRS_Void_Order_Summary
from projects.test_project.tests.POM import CRS_Void_Order_Payment
from projects.test_project.tests.Data import server_settings
from projects.test_project.tests.Data import oit_settings
from projects.test_project.tests.Data import crs_user_settings
from projects.test_project.tests.Data import database_settings
import subprocess
import pymssql

description = 'TC: Connection to DataBase'

tags = []
     

def setup(data):
    pass

def test(data):
     
    print('\n----------------------------------Connecting to VPN--------------------------------------------------------------\n') 

    #subprocess.call([r'C:\Users\artyom.shchokin\Documents\vpnon.bat'])
    #rasdial  "VanGuard-Halo2"
    subprocess.call(["rasdial", "VanGuard-Halo2"])

    print('\n----------------------------------Connecting to DB--------------------------------------------------------------\n') 

    conn = pymssql.connect(server=database_settings.host, user=database_settings.user, password=database_settings.password, database=database_settings.database) 
    cursor = conn.cursor()
    print("\nDB is connected successfully...\n")

    tenant="69999"    

  
#Available UserGroups 

    print("\n----------------------------------Available UserGroups on VG"+ tenant+" : ------------------------------------------------\n")
    cursor.execute("""
                      select AD_USERGROUP_ID, AD_USERGROUP_NAME from VG""" + tenant + """.ad_usergroup 
                      order by AD_USERGROUP_ID asc
                   """)
    result = cursor.fetchone() 
    while result:
        print("id = %d    name = %s" %(result[0], result[1]))
        result = cursor.fetchone()

#Current UserGroup

    print("\nYour current user group : ", end = '')  
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
                        where ADUSER_LASTNAME='"""+crs_user_settings.last_name+ """'
                      )  
                  """)  
    result = cursor.fetchone() 
    print("%d == %s == " %(result[0], result[1]))             


#Update UserGroup
    
    isCorrectUserGroupId=0
    while isCorrectUserGroupId==0:
        user_group = input("\nEnter user group id for update > ")                                                                                   #Add  validation!

        try:

            cursor.execute(""" 
                      UPDATE VG""" + tenant + """.AD_USER_AD_USERGROUP
                      SET AD_USERGROUP_ID = """ + user_group +  """
                      where ADUSER_ID in
                      ( select ADUSER_ID from VG""" + tenant + """.AD_USER  
                        where ADUSER_LASTNAME='"""+crs_user_settings.last_name+ """' 
                      )
                 """)
            isCorrectUserGroupId=1     
        except:    
            print("\n\t\t\t*** User Group Id is not correct. Try again. ***")
            #raise SystemExit


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
                        where ADUSER_LASTNAME='"""+crs_user_settings.last_name+ """'
                      )  
                  """)  
    result = cursor.fetchone() 
    print("\nYour updated user group : ", end = '') 
    print("%d == %s == " %(result[0], result[1]))  

    conn.commit()
    conn.close()

    print('\n----------------------------------Disconnecting VPN-----------------------------------------------------------\n')

    #subprocess.call([r'C:\Users\artyom.shchokin\Documents\vpnoff.bat'])
    #rasdial  "VanGuard-Halo2" /DISCONNECT
    subprocess.call(["rasdial", "VanGuard-Halo2","/disconnect"])

    print('\n-----------------------------------------------------------------------------------------------------------\n')

def teardown(data):
    pass
