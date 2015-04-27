import sys
import shutil
import commands
import os

##rootPathWords = ['Game', 'Install', 'Media', 'Documentary', 'Public']


##def addSubPath(string, token, subPath):
####    print string, token, subPath
####    raw_input("addSubPath...")
##    iStart = string.rfind(token)
##    if iStart > 0:
##        iEnd = iStart+len(token)
##        return string[:iEnd] + string[iEnd] + subPath + string[iEnd:]
##    return None


def check_create_path(path):
##    print path
    if not path:
        return
    elif os.path.exists(path):
        return
    else:
        head, tail = os.path.split(path)
        check_create_path(head)
        os.mkdir(path)


def isDirEmpty(path):
    list = os.listdir(path)
    try:
    	list.remove('Thumbs.db')
    except:
    	pass
    return len(list) == 0


##def moveToNewPath(filename,rootPath,newPath):
####    print filename,rootPath,newPath
####    raw_input("moveToNewPath...")
##    if not os.path.exists(filename):
####        raw_input("%s not exist" % filename)
##        return
##    newfilename = addSubPath(filename, rootPath, newPath)
##    if newfilename:
####        print newfilename
####        raw_input("check_create_path...")
##        check_create_path(os.path.split(newfilename)[0])
####        print filename
##        try:
##          print newfilename.encode("utf-8")
##        except:
##          pass
##        shutil.move(filename, newfilename)
##        oldpath = os.path.split(filename)[0]
##        if isDirEmpty(oldpath):
####            print oldpath
##            shutil.rmtree(oldpath)
##    return newfilename


def move(filename, oldServer, newServer):
##    print filename, oldServer, newServer
    newfilename = filename.replace(oldServer, newServer)
    if newfilename != filename:
##        print newfilename
        check_create_path(os.path.split(newfilename)[0])
        try:
            print newfilename.encode("utf-8")
        except:
            pass
        shutil.move(filename, newfilename)
##        raw_input()
        oldpath = os.path.split(filename)[0]
        if isDirEmpty(oldpath):
##            print oldpath
            shutil.rmtree(oldpath)

def usage(prog):
    print "%s <oldServer> <newServer> <path|filename>" % prog


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
    sys.argv = win32_unicode_argv()
    if len(sys.argv) < 4:
        usage(sys.argv[0])
        return

##    print sys.argv
##    raw_input("Press any key...")

    oldServer = sys.argv[1]
    newServer = sys.argv[2]

##    try:
    print 'Processing:'
    for arg in sys.argv[3:]:
##        print arg
##        raw_input("Press any key...")
        move(arg, oldServer, newServer)
##    except:
##        print sys.exc_info()
##        raw_input()
##        pass


##def test1():
##    check_create_path('//nas/Documentary/KEEP1/KEEP2/KEEP3/KEEP4/KEEP5')


if __name__ == '__main__':
    main()

