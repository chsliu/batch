# coding: utf-8
import sys
import shutil
import commands

def decode(s):
    if isinstance(s, unicode):
        return s
    return s.decode('mbcs')

def GetVolumeInformation(rootPathName):
    import ctypes

    DWORD = ctypes.c_ulong
    MAX_PATH = ctypes.c_int(260)
    MAX_PATH_NULL = int(MAX_PATH.value) + 1

    volumeSerialNumber = DWORD()
    maximumComponentLength = DWORD()
    fileSystemFlags = DWORD()

    if hasattr(ctypes.windll.kernel32, "GetVolumeInformationW"):
        rootPathName = decode(rootPathName)
        volumeNameBuffer = ctypes.create_unicode_buffer(MAX_PATH_NULL)
        fileSystemNameBuffer = ctypes.create_unicode_buffer(MAX_PATH_NULL)
        GVI = ctypes.windll.kernel32.GetVolumeInformationW
    else:
        volumeNameBuffer = ctypes.create_string_buffer(MAX_PATH_NULL)
        fileSystemNameBuffer = ctypes.create_string_buffer(MAX_PATH_NULL)
        GVI = ctypes.windll.kernel32.GetVolumeInformationA
    GVI(rootPathName, volumeNameBuffer, MAX_PATH_NULL,
        ctypes.byref(volumeSerialNumber), ctypes.byref(maximumComponentLength),
        ctypes.byref(fileSystemFlags), fileSystemNameBuffer, MAX_PATH_NULL)
    return (volumeNameBuffer.value, volumeSerialNumber.value,
            maximumComponentLength.value, fileSystemFlags.value,
            fileSystemNameBuffer.value)

def win32_unicode_argv():
    """Uses shell32.GetCommandLineArgvW to get sys.argv as a list of Unicode
    strings.

    Versions 2.x of Python don't support Unicode in sys.argv on
    Windows, with the underlying Windows API instead replacing multi-byte
    characters with '?'.
    """

    from ctypes import POINTER, byref, cdll, c_int, windll
    from ctypes.wintypes import LPCWSTR, LPWSTR

    GetCommandLineW = cdll.kernel32.GetCommandLineW
    GetCommandLineW.argtypes = []
    GetCommandLineW.restype = LPCWSTR

    CommandLineToArgvW = windll.shell32.CommandLineToArgvW
    CommandLineToArgvW.argtypes = [LPCWSTR, POINTER(c_int)]
    CommandLineToArgvW.restype = POINTER(LPWSTR)

    cmd = GetCommandLineW()
    argc = c_int(0)
    argv = CommandLineToArgvW(cmd, byref(argc))
    if argc.value > 0:
        # Remove Python executable and commands if present
        start = argc.value - len(sys.argv)
        return [argv[i] for i in
                xrange(start, argc.value)]

def main():
  import os
  
  sys.argv = win32_unicode_argv()
  batchpath = sys.argv[0]
  args = sys.argv[1:]
  #print args

  if not args:
    print 'error: no args'
    sys.exit()

  for arg in args:
    label = GetVolumeInformation(arg)[0]
    print "copying " + label + " from " + arg
    #print os.getcwd()
    #print os.path.dirname(batchpath)
    shutil.copytree(arg, os.path.dirname(batchpath) + "\\" + label)

  

if __name__ == '__main__':
  main()
  
  import ctypes
  ctypes.windll.winmm.mciSendStringW(u"set cdaudio door open", None, 0, None)
  
  from winsound import Beep  
  try:
    Beep(1250, 1000)
  except:
    print "Beep!"
