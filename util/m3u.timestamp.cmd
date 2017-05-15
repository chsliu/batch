@setlocal enableextensions & python -x "%~f0" %* & goto :EOF


from __future__ import print_function
import sys
from datefilter import datefilter


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


def today():
	from datetime import date
	return date.today().strftime("%Y%m%d")
	

def m3u_title_insert(ins,title):
	seg = title.split(",")
	seg.insert(1,","+ins)
	return "".join(seg)

	
def timestamp(f):
	# table = {}
	line = f.readline()
	while line:
		line = line.strip()
		if len(line) and line[0] == '#':
			url = f.readline().strip()
			if url:
				# table[line]=url
				dat,rule = datefilter(line.decode('utf-8'))
				if not dat: 	
					print(m3u_title_insert("["+today()+"]",line))
				elif dat == 'None':  	
					print(m3u_title_insert("["+today()+"]",line),"["+rule+"]")
				elif rule == "4d":
					print(m3u_title_insert("["+today()+"]",line),"["+rule+"]")
					# print(m3u_title_insert("["+dat[:10]+"]",line),"["+rule+"]")
				elif rule == "4dany":
					print(m3u_title_insert("["+today()+"]",line),"["+rule+"]")
				elif rule == "7d":
					# print(m3u_title_insert("["+today()+"]",line),"["+rule+"]")
					print(m3u_title_insert("["+dat[:10]+"]",line),"["+rule+"]")
				elif rule == "7dany":
					print(m3u_title_insert("["+today()+"]",line),"["+rule+"]")
				else: 			
					# print("["+rule+"]",line)
					print(line,"["+rule+"]")
				print(url)	
		else:
			print("")
		line = f.readline()
	

def main():
	sys.argv = win32_unicode_argv()
	if len(sys.argv) < 1:
		usage(sys.argv[0])
		return
	
	f = sys.stdin
	
	timestamp(f)
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
