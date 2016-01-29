@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys
import inspect
from optparse import OptionParser
from utf8sc2tc import utf8_str_to_utf8_tc


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

	
def parse(file):
	for line in file:
		print(utf8_str_to_utf8_tc(line.strip()))


USAGE = "usage: %prog [options] arg1 arg2"

def main():
	parser = OptionParser(USAGE)
	parser.add_option("-v", "--verbose",
                  action="store_true", dest="verbose", default=True,
                  help="make lots of noise [default]")
	parser.add_option("-f", "--filename", metavar="FILE", help="write output to FILE")
	opt, args = parser.parse_args()
	
	# if len(args) < 1:
		# print(USAGE)
		# sys.exit(1)
		
	# file_name = args[0]

	# if opt.dummy: dummy = int(opt.dummy)
	# else:         dummy = 0
	
	# try: pass
	# except:
		# warning(sys.exc_info()[0])
		# warning(sys.exc_info())
		
	f = sys.stdin
	parse(f)


if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
