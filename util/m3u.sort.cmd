@setlocal enableextensions & python -x "%~f0" %* & goto :EOF


from __future__ import print_function
import sys


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


def readData(f):
	table = {}
	line = f.readline().strip()
	while line:
		if line[0] == '#':
			url = f.readline().strip()
			if url: table[line]=url
		line = f.readline().strip()
	return table
	
	
def sortByDefault(file):
	warning("[Sort]", "Default")
	for line in file:
		print(line, end="") 
	

def sortByReverse(f):
	warning("[Sort]", "Reverse")
	items = []
	while True:
		line1 = f.readline().strip()
		line2 = f.readline().strip()
		if not line2: break
		item = (line1, line2)
		items.append(item)
	
	for item in reversed(items):
		print(item[0])
		print(item[1])
		

def sortByTitle(file):
	warning("[Sort]", "Title")
	table = readData(file)
	# print(table) 
	
	for cmt in sorted(table.keys()):
		print(cmt)
		print(table[cmt])
	
	
def sortByTitleDigital(file):
	import re
	
	warning("[Sort]", "Title Digital")
	
	table = readData(file)
	tableDigital = {}
	
	for entry in table:
		digit = re.sub("\D","",entry)
		list = []
		try: list = tableDigital[digit]
		except: pass
		list.append(entry)
		tableDigital[digit]=list
	
	for digit in sorted(tableDigital.keys()):
		list = tableDigital[digit]
		for entry in sorted(list):
			print(entry)
			print(table[entry])		
	
	
def main():
	sys.argv = win32_unicode_argv()
	if len(sys.argv) < 1:
		usage(sys.argv[0])
		return
	
	f = sys.stdin
	
	sort={  
    "Default":	sortByDefault,        
    "Reverse":	sortByReverse,
	"Title":	sortByTitle,
	"TitleDigital":	sortByTitleDigital,
    }    
	
	try:
		sortType = sys.argv[1]
		# print(sortType)
		sort[sortType](f)
	except:
		# warning(sys.exc_info()[0])
		sort["Default"](f)	
	
	
if __name__ == '__main__':
	main()
