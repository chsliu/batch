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
	

def readDataOrdered(f):
	items = []
	while True:
		line1 = f.readline().strip()
		line2 = f.readline().strip()
		if not line2: break
		item = (line1, line2)
		items.append(item)

	return items

	
# def sortByDefault(file):
	# for line in file:
		# print(line, end="") 
	

# def sortByReverse(f):
	# items = []
	# while True:
		# line1 = f.readline().strip()
		# line2 = f.readline().strip()
		# if not line2: break
		# item = (line1, line2)
		# items.append(item)
	
	# for item in reversed(items):
		# print(item[0])
		# print(item[1])
		

# def sortByTitle(file):
	# table = readData(file)
	
	# for cmt in sorted(table.keys()):
		# print(cmt)
		# print(table[cmt])
	
	
# def sortByTitleDigital(file):
	# import re
		
	# table = readData(file)
	# tableDigital = {}
	
	# for entry in table:
		# digit = int(re.sub("\D","",entry))
		# list = []
		# try: list = tableDigital[digit]
		# except: pass
		# list.append(entry)
		# tableDigital[digit]=list
	
	# for digit in sorted(tableDigital.keys()):
		# list = tableDigital[digit]
		# for entry in sorted(list):
			# print(entry)
			# print(table[entry])		
	
	
# def sortByTitleDate(file):
	# tableDate = {}
	# table = readData(file)
	# for entry in table:
		# key = datefilter(entry.decode('utf-8'))
		# if not key: key = entry
		# try: tableDate[key].append(entry)
		# except: tableDate[key] = [entry]
		
	# for datekey in sorted(tableDate.keys()):
		# list = tableDate[datekey]
		# for entry in sorted(list):
			# print(entry)
			# print(table[entry])
	

def filterKeyword0(file,keyword):
	table = readData(file)
	# tableDigital = {}
	
	# warning(keyword,type(keyword))
	for title in table:
		titleUTF8 = title.decode('utf-8')
		# warning(keyword,type(keyword),title,type(title),titleUTF8,type(titleUTF8))
		# warning(title,type(title),titleUTF8,type(titleUTF8))
		# warning("keyword:",keyword,type(keyword),"titleUTF8:",titleUTF8,type(titleUTF8))
		if keyword in titleUTF8:
			# warning("==2==")
			print(title)
			print(table[title])
		

def filterKeyword(file,keyword):
	items = readDataOrdered(file)
	
	for item in items:
		titleUTF8 = item[0].decode('utf-8')
		if keyword in titleUTF8:
			print(item[0])
			print(item[1])

			
def main():
	sys.argv = win32_unicode_argv()
	if len(sys.argv) < 1:
		usage(sys.argv[0])
		return
	
	f = sys.stdin
	
	filter={  
    # "Default":	sortByDefault,        
    # "Reverse":	sortByReverse,
	# "Title":	sortByTitle,
	# "TitleDigital":	sortByTitleDigital,
	# "TitleDate":	sortByTitleDate,
    "Default":	filterKeyword,        
    }    
	
	opt = ""
	try:
		# sortType = sys.argv[1]
		# print(sortType)
		# sort[sortType](f)
		# warning("sys.stdin.encoding:",sys.stdin.encoding,"sys.stderr.encoding:",sys.stderr.encoding)
		# opt = sys.argv[1].strip().decode(sys.stderr.encoding)
		opt = sys.argv[1].strip()
		# str = sys.argv[1].strip()
		# warning("filter:",sys.argv[1],type(sys.argv[1]),opt,type(opt),hex(str[0]),hex(str[1]))
		# warning(type(str),hex(ord(str[0])))
		# warning(type(str),hex(ord(str[1])))
		# warning(hex(ord(opt[0])),hex(ord(opt[1])))
	except:
		# warning(sys.exc_info()[0])
		for line in sys.exc_info():	warning(line)
		# warning(sys.exc_info())
		
	filter["Default"](f, opt)	
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
