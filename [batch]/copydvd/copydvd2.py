# coding: utf-8
import sys
import shutil
import commands

DBFILE = "copydvd.dict"
LOGFILE = "copydvd.log"

def savedict(dict):
    file = open(DBFILE, 'w')
    pickle.dump(dict, file)
    return

def loaddict():
    obj = {}
    if os.path.exists(DBFILE):
        file = open(DBFILE, 'r')
        obj = pickle.load(file)
    return obj

def checkdict(key, dict):
    if not dict[key]:
        return False
    else:
        return True

def updatedict(key, dict):
    count = dict[key]
    if not count:
        count = 0
    count += 1
    dict[key] = count
    return

def isDVD(drive):
    return False

def copyDVD(drive, targetpath):
    return

def eject():
    import ctypes
    ctypes.windll.winmm.mciSendStringW(u"set cdaudio door open", None, 0, None)
    return

def notify():
    from winsound import Beep
    try:
        Beep(1250, 1000)
    except:
        print "Beep!"
    return

def log(str):
    import time
    file = open(LOGFILE, 'a')
    file.write(time.ctime + " : " + str)
    file.close()
    return

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
    return

def copydvd2(drive, cur_dir, label):
    dict = loaddict()
    if not checkdict(label, dict):
        log("%s is copied before." % label)
    else:
        if isDVD(drive):
            copyDVD(drive, os.path.dirname(cur_dir) + "\\" + label)
            log("%s is DVD, copied." % label)
        else:
            #shutil.copytree(drive, os.path.dirname(cur_dir) + "\\" + label)
            log("%s is DATA, copied." % label)
    updatedict(label, dict)
    eject()
    notify()
    return

def main():
  import os

  sys.argv = win32_unicode_argv()
  cur_path = sys.argv[0]
  args = sys.argv[1:]
  #print args

  DBFILE = cur_path + DBFILE
  LOGFILE = cur_path + LOGFILE

  if not args:
    print 'error: no args'
    log("error: no args")
    sys.exit()

  for drive in args:
    label = GetVolumeInformation(drive)[0]
    print "copying " + label + " from " + drive
    #print os.getcwd()
    #print os.path.dirname(batchpath)
    #shutil.copytree(drive, os.path.dirname(cur_path) + "\\" + label)
    copydvd2(drive, os.path.dirname(cur_path), label)
  return

if __name__ == '__main__':
  main()


