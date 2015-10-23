@setlocal enableextensions & python -x "%~f0" %* & goto :EOF


from __future__ import print_function
import sys


def warning(*objs):
	print(*objs, file=sys.stderr)


def main():
	print "Hello World"
	raw_input()
	

if __name__ == '__main__':
    main()
