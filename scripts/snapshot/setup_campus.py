#!/usr/bin/env python3
import os
import sys
import subprocess
import getpass
from pathlib import Path

# --- Configuration Constants ---
SSID = "Campus Connecte"
CA_PATH = "/var/lib/iwd/campus_connecte_ca.pem"
CONFIG_PATH = f"/var/lib/iwd/{SSID}.8021x"
IWD_MAIN_CONF = "/etc/iwd/main.conf"

CA_CERT_CONTENT = """-----BEGIN CERTIFICATE-----
MIIEbTCCA1WgAwIBAgIUcDLDcp/FHNfj27x5floAlWjQXMowDQYJKoZIhvcNAQEL
BQAweTELMAkGA1UEBhMCTUExDjAMBgNVBAgMBVJhYmF0MQ4wDAYDVQQHDAVSYWJh
dDEZMBcGA1UECgwQQ2FtcHVzIENvbm5lY3RlczEvMC0GA1UEAwwmQ2FtcHVzIENv
bm5lY3RlcyBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwHhcNMjIwMTI1MDkzNjA1WhcN
MzIwMTIzMDkzNjA1WjB5MQswCQYDVQQGEwJNQTEOMAwGA1UECAwFUmFiYXQxDjAM
BgNVBAcMBVJhYmF0MRkwFwYDVQQKDBBDYW1wdXMgQ29ubmVjdGVzMS8wLQYDVQQD
DCZDYW1wdXMgQ29ubmVjdGVzIENlcnRpZmljYXRlIEF1dGhvcml0eTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAKcksWgxw64PTzKcXiJ5FEdOtwxfWgXX
yq7KV7MSKBOjjxb2zCrt/Q4KdVeI41THTYFww+b5negtTlmkZ+CeUq22aHEFgrUG
5T8s6PvNtL+87V1iN+zB8lTlr8XtCPvwV4KBpesKpvUp9h+M8ZN2/2ziNUMnNdVP
EiRxjbgoGULVJVPza6JQBCIhzrLN/Gl5fu7MzSwQnnjx3gIrr1PIGDWTWYtrtHHC
LhTO/BvHJ63C8yfTU4P8Lc/xw/NJ9dSl22TS73Y2WiXnSofTI0HjTcVW9FH7UEAS
WMEMK1q4Iux4Gb6tagr8uxBu2MfICgkuOyXPlaKbQQ35G5OsU6Mj6Q8CAwEAAaOB
7DCB6TAdBgNVHQ4EFgQUPiq0GZ7qUncAjbOci7YVw8l8ywQwgbYGA1UdIwSBrjCB
q4AUPiq0GZ7qUncAjbOci7YVw8l8ywShfaR7MHkxCzAJBgNVBAYTAk1BMQ4wDAYD
VQQIDAVSYWJhdDEOMAwGA1UEBwwFUmFiYXQxGTAXBgNVBAoMEENhbXB1cyBDb25u
ZWN0ZXMxLzAtBgNVBAMMJkNhbXB1cyBDb25uZWN0ZXMgQ2VydGlmaWNhdGUgQXV0
hG9yaXR5ghRwMsNyn8Uc1+PbvHl+WgCVaNBcyjAPBgNVHRMBAf8EBTADAQH/MA0G
CSqGSIb3DQEBCwUAA4IBAQBjHF738QmKyxIuTnCxV+/iJwH23TqXGRP6w7bh7PRC
UeU4jnvrOo1eG70/aNsHtROTnaY8BUIn52wO/apIdqzBXkuYeEgFA5mSTHZrT5qF
10y0LG1SrN25oCD1qvM0C3NaUtEFR+2Dp/SkvMmsznOJhXFd2o6UtT8z//Xo/zva
DhPnuPUzJYYLAwfNJ16mOgZnK5FTvmXgqClsKm5rmdOYTN8dfE/MGRoI+RwGh+gG
W5CBHIVqp+/rfUNTv5ALP+T57BUsxkPk9IVeGf0bKhKH85bmKz4OiKQINyMwI5Vg
1palzAskq4f+GGEWP1x5R8d6174/f6z8H3rfEEVIJnJR
-----END CERTIFICATE-----
"""


def run_cmd(cmd):
    return subprocess.run(cmd, shell=True, capture_output=True, text=True)


def main():
    if os.geteuid() != 0:
        print("Error: This script must be run as root (sudo).")
        sys.exit(1)

    print(f"--- Campus Connecte Installer (iwd/Arch) ---")

    # 1. Get User Data
    username = input("Enter your identifier (e.g., user@um5.ac.ma): ").strip()
    password = getpass.getpass("Enter your password: ").strip()

    if not username or not password:
        print("Error: Username and password cannot be empty.")
        sys.exit(1)

    # 2. Save CA Certificate
    print(f"[*] Saving CA certificate to {CA_PATH}...")
    with open(CA_PATH, "w") as f:
        f.write(CA_CERT_CONTENT.strip())
    os.chmod(CA_PATH, 0o644)

    # 3. Configure iwd for DHCP
    print(f"[*] Ensuring DHCP is enabled in {IWD_MAIN_CONF}...")
    main_conf_content = "[General]\nEnableNetworkConfiguration=true\n"

    if os.path.exists(IWD_MAIN_CONF):
        with open(IWD_MAIN_CONF, "r") as f:
            current = f.read()
        if "EnableNetworkConfiguration=true" not in current:
            with open(IWD_MAIN_CONF, "a") as f:
                f.write("\n" + main_conf_content)
    else:
        with open(IWD_MAIN_CONF, "w") as f:
            f.write(main_conf_content)

    # 4. Create .8021x file
    print(f"[*] Creating connection profile: {CONFIG_PATH}...")
    config_content = f"""[Security]
EAP-Method=TTLS
EAP-Identity={username}
EAP-TTLS-CACert={CA_PATH}
EAP-TTLS-ServerDomainMask=secure.um5.ac.ma;secure.ac.ma
EAP-TTLS-Phase2-Method=Tunneled-PAP
EAP-TTLS-Phase2-Identity={username}
EAP-TTLS-Phase2-Password={password}

[Settings]
AutoConnect=true
"""
    with open(CONFIG_PATH, "w") as f:
        f.write(config_content)
    os.chmod(CONFIG_PATH, 0o600)

    # 5. Restart iwd
    print("[*] Restarting iwd service...")
    run_cmd("systemctl restart iwd")

    # 6. Attempt connection
    print(f"[*] Attempting to connect to '{SSID}'...")
    # Give iwd a second to restart
    import time

    time.sleep(2)

    result = run_cmd(f'iwctl station wlan0 connect "{SSID}"')

    if result.returncode == 0:
        print("\n[+] SUCCESS! You should now be connected.")
        print("[+] Check your status with: iwctl station wlan0 show")
    else:
        print("\n[-] Connection command sent, but iwd reported an error.")
        print("[-] Check logs with: sudo journalctl -u iwd -f")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nAborted.")
        sys.exit(0)
