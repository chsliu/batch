@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys
import inspect
from optparse import OptionParser
import os


USAGE = "usage: %prog listdir_file path_prefix filename_postfix"


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


def touch(fname, times=None):
    with open(fname, 'a'):
        os.utime(fname, times)


def check_create_file(filename):
	if not filename:
		return
	elif os.path.isfile(filename):
		return
	else:
		head, tail = os.path.split(filename)
		check_create_path(head)
		touch(filename)


def filename_wash(filename):
	# for c in filename:
		# print(c.encode("hex"))
	return filename.replace('\x3f','_')
				
		
def parse(filename,prefix,postfix,ends):
	import io
	for line in reversed(io.open(filename,'r',encoding='utf-8-sig').readlines()):
		line=line.strip()
		# print(line)		
		tokens=line.split(':')
		if len(tokens) == 0: continue
		if tokens[0] == '': continue
		# print(tokens)
		drive=''
		path=''
		if len(tokens) >= 1: drive=tokens[0]
		if len(tokens) >= 2: path=tokens[1]
		newfilename=prefix+'\\'+drive+path
		if not os.path.exists(newfilename):
			if not newfilename.endswith(ends):
				newfilename=newfilename+'.'+postfix+".txt"
			warning("New File:",newfilename)
			check_create_file(filename_wash(newfilename))


def main():
	parser = OptionParser(USAGE)
	parser.add_option("-v", "--verbose",
                  action="store_true", dest="verbose", default=True,
                  help="make lots of noise [default]")
	parser.add_option("-f", "--filename", metavar="FILE", help="write output to FILE")
	opt, args = parser.parse_args()
	
	if len(args) < 4:
		print(USAGE)
		sys.exit(1)
		
	file_name = args[0]
	prefix = args[1]
	postfix = args[2]
	ends = args[3]

	# print("file_name:",file_name)
	# print("prefix:",prefix)
	
	# if opt.dummy: dummy = int(opt.dummy)
	# else:         dummy = 0
	
	# try: pass
	# except:
		# warning(sys.exc_info()[0])
		# warning(sys.exc_info())
		
	f = sys.stdin
	parse(file_name,prefix,postfix,ends)


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
