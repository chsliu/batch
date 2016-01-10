@setlocal enableextensions & python -x "%~f0" %* & goto :EOF


from __future__ import print_function
import sys
import os
import pickle
# import cPickle as pickle
import gzip
from persistendb import PersistenDB, PersistenDBDated
from datetime import datetime, timedelta
# from lang_detect import zh2utf8,lang_detect
import chardet


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
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)


def isValidURL(url):
	from urlparse import urlparse
	
	o = urlparse(url)
	if o.netloc == '': return False
	return True


# def isValidURL(line):
	# import re
	# regex = re.compile(
        # r'^(?:http|ftp)s?://' # http:// or https://
        # r'(?:(?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+(?:[A-Z]{2,6}\.?|[A-Z0-9-]{2,}\.?)|' #domain...
        # r'localhost|' #localhost...
        # r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' # ...or ip
        # r'(?::\d+)?' # optional port
        # r'(?:/?|[/?]\S+)$', re.IGNORECASE)
	# return re.match(regex,line)
	
	
def m3udb(file, db, onlynew):
	title = ""
	for url in file:
		url = url.strip()
		
		if url[0] == "#": title = url
		
		if not isValidURL(url): continue
		
		if url in db:
			if not onlynew:
				warning("[Cached]",title.decode('utf-8'))

				print(title)
				print(url) 
		else:
			titleUnicode = title.decode('utf-8')
			warning("[Title]",titleUnicode)
			db[url] = titleUnicode

			print(title) 
			print(url)
	
	
def main():
	sys.argv = win32_unicode_argv()
	if len(sys.argv) < 1:
		usage(sys.argv[0])
		return
	
	f = sys.stdin
	

	dblimit = 1000
	db = PersistenDB(dblimit)
	try:
		dblimit = sys.argv[2]
		# warning("[dblimit",dblimit,"]")
	except: pass
	# warning("[DB",dblimit,"items]")
	try:
		if dblimit[-1] == 'd':
			dblimit = int(dblimit[:-1])
			db = PersistenDBDated(expiredelta=timedelta(days=dblimit))
			# warning("[DB",dblimit,"days]")
		elif dblimit[-1] == 'w':
			dblimit = int(dblimit[:-1])
			db = PersistenDBDated(expiredelta=timedelta(weeks=dblimit))
			# warning("[DB",dblimit,"weeks]")
		elif dblimit[-1] == 'm':
			dblimit = int(dblimit[:-1])
			db = PersistenDBDated(expiredelta=timedelta(days=dblimit*365.0/12))
			# warning("[DB",dblimit,"months]")
		elif dblimit[-1] == 'y':
			dblimit = int(dblimit[:-1])
			db = PersistenDBDated(expiredelta=timedelta(days=dblimit*365))
			# warning("[DB",dblimit,"months]")
		else:
			dblimit = int(dblimit)
			db = PersistenDB(dblimit)
			warning("[DB",dblimit,"items]")
	except: pass
		
	try:
		dbname = sys.argv[1]
		db.open(dbname)
		# warning("[DBNAME",dbname,"]")
	except: pass
	
	onlynew = False
	try: onlynew = bool(int(sys.argv[3]))
	except: pass
	
	m3udb(f,db,onlynew)
	
	
	
if __name__ == '__main__':
	main()
	
