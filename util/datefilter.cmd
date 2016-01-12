@setlocal enableextensions & python -x "%~f0" %* & goto :EOF

from __future__ import print_function
import sys
import inspect
from datefilter import datefilter


def warning_item(*objs):
	for obj in objs:
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)


def lineno():
	"""Returns the current line number in our program."""
	return inspect.currentframe().f_back.f_lineno


def dofilter(file):
	list = []
	for line in file:
		line = line.decode('utf-8')
		if len(line) and line[0] != '#': continue
		if "===" in line: 
			warning_item("             ",line)
			continue		
		
		# print(datefilter(line))
		# list.append(datefilter(line))
		
		date,filter  = datefilter(line)
		if date: 
			warning_item("[",filter,"]")
			warning_item(date,"||",line)
		else: 
			warning_item("[ xxxxx ]")
			warning_item("xxxx-xx-xx","||",line)
	
	# print(sorted(list))

	
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

	
def sortByTitleDate(file):
	tableDate = {}
	table = readData(file)
	for entry in table:
		key,filter = datefilter(entry.decode('utf-8'))
		warning("Adding",key,entry.decode('utf-8'))
		if not key: key = entry
		try: tableDate[key].append(entry)
		except: tableDate[key] = [entry]
	
	# warning(sorted(tableDate.keys()))
	for datekey in sorted(tableDate.keys()):
		warning(datekey.decode('utf-8'))
		list = tableDate[datekey]

		# warning(sorted(list))
		for entry in sorted(list):
			warning("-",entry.decode('utf-8')) 
			# print(entry)
			# print(table[entry])

			
def main():
	dofilter(sys.stdin)
	
	# sortByTitleDate(sys.stdin)
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
