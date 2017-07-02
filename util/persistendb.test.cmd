@setlocal enableextensions & python -x "%~f0" %* & goto :EOF


from __future__ import print_function
import sys
from persistendb import PersistenDB


def warning_item(*objs):
	for obj in objs:
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stderr, end=" ")
	
	
def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)
	
	
def test(filename):
	db = PersistenDB()
	
	# db[111] = 0
	
	db.open(filename)
	
	# try: db[123] = db[123] + 1
	# except: db[123] = 0
	
	# try: print(db)
	# except: pass
	
	# try: print(db.age) 
	# except: pass
		
	try: print("count", db.count) 
	except: pass
	
	try: print("len", len(db)) 
	except: pass
	
	min = db.count
	for key in db.age:
		if min > db.age[key]:
			min = db.age[key]
	print("min", min)
	
	print(sorted(db.age.values())[:30])
	min = db.count - 3000
	try: 
		index = len(db)-3000
		if index > 0:
			min = sorted(db.age.values())[index]
			print(index,sorted(db.age.values())[index])		
	except: pass
	print(min)
	
	# db.close()
	
	
def main():
	filename = sys.argv[1]
	test(filename)
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
