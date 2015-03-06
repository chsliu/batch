import sys
import shutil
import commands
import os

def check_create_path(path):
  #print path
  if not path:
    return
  elif os.path.exists(path):
    return
  else:
    head, tail = os.path.split(path)
    check_create_path(head)
    os.mkdir(path)

def decode(s):
    if isinstance(s, unicode):
        return s
    return s.decode('mbcs')

def to_unicode_or_bust(obj, encoding='utf-8'):
    if isinstance(obj, basestring):
        if not isinstance(obj, unicode):
            obj = unicode(obj, encoding)
    return obj

def move(file):
  file = to_unicode_or_bust(file)
  filename = file.split('\\')[-1:][0]
  #print filename
  token = file.split('\\')[:-1]
  #print token
  token2 = []
  for t in token:
    if t.find("KEEP") >= 0:
      continue
    if t.find("WATCHED") >= 0:
      continue
    token2.append(t)
    if t == 'Media' or t.find(":")>=0:
      token2.append('WATCHED')
  token2.append(filename)
  #print token2
  newfile = u'\\'.join(token2)
  newfile = to_unicode_or_bust(newfile)
  try:
      print "Source: ",
      print file#.encode("utf-8")
      print "Target: ",
      print newfile#.encode("utf-8")
  except:
      pass
  check_create_path(os.path.dirname(newfile))
  shutil.move(file, u'\\'.join(token2))

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
#  sys.argv = win32_unicode_argv()
  args = sys.argv[1:]
  #print args

  if not args:
    print 'no args'
    #sys.exit()
    return

  try:
    for arg in args:
      move(arg)
  except:
    print sys.exc_info()
    raw_input()

if __name__ == '__main__':
  main()

