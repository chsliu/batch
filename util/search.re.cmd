@setlocal enableextensions & python -x "%~f0" %* & goto :EOF


from __future__ import print_function
import sys
import re


def usage(prog):
    # print "%s <inputfile> <pattern> [|Reverse|Nosort]" % prog
    print("%s <pattern> [Reverse]" % prog) 


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


def warning_item(*objs):
	for obj in objs:
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'xmlcharrefreplace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)


def parselineToKey(line, pat, index=0):
	m = re.search(pat, line)
	if m: 
		# print m.groups()
		return m.group(index)


def search(f,pat,index=0):
	warning("[Searching ....]",pat)
	# warning_item("[Searching ....]",pat)
	dict = {}
	for line in f:
		# print line
		key = parselineToKey(line,pat,index)
		if key: print(key) 
	# warning("[Searching Done]",pat)
	warning("[Searching Done]")


def main():
	sys.argv = win32_unicode_argv()
	if len(sys.argv) < 1:
		usage(sys.argv[0])
		return
	
	f=sys.stdin
	pattern=sys.argv[1]
	# print pattern
	index=0
	# print "len",len(sys.argv)
	if len(sys.argv) > 3: index=sys.argv[2]
	# print index
	search(f,pattern)
	
	# print len(sys.argv)
	# print sys.argv
	# raw_input()


if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
