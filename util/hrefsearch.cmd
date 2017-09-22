@setlocal enableextensions & python -x "%~f0" %* & goto :EOF
# -*- coding: utf-8 -*-

from __future__ import print_function
import sys
import re
from bs4 import BeautifulSoup
import codecs
codecs.register(lambda name: codecs.lookup('utf-8') if name == 'cp65001' else None)


def warning_item(*objs):
	for obj in objs:
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)
	

def getHtml(file):
	html_bytes = file.read().strip()
	html_doc = html_bytes.decode('utf-8')
	return html_bytes
	
	
def parselineToKey(line, pat, index=0):
	m = re.search(pat, line)
	if m: 
		# print m.groups()
		return m.group(index)

	
def hrefsearch(file,href_regex,maxitem):
	url = file.readline().strip()
	# html_doc = getHtml(file)
	html_doc = file.read().decode('utf8')
	# print(html_doc)
	# stringTest(html_doc)
	# warning("[hrefsearch]",len(html_doc),"Bytes",type(html_doc))
	
	soup = BeautifulSoup(html_doc,'html.parser')
	# soup = BeautifulSoup(html_doc,'lxml')
	# type(soup)
	# warning(soup.title.encode('utf-8'))
	# warning(soup.title)
	# for tag in soup.find_all(re.compile("/watch\?v=([^&]{11})")):
	# for tag in soup.find_all("a"):
	# for tag in soup.find_all(href=re.compile("/watch\?v=([^&]{11})")):
	
	# for link in soup.select('a[href^=http]'): print link['href'];
	
	count = 0
	# print(maxitem)
	list = []
	dict = {}
	for tag in soup.find_all(href=re.compile(href_regex)):
	
		# print(tag)
		# try:
			# print(tag.text.strip().encode('utf-8'))
			# print(tag.text.strip().decode('utf-8'))
		# except:
			# print(sys.exc_info())
			
		title = tag.text.strip().encode('utf-8')
		if len(title) > 0:
			# print("TITLE:",title)
			# print(tag['href'])
			url = parselineToKey(tag['href'], href_regex)
			if url not in list: list.append(url)
			dict[url] = title
			count = count + 1
		# print(count)
		if count >= maxitem: break
		
	for key in list:
		print("TITLE:",dict[key])
		# print(key)
		print(key,".")
	

def stringTest(s):
	from bs4 import UnicodeDammit
	import hashlib
	
	dammit = UnicodeDammit(s)
	
	m = hashlib.md5()
	m.update(s)
	
	warning("String:",len(s),"Bytes","MD5 Digest",m.hexdigest(),type(s),dammit.original_encoding)
	
	
def test():
	from bs4 import UnicodeDammit

	im = '悟缘'
	print(type(im)) 
	#<type 'str'>

	dammit = UnicodeDammit(im)
	print(dammit.unicode_markup) 
	#悟缘
	print(dammit.original_encoding) 
	#utf-8	
	
	
def main():
	f = sys.stdin
	
	href_regex = "."
	try:
		href_regex = sys.argv[1]
	except: pass
	
	maxitem = 1000
	try:
		maxitem = int(sys.argv[2])
	except: pass
	
	hrefsearch(f,href_regex,maxitem)
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
