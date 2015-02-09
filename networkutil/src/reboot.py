# Reboot a remove server

import win32security
import win32api
import sys
import time
from ntsecuritycon import *


def RebootServer(message='Server Rebooting', timeout=30, bForce=0, bReboot=1):
    AdjustPrivilege(SE_SHUTDOWN_NAME)
    try:
        win32api.InitiateSystemShutdown(None, message, timeout, bForce, bReboot)
    finally:
        # Remove the privilege we just added.
        AdjustPrivilege(SE_SHUTDOWN_NAME, 0)


def AbortReboot():
    AdjustPrivilege(SE_SHUTDOWN_NAME)
    try:
        win32api.AbortSystemShutdown(None)
    finally:
        # Remove the privilege we just added.
        AdjustPrivilege(SE_SHUTDOWN_NAME, 0)


def AdjustPrivilege(priv, enable=1):
    # Get the process token.
    flags = TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY
    htoken = win32security.OpenProcessToken(win32api.GetCurrentProcess(), flags)
    # Get the ID for the system shutdown privilege.
    id = win32security.LookupPrivilegeValue(None, priv)
    # Obtain the privilege for this process.
    # Create a list of the privileges to be added.
    if enable:
        newPrivileges = [(id, SE_PRIVILEGE_ENABLED)]
    else:
        newPrivileges = [(id, 0)]
    # and make the adjustment.
    win32security.AdjustTokenPrivileges(htoken, 0, newPrivileges)


if __name__=='__main__':
        message = 'This server is pretending to reboot\nThe shutdown will stop in 10 seconds'
        RebootServer(message)
        print 'Sleeping for 10 seconds'
        time.sleep(10)
        print 'Aborting shutdown'
        AbortReboot()
