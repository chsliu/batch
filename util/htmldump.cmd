@setlocal enableextensions & python -x "%~f0" %* & goto :EOF


from __future__ import print_function
import sys
import urllib2
import urllib


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


def warning(*objs):
	print(*objs, file=sys.stderr)


def htmldump(url):
	warning("[Dumping ....]",url)
	# raw_input()
	
	try:
		filehandle = urllib2.urlopen(url)
		print("".join(filehandle.readlines())) 
		warning("[Dumping Done]",url)
	except:
		warning("[Dumping Error]",url)
	return
	
	# data={}
	# data['topics[]']='universe'
	# url_values = urllib.urlencode(data)
	## print url_values
	# html=""
	# try:
		# response = urllib2.urlopen(url,url_values)
		# html = response.read()
	# except HTTPError, e:
		# print 'The server couldn\'t fulfill the request.'
		# print 'Error code: ', e.code
	# except URLError, e:
		# print 'We failed to reach a server.'  
		# print 'Reason: ', e.reason  
	# except:
		# pass
	
	# print html


def main():
	sys.argv = win32_unicode_argv()
	if len(sys.argv) < 1:
		usage(sys.argv[0])
		return
	
	
	url=sys.argv[1]
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
