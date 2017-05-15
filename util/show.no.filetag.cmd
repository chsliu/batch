@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys
import inspect
from optparse import OptionParser
import os


USAGE = "usage: %prog inputfile"


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


def filterinvalid(str):
	if isinstance(str,unicode): 
		str = unicode(str).encode('utf-8')
		str = str.decode('utf-8')
	return str

	
# def parse(fname,ftag,var):
def parse(fname,ftag):
	# print(fname,type(fname),ftag,type(ftag))
	if ftag:
		# tokens = fname.split(ftag)
		# print(tokens)
		fname_new = fname.replace(ftag,"")
		# print(fname_new,var)
		print(fname_new)
		# print(filterinvalid(fname_new))
		# raw_input()
		# os.environ[var] = fname_new
		# os.putenv(var,fname_new)
		# os.environ['abc'] = fname_new
		# print(os.environ)
		# for key in sorted(os.environ): print(key,"==",os.environ[key])
	else:
		print(fname)
		# print(filterinvalid(fname))
		

def main():
	parser = OptionParser(USAGE)
	parser.add_option("-v", "--verbose",
                  action="store_true", dest="verbose", default=True,
                  help="make lots of noise [default]")
	# parser.add_option("-f", "--filename", metavar="FILE", help="write output to FILE")
	opt, args = parser.parse_args()
	
	if len(args) < 1:
		print(USAGE)
		sys.exit(1)
		
	file_name = args[0]
	file_tag = args[1]
	# variablename = sys.argv[0]

	# if opt.dummy: dummy = int(opt.dummy)
	# else:         dummy = 0
	
	# try: pass
	# except:
		# warning(sys.exc_info()[0])
		# warning(sys.exc_info())
		
	try:
		# f = sys.stdin
		parse(file_name,file_tag)
		# parse(file_name,file_tag,variablename)
	except:
		pass


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
