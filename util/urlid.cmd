@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys
import inspect
from optparse import OptionParser
import urllib


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


def encode(encodetxt):
	enc=urllib.quote(encodetxt.encode('utf-8'))
	return enc

	
def url_id(url):
	import hashlib
	
	m = hashlib.md5()
	m.update(url)
	
	# print(m.hexdigest())
	print(m.hexdigest()[-8:])


# USAGE = "usage: %prog [options] url1 url2"

def main():
	# parser = OptionParser(USAGE)
	# opt, args = parser.parse_args()
	
	# if len(args) < 2:
		# print(USAGE)
		# sys.exit(1)
	
	
	try: 	url=sys.argv[1]
	except: url=""
	
	for enc in sys.argv[2:]:
		url=url+encode(enc)
		
	url_id(url)


if __name__ == '__main__':
    main()
