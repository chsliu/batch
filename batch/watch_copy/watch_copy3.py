#Modified from: http://wiki.wxpython.org/HookingTheWndProc
##########################################################################
##
##  This is a modification of the original WndProcHookMixin by Kevin Moore,
##  modified to use ctypes only instead of pywin32, so it can be used
##  with no additional dependencies in Python 2.5
##
##########################################################################


import sys
import ctypes, GUID
from ctypes import c_long, c_int, wintypes

import wx


GWL_WNDPROC = -4
WM_DESTROY  = 2
DBT_DEVTYP_DEVICEINTERFACE = 0x00000005  # device interface class
DBT_DEVICEREMOVECOMPLETE = 0x8004  # device is gone
DBT_DEVICEARRIVAL = 0x8000  # system detected a new device
WM_DEVICECHANGE = 0x0219

## It's probably not neccesary to make this distinction, but it never hurts to be safe
if 'unicode' in wx.PlatformInfo:
    SetWindowLong = ctypes.windll.user32.SetWindowLongW
    CallWindowProc = ctypes.windll.user32.CallWindowProcW
else:
    SetWindowLong = ctypes.windll.user32.SetWindowLongA
    CallWindowProc = ctypes.windll.user32.CallWindowProcA

## Create a type that will be used to cast a python callable to a c callback function
## first arg is return type, the rest are the arguments
#WndProcType = ctypes.WINFUNCTYPE(c_int, wintypes.HWND, wintypes.UINT, wintypes.WPARAM, wintypes.LPARAM)
WndProcType = ctypes.WINFUNCTYPE(ctypes.c_long, ctypes.c_int, ctypes.c_uint, ctypes.c_int, ctypes.c_int)

if 'unicode' in wx.PlatformInfo:
    RegisterDeviceNotification = ctypes.windll.user32.RegisterDeviceNotificationW
else:
    RegisterDeviceNotification = ctypes.windll.user32.RegisterDeviceNotificationA
RegisterDeviceNotification.restype = wintypes.HANDLE
RegisterDeviceNotification.argtypes = [wintypes.HANDLE, wintypes.c_void_p, wintypes.DWORD]

UnregisterDeviceNotification = ctypes.windll.user32.UnregisterDeviceNotification
UnregisterDeviceNotification.restype = wintypes.BOOL
UnregisterDeviceNotification.argtypes = [wintypes.HANDLE]

class DEV_BROADCAST_DEVICEINTERFACE(ctypes.Structure):
    _fields_ = [("dbcc_size", ctypes.c_ulong),
                  ("dbcc_devicetype", ctypes.c_ulong),
                  ("dbcc_reserved", ctypes.c_ulong),
                  ("dbcc_classguid", GUID.GUID),
                  ("dbcc_name", ctypes.c_wchar * 256)]

class DEV_BROADCAST_HDR(ctypes.Structure):
    _fields_ = [("dbch_size", wintypes.DWORD),
                ("dbch_devicetype", wintypes.DWORD),
                ("dbch_reserved", wintypes.DWORD)]


class WndProcHookMixin:
    """
    This class can be mixed in with any wxWindows window class in order to hook it's WndProc function.
    You supply a set of message handler functions with the function addMsgHandler. When the window receives that
    message, the specified handler function is invoked. If the handler explicitly returns False then the standard
    WindowProc will not be invoked with the message. You can really screw things up this way, so be careful.
    This is not the correct way to deal with standard windows messages in wxPython (i.e. button click, paint, etc)
    use the standard wxWindows method of binding events for that. This is really for capturing custom windows messages
    or windows messages that are outside of the wxWindows world.
    """
    def __init__(self):
        self.__msgDict = {}
        ## We need to maintain a reference to the WndProcType wrapper
        ## because ctypes doesn't
        self.__localWndProcWrapped = None
        self.rtnHandles = []

    def hookWndProc(self):
        self.__localWndProcWrapped = WndProcType(self.localWndProc)
        self.__oldWndProc = SetWindowLong(self.GetHandle(),
                                        GWL_WNDPROC,
                                        self.__localWndProcWrapped)
    def unhookWndProc(self):
        SetWindowLong(self.GetHandle(),
                        GWL_WNDPROC,
                        self.__oldWndProc)

        ## Allow the ctypes wrapper to be garbage collected
        self.__localWndProcWrapped = None

    def addMsgHandler(self,messageNumber,handler):
        self.__msgDict[messageNumber] = handler

    def localWndProc(self, hWnd, msg, wParam, lParam):
        # call the handler if one exists
        # performance note: "in" is the fastest way to check for a key
        # when the key is unlikely to be found
        # (which is the case here, since most messages will not have handlers).
        # This is called via a ctypes shim for every single windows message
        # so dispatch speed is important
        if msg in self.__msgDict:
            # if the handler returns false, we terminate the message here
            # Note that we don't pass the hwnd or the message along
            # Handlers should be really, really careful about returning false here
            if self.__msgDict[msg](wParam,lParam) == False:
                return

        # Restore the old WndProc on Destroy.
        if msg == WM_DESTROY: self.unhookWndProc()

        return CallWindowProc(self.__oldWndProc,
                                hWnd, msg, wParam, lParam)

    def registerDeviceNotification(self, guid, devicetype=DBT_DEVTYP_DEVICEINTERFACE):
        devIF = DEV_BROADCAST_DEVICEINTERFACE()
        devIF.dbcc_size = ctypes.sizeof(DEV_BROADCAST_DEVICEINTERFACE)
        devIF.dbcc_devicetype = devicetype

        if guid:
            devIF.dbcc_classguid = GUID.GUID(guid)
        return RegisterDeviceNotification(self.GetHandle(), ctypes.byref(devIF), 0)

    def unregisterDeviceNotification(self, handle):
        if UnregisterDeviceNotification(handle) == 0:
            raise Exception("Unable to unregister device notification messages")


# a simple example
if __name__ == "__main__":

    class MyFrame(wx.Frame,WndProcHookMixin):
        def __init__(self,parent):
            WndProcHookMixin.__init__(self)
            wx.Frame.__init__(self,parent,-1,"Insert and Remove USE Device and Watch STDOUT",size=(640,480))

            self.Bind(wx.EVT_CLOSE, self.onClose)

            #Change the following guid to the GUID of the device you want notifications for
            self.devNotifyHandle = self.registerDeviceNotification(guid="{3c5e1462-5695-4e18-876b-f3f3d08aaf18}")

            self.addMsgHandler(WM_DEVICECHANGE, self.onDeviceChange)
            self.hookWndProc()

        def onDeviceChange(self,wParam,lParam):
            print "WM_DEVICECHANGE [WPARAM:%i][LPARAM:%i]"%(wParam,lParam)

            if wParam == DBT_DEVICEARRIVAL:
                print "Device Arrival"
            elif wParam == DBT_DEVICEREMOVECOMPLETE:
                print "Device Remvoed"

            if lParam:
                dbh = DEV_BROADCAST_HDR.from_address(lParam)
                if dbh.dbch_devicetype == DBT_DEVTYP_DEVICEINTERFACE:
                    dbd = DEV_BROADCAST_DEVICEINTERFACE.from_address(lParam)
                    #Verify that the USB VID and PID match our assigned VID and PID
                    if 'Vid_10c4&Pid_8382' in dbd.dbcc_name:
                        print "Was Our USB Device"

            return True

        def onClose(self, event):
            self.unregisterDeviceNotification(self.devNotifyHandle)
            event.Skip()


    app = wx.App(False)
    frame = MyFrame(None)
    frame.Show()
    app.MainLoop()
