@setlocal enableextensions & python -x "%~f0" %* & goto :EOF


from __future__ import print_function
import sys
import os
import pickle
# import cPickle as pickle
import gzip


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


def warning(*objs):
	print(*objs, file=sys.stderr)


def isValidURL(url):
	from urlparse import urlparse
	
	o = urlparse(url)
	if o.netloc == '': return False
	return True


def outputtitle(file, db):
	import urllib2
	from BeautifulSoup import BeautifulSoup
	for url in file:
		url = url.strip()
		
		if not isValidURL(url): continue
		
		if url in db:
			title = db[url].encode('utf-8').replace('\n',' ')
			warning("[Cache Found]",title)
			print("TITLE:",title) 
			print(url) 
		else:
			try:
				warning("[Souping ....]",url)
				page = BeautifulSoup(urllib2.urlopen(url))
				title = page.title.string.encode('utf-8').replace('\n',' ')
				db[url] = page.title.string
				print("TITLE:",title) 
				print(url) 
				warning("[Souping Done]",title)
				page.decompose()
			except:
				warning("[Souping Error]",sys.exc_info()[0],url)
				


def dbinit(dbfilename):
	warning("[Init]",dbfilename)
	# raw_input()
	db = {}
	dbsave(dbfilename,db)
	
	
def dbload(dbfilename):
	warning("[Loading ....]",dbfilename)
	if not os.path.isfile(dbfilename): dbinit(dbfilename)
	
	pkl_file = gzip.open(dbfilename, 'rb')
	db = {}
	try:
		db = pickle.load(pkl_file)
		pkl_file.close()
	except:
		warning("[Loading Error]",dbfilename)
		# raw_input()
	# print(db) 
	warning("[Loading Done]",dbfilename)
	return db
	
	
def dbsave(dbfilename,db):
	warning("[Saving ....]",dbfilename)
	pkl_file = gzip.open(dbfilename, 'wb')
	pickle.dump(db, pkl_file)
	pkl_file.close()
	warning("[Saving Done]",dbfilename)
	
	
def main():
	sys.argv = win32_unicode_argv()
	if len(sys.argv) < 1:
		usage(sys.argv[0])
		return
	
	f = sys.stdin
	dbname = sys.argv[1]
	
	## path = os.path.dirname(os.path.abspath(__file__))
	# home = os.path.expanduser("~")
	# dbfile = os.path.join(home,dbname+".pkl")
	
	db = dbload(dbname)
	
	outputtitle(f,db)
	
	dbsave(dbname,db)
	# print(len(sys.argv)) 
	# print(sys.argv) 
	# raw_input()


if __name__ == '__main__':
	main()
