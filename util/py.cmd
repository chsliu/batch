@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys


def warning_item(*objs):
	for obj in objs:
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)
	
	
def parse(file):
	pass
	
	
def main():
	f = sys.stdin
	parse(f)
	
	
if __name__ == '__main__':
    main()