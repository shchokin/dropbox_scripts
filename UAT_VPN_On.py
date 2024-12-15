import subprocess
import re
import time
import os
from termcolor import colored

vpn_name_uat = "VPN Connection UAT"
vpn_name_qa1 = "VPN Connection QA1"

process = subprocess.Popen(["rasdial"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = process.communicate()
output = stdout.decode()

os.system('cls')

print("\n------------Check VPN connection on QA1-------------------\n")

if vpn_name_qa1 in output:
    print(f"The VPN '{vpn_name_qa1}' is already " + colored("connected.", "green"))
    subprocess.call(["rasdial", "VPN Connection QA1", "/disconnect"])
    print(f"The VPN '{vpn_name_qa1}' is " + colored("disconnected.", "red"))

else:
    print(f"The VPN '{vpn_name_qa1}' is " + colored("disconnected.", "red"))

print("\n------------Check VPN connection on UAT-------------------\n")

if vpn_name_uat in output:
    print(f"The VPN '{vpn_name_uat}' is already " + colored("connected.", "green"))
else:
    print(f"The VPN '{vpn_name_uat}' is " + colored("disconnected.", "red"))
    print("\n------------Connecting VPN on UAT-------------------------\n")

    subprocess.call(["rasdial", "VPN Connection UAT"])
    result = subprocess.run(['route', 'print'], stdout=subprocess.PIPE).stdout.decode('utf-8')
    for line in result.split("\n"):
        if "VPN Connection UAT" in line:
            print(colored(line, "green"))
            interface_id = re.split(r"\.", line)
            interface_id = interface_id[0].strip()
            # print(interface_id)
            break
    subprocess.call(["route", "add", "10.0.0.7", "MASK", "255.255.255.255", "0.0.0.0", "IF", "{}".format(interface_id)])
    print("\n---------------------------------------------------------\n")

time.sleep(3)
