@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys
import inspect
from optparse import OptionParser


USAGE = "usage: %prog [options] arg1 arg2"


class bcolors:
	HEADER = '\033[95m'
	OKBLUE = '\033[94m'
	OKGREEN = '\033[92m'
	WARNING = '\033[93m'
	FAIL = '\033[91m'
	ENDC = '\033[0m'
	BOLD = '\033[1m'
	UNDERLINE = '\033[4m'
	

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
		# return [argv[i] for i in xrange(start, argc.value)]
		return [argv[i] for i in range(start, argc.value)]


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

def print_item(*objs):
	for obj in objs:
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stdout, end="")
		
def parse(file):
	import json
	try: 
		j=json.loads(open(file,'r').read())
		if 'personal' in j:
			try: print_item(j['personal']['path']) 
			# try: print_item('"'+j['personal']['path']+'"') 
			except: traceback.print_exc()
	except: print("C:\\")
	# print(j)


def main():
	parser = OptionParser(USAGE)
	parser.add_option("-v", "--verbose",
				  action="store_true", dest="verbose", default=True,
				  help="make lots of noise [default]")
	parser.add_option("-f", "--filename", metavar="FILE", help="write output to FILE")
	opt, args = parser.parse_args()
		
	# f = sys.stdin
	parse(args[0])


if __name__ == '__main__':
	import traceback
	import time
	
	try:
		if sys.platform == 'win32': sys.argv = win32_unicode_argv()
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
