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


def outputtitle(file, db):
	import urllib2
	from BeautifulSoup import BeautifulSoup
	for url in file:
		url = url.strip()
		
		if not isValidURL(url): continue
		
		if url in db:
			dbrejuvenate(db, url)
			title = db[url].replace('\n',' ')
			warning("[Cached]",title)
			print("TITLE:",title.encode('utf-8')) 
			print(url) 
		else:
			try:
				warning_item("[Souping]")
				page = BeautifulSoup(urllib2.urlopen(url))
				title = page.title.string.replace('\n',' ')
				warning(title)
				db[url] = title
				print("TITLE:",title.encode('utf-8')) 
				print(url) 
				page.decompose()
			except:
				warning("[Souping Error]",sys.exc_info()[0],url)
				


def dbinit(dbfilename):
	warning("[Init]",dbfilename)
	# raw_input()
	db = {}
	dbsave(dbfilename,db)
	
	
AGEKEY = '__age__'
AGE = {}	


def dbload(dbfilename):
	# warning("[Loading ....]",dbfilename)
	if not os.path.isfile(dbfilename): dbinit(dbfilename)
	
	pkl_file = gzip.open(dbfilename, 'rb')
	db = {}
	try:
		db = pickle.load(pkl_file)
		pkl_file.close()
	except:
		warning("[Loading Error]",dbfilename)
		# warning("[Error]")
		# raw_input()
	# print(db) 
	# warning("[Loading Done]")
	return db
	
	
def isdbchanged(dbfilename,db):
	import hashlib
	
	olddb=dbload(dbfilename)
	oldhex=hashlib.md5(str(olddb)).hexdigest()
	hex=hashlib.md5(str(db)).hexdigest()
	changed= (oldhex != hex)
	# warning("oldhex:",oldhex,"hex:",hex,"changed:",changed)
	return changed
	
	
def dbsave(dbfilename,db):
	if not isdbchanged(dbfilename,db): 
		# warning_item("[Nochange]",dbfilename)
		return
	dbaging(db)
	dbretire(db)
	warning_item("[Saving]",dbfilename)
	pkl_file = gzip.open(dbfilename, 'wb')
	pickle.dump(db, pkl_file)
	pkl_file.close()
	warning("[Done]")
	

def dbloadage(db,age):
	# age = {}
	try: AGE = db[AGEKEY]
	except: pass

	
def dbaging(db):
	# age = {}
	try: AGE = db[AGEKEY]
	except: pass
	for var in db:
		if var != AGEKEY:
			try: AGE[var] = AGE[var] + 1
			except: AGE[var] = 1
	db[AGEKEY] = AGE
	
	
def dbretire(db, agecount=100):
	# age = {}
	try: AGE = db[AGEKEY]
	except: pass
	vars = AGE.keys()
	for var in vars:
		if AGE[var] >= agecount:
			warning("[Retired]",db[var])
			db.pop(var)
			AGE.pop(var)


def dbrejuvenate(db, var):
	# age = {}
	try: 
		AGE = db[AGEKEY]
		AGE[var] = 0
	except: pass

	
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
