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
	# warning("url",len(url),type(url),o,o.netloc)
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
	# return re.match(regex,line) != None
	

def outputtitle(file, db, onlynew):
	# warning("outputtitle")

	import urllib2
	from bs4 import BeautifulSoup
	for url in file:
		url = url.strip()
		
		# warning("url",len(url),type(url),url)

		if not isValidURL(url): continue
		
		# warning("valid",len(url),type(url),url)
		
		if url in db:
			if not onlynew:
				# dbrejuvenate(db, url)
				title = db[url].replace('\n',' ')
				# codex = chardet.detect(title)
				# warning(codex,title)
				warning("[Cached]",title)
				# print("TITLE:",title) 
				print("TITLE:",title.encode('utf-8')) 
				print(url) 
		else:
			try:
				warning_item("[Title]")
				page = BeautifulSoup(urllib2.urlopen(url),'html.parser')
				# page = BeautifulSoup(urllib2.urlopen(url),'lxml')
				title = page.title.string.replace('\n',' ')
				# enc,likely = lang_detect(title)
				# warning(enc,likely,title)
				# codex = chardet.detect(title)
				# warning(codex,title)
				warning(title)
				db[url] = title
				# print("TITLE:",title) 
				print("TITLE:",title.encode('utf-8')) 
				print(url) 
				page.decompose()
			except:
				warning(sys.exc_info())
				warning("[Title Error]",sys.exc_info()[0],url)
				
	
# def dbinit(dbfilename):
	# warning("[Init]",dbfilename)
	##raw_input()
	# db = {}
	# dbsave(dbfilename,db)
	
	
# AGEKEY = '__age__'
# AGE = {}	


# def dbload(dbfilename):
	##warning("[Loading ....]",dbfilename)
	# if not os.path.isfile(dbfilename): dbinit(dbfilename)
	
	# pkl_file = gzip.open(dbfilename, 'rb')
	# db = {}
	# try:
		# db = pickle.load(pkl_file)
		# pkl_file.close()
	# except:
		# warning("[Loading Error]",dbfilename)
		##warning("[Error]")
		##raw_input()
	##print(db) 
	##warning("[Loading Done]")
	# return db
	
	
# def isdbchanged(dbfilename,db):
	# import hashlib
	
	# olddb=dbload(dbfilename)
	# oldhex=hashlib.md5(str(olddb)).hexdigest()
	# hex=hashlib.md5(str(db)).hexdigest()
	# changed= (oldhex != hex)
	##warning("oldhex:",oldhex,"hex:",hex,"changed:",changed)
	# return changed
	
	
# def dbsave(dbfilename,db):
	# if not isdbchanged(dbfilename,db): 
		##warning_item("[Nochange]",dbfilename)
		# return
	# dbaging(db)
	# dbretire(db)
	# warning_item("[Saving]",dbfilename)
	# pkl_file = gzip.open(dbfilename, 'wb')
	# pickle.dump(db, pkl_file)
	# pkl_file.close()
	# warning("[Done]")
	

# def dbloadage(db,age):
	##age = {}
	# try: AGE = db[AGEKEY]
	# except: pass

	
# def dbaging(db):
	##age = {}
	# try: AGE = db[AGEKEY]
	# except: pass
	# for var in db:
		# if var != AGEKEY:
			# try: AGE[var] = AGE[var] + 1
			# except: AGE[var] = 1
	# db[AGEKEY] = AGE
	
	
# def dbretire(db, agecount=100):
	##age = {}
	# try: AGE = db[AGEKEY]
	# except: pass
	# vars = AGE.keys()
	# for var in vars:
		# if AGE[var] >= agecount:
			# warning("[Retired]",db[var])
			# db.pop(var)
			# AGE.pop(var)


# def dbrejuvenate(db, var):
	##age = {}
	# try: 
		# AGE = db[AGEKEY]
		# AGE[var] = 0
	# except: pass

	
def main():
	sys.argv = win32_unicode_argv()
	if len(sys.argv) < 1:
		usage(sys.argv[0])
		return
	
	f = sys.stdin
	
	# dbsize = 1000
	# try: dbsize = int(sys.argv[2])
	# except: pass

	# warning("[dbsize]",dbsize)
	
	# db = dbload(dbname)
	# db = PersistenDB(dbsize)

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
	except: pass
	
	onlynew = False
	try: onlynew = bool(int(sys.argv[3]))
	except: pass
	
	outputtitle(f,db,onlynew)
	
	# dbsave(dbname,db)
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
