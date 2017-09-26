@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    Red = '\033[91m'
    Green = '\033[92m'
    Blue = '\033[94m'
    Cyan = '\033[96m'
    White = '\033[97m'
    Yellow = '\033[93m'
    Magenta = '\033[95m'
    Grey = '\033[90m'
    Black = '\033[90m'
    Default = '\033[99m'


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
	# html_doc = file.read().strip()
	html_doc = file.read().decode('utf8')
	# stringTest(html_doc)
	
	soup = BeautifulSoup(html_doc,'html.parser')
	# soup = BeautifulSoup(html_doc,'lxml')
	title = ""
	if soup.title: title = soup.title.string.replace('\n',' ')

	# warning("  [Page]",title)
	warning(bcolors.Yellow,"  [Page]",title.encode('cp950','replace'),bcolors.ENDC)
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
