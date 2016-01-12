@setlocal enableextensions & python -x "%~f0" %* & goto :EOF


from __future__ import print_function
import sys
from datefilter import datefilter
from datetime import datetime,timedelta


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


def delta(dat):
	# print("dat type",type(dat),dat)
	delta = datetime.now() - datetime.strptime(dat[:10],"%Y-%m-%d")
	return delta
	
	
def trim(f,maxdaysAgo):
	# table = {}
	trimcnt = 0
	line = f.readline()
	while line:
		line = line.strip()
		if len(line) and line[0] == '#':
			url = f.readline().strip()
			if url: 
				dat,rule = datefilter(line.decode('utf-8'))
				# daysAgo = 0	# keep no date title
				daysAgo = maxdaysAgo	# remove no date title
				if dat and dat != "None":	daysAgo = delta(dat).days
				
				if daysAgo < maxdaysAgo:
					print(line)
					# print(line,"[",daysAgo,"]")
					print(url)
				else:
					warning("[Trim]",line.decode('utf-8'))
					trimcnt = trimcnt + 1
		else:
			print("")
		line = f.readline()
		
	warning("[Trim]",trimcnt,"Entries")
	

def main():
	sys.argv = win32_unicode_argv()
	if len(sys.argv) < 1:
		usage(sys.argv[0])
		return
	
	f = sys.stdin
	

	days = 3
	try:
		days = sys.argv[1]
	except: pass

	try:
		if days[-1] == 'd':
			days = int(days[:-1])
		elif days[-1] == 'w':
			days = int(days[:-1])*7
		elif days[-1] == 'm':
			days = int(days[:-1])*365.0/12
		elif days[-1] == 'y':
			days = int(days[:-1])*365
	except: pass
			
	
	trim(f,days)
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
