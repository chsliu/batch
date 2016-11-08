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


def readData(f):
	table = {}
	line = f.readline()
	while line:
		line = line.strip()
		if len(line) and line[0] == '#':
			url = f.readline().strip()
			if url: table[line]=url
			# warning("Adding",line.strip(),url.strip())
		line = f.readline()
	return table
	
	
def sortByDefault(file):
	# warning("[Sort]", "Default")
	for line in file:
		print(line, end="") 
	

def sortByReverse(f):
	# warning("[Sort]", "Reverse")
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
	# warning("[Sort]", "Title")
	table = readData(file)
	# print(table) 
	
	for cmt in sorted(table.keys()):
		print(cmt)
		print(table[cmt])
	
	
def sortByTitleDigital(file):
	import re
	
	# warning("[Sort]", "Title Digital")
	
	table = readData(file)
	tableDigital = {}
	
	for entry in table:
		# digit = int(re.sub("\D","",entry))
		numbers = re.findall(r"\d+",entry)
		if len(numbers)==0: digit = 0
		elif len(numbers)==1: digit = int(numbers[0])
		else: digit = int(numbers[1])
		list = []
		try: list = tableDigital[digit]
		except: pass
		list.append(entry)
		tableDigital[digit]=list
	
	for digit in sorted(tableDigital.keys()):
		list = tableDigital[digit]
		dup = []
		for entry in sorted(list):
			url = table[entry]
			if url not in dup:
				print(entry)
				# print(table[entry])		
				print(url)		
				dup.append(url)
	
	
def sortByTitleDate(file):
	tableDate = {}
	table = readData(file)
	for entry in table:
		key = datefilter(entry.decode('utf-8'))
		if not key: key = entry
		try: tableDate[key].append(entry)
		except: tableDate[key] = [entry]
		
	for datekey in sorted(tableDate.keys()):
		list = tableDate[datekey]
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
	"TitleDate":	sortByTitleDate,
    }    
	
	try:
		sortType = sys.argv[1]
		# print(sortType)
		sort[sortType](f)
	except:
		# warning(sys.exc_info()[0])
		# warning(sys.exc_info())
		sort["Default"](f)	
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
