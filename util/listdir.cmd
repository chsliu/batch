@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys
import inspect
from optparse import OptionParser
import os


USAGE = "usage: %prog [options] arg1 arg2"


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
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)


def lineno():
	"""Returns the current line number in our program."""
	return inspect.currentframe().f_back.f_lineno

	
def parse(path):
	# from bs4 import UnicodeDammit
	# dammit=UnicodeDammit(path)
	# print(dammit.original_encoding,dammit.unicode_markup.encode("utf-8"))
	# print(path.encode("utf-8"))
	for root, dirs, files in os.walk(path):
	# for root, dirs, files in os.walk(unicode(dammit.unicode_markup)):
		for file in files:
			fullpath=os.path.join(root, file)
			# warning(fullpath)
			print(fullpath.encode("utf-8"))
			
			# dammit=UnicodeDammit(os.path.join(root, file), ['utf-8','utf-8-sig',"utf-16le","utf-16be","gb2312","gbk","big5"])
			# dammit=UnicodeDammit(os.path.join(root, file), ["utf-16","gb2312","gbk","big5"])
			# print(dammit.original_encoding,dammit.unicode_markup.encode("utf-8"))

			
def hexprint(str):
	for c in str:
		warning_item(c.encode("utf-8",'replace'))
		warning(hex(ord(c)))
	

def main():
	parser = OptionParser(USAGE)
	parser.add_option("-v", "--verbose",
                  action="store_true", dest="verbose", default=True,
                  help="make lots of noise [default]")
	parser.add_option("-f", "--filename", metavar="FILE", help="write output to FILE")
	opt, args = parser.parse_args()
	
	if len(args) < 1:
		print(USAGE)
		sys.exit(1)
		
	# file_name = args[0]

	# if opt.dummy: dummy = int(opt.dummy)
	# else:         dummy = 0
	
	# try: pass
	# except:
		# warning(sys.exc_info()[0])
		# warning(sys.exc_info())
		
	# f = sys.stdin
	# parse(args[0].decode("utf-8"))
	
	path=args[0]
	
	# from bs4 import UnicodeDammit
	# dammit=UnicodeDammit(path)
	# print("Press any key...",dammit.original_encoding,dammit.unicode_markup.encode("utf-8"))
	# print("Press any key...",dammit.original_encoding,dammit.unicode_markup)
	# raw_input()
	
	# print("Press any key...",path.encode("utf-8"))
	# print("Press any key...",hexprint(path))
	# raw_input()
	
	parse(path)


if __name__ == '__main__':
	import traceback
	import time
	
	try:
		sys.argv = win32_unicode_argv()
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
