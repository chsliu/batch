@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys
from persistendb import PersistenDB, PersistenDBDated


def warning_item(*objs):
	for obj in objs:
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)
	
	
def savepage(file,db):
	# warning("===savepage")
	url = ""
	page = ""
	try:
		url = file.readline().strip()
		page = file.read().strip()
	except: pass
	
	if len(page) > 0: 
		list = []
		urls = "urls"
		if urls in db: list = db[urls]
		list.insert(0,url)
		db[urls] = list
		db[url] = page
		
		# stringTest(page)
		# pageTest(page)
		# warning("[SavePage]",len(page),"Bytes in",url)
		# warning("[SavePage]",len(page),"Bytes",type(page))
	

def outputpage(db):
	try:
		# warning("===outputpage")
		url = db["urls"][0]
		# page = ""
		page = db[url]
		
		# page = db[url].encode('utf-8')
		print(url)
		print(page)
	except: pass
	
	# stringTest(page)
	# pageTest(page)
	# warning("[LoadPage]",len(page),"Bytes in",url)
	# warning("[LoadPage]",len(page),"Bytes",type(page))
	
	
def modePassThrough(f,db):	
	savepage(f,db)
	outputpage(db)
	
	
def modeOutput(f,db):
	outputpage(db)
	
	
def stringTest(s):
	from bs4 import UnicodeDammit
	import hashlib
	
	dammit = UnicodeDammit(s)
	
	m = hashlib.md5()
	m.update(s)
	
	warning("String:",len(s),"Bytes","MD5 Digest",m.hexdigest(),type(s),dammit.original_encoding)
	
	
def pageTest(page):
	from bs4 import BeautifulSoup
	
	warning("Page:",len(page),"Bytes","Title",BeautifulSoup(page,'html.parser').title)
	
		
def main():
	f = sys.stdin
	
	# url = ""
	# try:
		# url = sys.argv[1]		
	# except: pass
	
	dblimit = 2
	db = PersistenDB(dblimit)
	try:
		dbname = sys.argv[1]
		db.open(dbname)
	except: pass
	
	modes={  
    "Default":	modePassThrough,        
    "Cached":	modeOutput,
    }    
	
	try:
		mode = sys.argv[2]
		# warning(mode)
		# modes[mode](url,f,db)
		modes[mode](f,db)
	except:
		# warning(sys.exc_info()[0])
		# warning(sys.exc_info())
		# modes["Default"](url,f,db)
		modes["Default"](f,db)
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
