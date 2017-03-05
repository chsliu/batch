import sys
import shutil
import commands
import os
import locale

# former is more dominant
# rootPathWords = [

# 'GBA',
# 'iOS',
# 'NDS',
# 'NGC',
# 'PC',
# 'PS2',
# 'PS3',
# 'PSP',
# 'Wii',
# 'X360',
# 'XBox',

# 'Movie',
# 'Music',
# 'TV',

# 'ACG',
# 'AV',
# 'Book',
# 'Comic',
# 'Documentary',
# 'Dorama',
# 'Mandarin',

# 'Install',
# 'Media',
# 'Library',
# 'Documentary',
# 'Public',
# 'Software',
# 'D:',
# 'C:',
# 'Backup',
# 'Download',

# 'Games'
# ]

rootPathWords = [
'C:',
'D:',
'E:',
'F:',
'P:',
'Z:',
'Admin',
'Download',
'Games',
'Library',
'Media',
'Music',
'NetBackup',
'Photos',
'Software',
'Users',
'YouTube',
'Video',
]

removeWords = [
'KEEP NEW',
'KEEP',
'WATCHED',
'DEL',
'TRIED',
'FINISHED'
]


def nameIsSubdir(name, fullpath):
    tokens = [t.lower() for t in fullpath.split('\\')]
    return name.lower() in tokens

def removeKeyWords(string):
##    print string, type(string)
    for w in removeWords:
        if not nameIsSubdir(w,string): continue
##        print 'replacing', w, type(w),
        print "removeWords:",w
        iStart = string.rfind(w)
        if (iStart>=0):
            iEnd = iStart+len(w)+1
            return string[:iStart] + string[iEnd:]
##        string.replace(w,'')
##        print string, type(string)
##    raw_input()
    return string

#def indexOfSubdir(name,fullpath):
#    iEnd = len(fullpath)
#    while iEnd > 0:
#        iStart = fullpath.lower().rfind(name.lower(),0,iEnd)
#        if iStart > 0 and fullpath[iStart-1] != '\\':
#            iEnd = iStart
#            continue
#        return iStart

def rfindsub(list,token):
    for i in range(len(list)-1,-1,-1):
        if list[i].lower() == token.lower(): return i
    return -1

def indexOfSubdir2(name,fullpath):
    f=fullpath.replace('/','\\')
    tokens = f.split('\\')
    if name not in tokens: return -1
    tokens[rfindsub(tokens,name)] = '*'
    return ('\\').join(tokens).rfind('*')

def addSubPath(string, token, subPath):
##    print string, token, subPath
##    raw_input("addSubPath...")
    string = removeKeyWords(string)
##    raw_input()
##    iStart = string.lower().rfind(token.lower())
    iStart = indexOfSubdir2(token.lower(),string.lower())
    if iStart >= 0:
        iEnd = iStart+len(token)
        return string[:iEnd] + string[iEnd] + subPath + string[iEnd:]
    return None


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


def checkRemovePath(path):
    if isDirEmpty(path):
##            print oldpath
##        shutil.rmtree(path)
        try:
            os.rmdir(path)
        except WindowsError as e:
            try:
                print "\n"
##                print e
##                print "\n"
                print "Unable to delete: " + path.encode(locale.getpreferredencoding(),'ignore')
            except IOError as err:
                print "\n"
##                print err
##                print "\n"

        parent = os.path.split(path)[0]
        checkRemovePath(parent)


def moveToNewPath(filename,rootPath,newPath):
##    print filename,rootPath,newPath
##    raw_input("moveToNewPath...")
    if not os.path.exists(filename):
##        raw_input("%s not exist" % filename)
        return
    newfilename = addSubPath(filename, rootPath, newPath)
    if newfilename:
##        print newfilename
##        raw_input("check_create_path...")
        check_create_path(os.path.split(newfilename)[0])
##        print filename
        try:
          print newfilename.encode(locale.getpreferredencoding(),'ignore')
##          print newfilename
        except:
          pass
        print "rootPath:",rootPath
        shutil.move(filename, newfilename)
        oldpath = os.path.split(filename)[0]
        checkRemovePath(oldpath)
    return newfilename


def move(filename, newSubPath):
    if (os.path.isdir(filename)): checkRemovePath(filename)
    for root in rootPathWords:
        newFile = moveToNewPath(filename, root, newSubPath)
##        print root, newFile
        if newFile: return


def usage(prog):
    print "%s <newSubPath> <path|filename>" % prog


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
    if len(sys.argv) < 3:
        usage(sys.argv[0])
        return

##    print sys.argv
##    raw_input("Press any key...")

    newSubPath = sys.argv[1]
    args = sys.argv[2:]

##    print type(newSubPath)
##    print type(args[0])

##    raw_input("Press any key to continue . . .")

    #os.system('chcp 65001')
##    try:
    print 'Processing:'
    for arg in args:
##        print arg
##        raw_input("Press any key...")
        move(arg, newSubPath)
##    except:
##        print sys.exc_info()
##        raw_input()
##        pass
##    raw_input()
    #os.system('chcp 950')


def test1():
    check_create_path('//nas/Documentary/KEEP1/KEEP2/KEEP3/KEEP4/KEEP5')


if __name__ == '__main__':
    main()