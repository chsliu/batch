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
	
	
def pagetitle(file):
	from bs4 import BeautifulSoup

	url = file.readline().strip()
	page = file.read().strip()
	# stringTest(page)
	
	soup = BeautifulSoup(page,'html.parser')
	# soup = BeautifulSoup(page,'lxml')
	title = soup.title.string.replace('\n',' ')

	warning("[Page]",title)
	print("TITLE:",title.encode('utf-8')) 
	print(url)
	
	
def stringTest(s):
	from bs4 import UnicodeDammit
	import hashlib
	
	dammit = UnicodeDammit(s)
	
	m = hashlib.md5()
	m.update(s)
	
	warning("String:",len(s),"Bytes","MD5 Digest",m.hexdigest(),type(s),dammit.original_encoding)
	
	
def main():
	f = sys.stdin
	pagetitle(f)
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
