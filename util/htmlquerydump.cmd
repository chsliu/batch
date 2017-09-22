@setlocal enableextensions & python -x "%~f0" %* & goto :EOF


from __future__ import print_function
import sys
import urllib2
import urllib
import codecs
codecs.register(lambda name: codecs.lookup('utf-8') if name == 'cp65001' else None)


def usage(prog):
    # print "%s <inputfile> <pattern> [reversed]" % prog
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
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'xmlcharrefreplace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)


def encode(encodetxt):
	# data={}
	# print encodetxt
	# data['123']=encodetxt
	# print data
	# enc=urllib.urlencode(data)
	# enc=urllib.quote(encodetxt)
	enc=urllib.quote(encodetxt.encode('utf-8'))
	# print enc
	return enc


def htmldump(url):
	# warning("[Dumping ....]",url)
	# warning_item("[Dumping]",url)
	# raw_input()
	print(url)
	try:
		filehandle = urllib2.urlopen(url)
		# print("".join(filehandle.readlines()))
		page = filehandle.read().strip()
		print(page)
		# warning("[Dumping Done]",url)
		# stringTest(page)
		# pageTest(page)
		# warning("[Done]",len(page),"Bytes",type(page))
	except:
		warning(sys.exc_info())
		# warning("[Dumping Error]",url)
		warning("[Dump Error]",url)
	return
	
	
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
	sys.argv = win32_unicode_argv()
	if len(sys.argv) < 1:
		usage(sys.argv[0])
		return
	
	# warning(sys.argv) 
	
	url=sys.argv[1]
	# encodetxt=sys.argv[2]
	# url=prefix+encode(encodetxt)
	
	for enc in sys.argv[2:]:
		url=url+encode(enc)
	
	htmldump(url)
	
	
	# print len(sys.argv)
	# print sys.argv
	# raw_input()


if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
