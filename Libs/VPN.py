import subprocess
from termcolor import colored


def vpn_connect(env_name):
    if str(env_name).lower().strip() == "qa1":
        # vpn_status(env_name)
        # input("Press")
        subprocess.call([r"D:\Dropbox\Kofile\dropbox_scripts\Bat\QA1_VPN_On.bat"])
        # vpn_status(env_name)
        # input("Press")
    elif str(env_name).lower().strip() == "uat":
        subprocess.call([r"D:\Dropbox\Kofile\dropbox_scripts\Bat\UAT_VPN_On.bat"])
    else:
        print(colored("\nWrong environment name is specified for VPN", "red"))


def vpn_disconnect(env_name):
    if str(env_name).lower().strip() == "qa1":
        subprocess.call(["rasdial", "VPN Connection QA1", "/disconnect"])
    elif str(env_name).lower().strip() == "uat":
        subprocess.call(["rasdial", "VPN Connection UAT", "/disconnect"])
    else:
        print(colored("\nWrong environment name is specified for VPN", "red"))

'''
def vpn_status(env_name):
    if str(env_name).lower().strip() == "qa1":
        host = "10.0.0.9"
    elif str(env_name).lower().strip() == "uat":
        host = "10.0.0.7"
    else:
        print(colored("\nWrong environment name is specified for VPN", "red"))

    ping = subprocess.Popen(["ping.exe", "-n", "1", "-w", "1", host], stdout=subprocess.PIPE).communicate()[0]
    if ('unreachable' in str(ping)) or ('timed' in str(ping)) or ('failure' in str(ping)):
        ping_chk = 0
    else:
        ping_chk = 1

    if ping_chk == 1:
        print("VPN Connected")
    else:
        print("VPN Not Connected")
'''
