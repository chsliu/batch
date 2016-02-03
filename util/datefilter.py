from __future__ import print_function
import sys
import inspect
import re
from datetime import datetime, date


def warning_item(*objs):
	for obj in objs:
		if isinstance(obj,unicode): obj=unicode(obj).encode(sys.stderr.encoding,'replace')
		print(obj,file=sys.stderr, end=" ")


def warning(*objs):
	for obj in objs: warning_item(obj)
	print("",file=sys.stderr)


def isYear(num):
	try: 
		num = int(num)
		if 1900 <= num and num <= datetime.now().year+1: return True
		if 0 <= num and num <= 99: return True
	except: return False


def lineno():
	"""Returns the current line number in our program."""
	return inspect.currentframe().f_back.f_lineno


# def isMonth(num):
	# try:
		# num = int(num)
		# if 1 <= num and num <= 12: return True
	# except: return False
	
	
# def isDay(num):
	# try:
		# num = int(num)
		# if 1 <= num and num <= 31: return True
	# except: return False
	
	
def filter8digitwithpart(line):
	m = re.search("\D+(\d{4})\D{0,2}(\d{2})\D{0,2}(\d{2})\D{1,2}(\d)", line)
	# if m: return m.group(0)
	if m: return m
	return None
	
	
def filter8digitwithpart_convert(m):
	try:
		g1 = m.group(1)
		g2 = m.group(2)
		g3 = m.group(3)
		g4 = m.group(4)
		# warning(g1,g2,g3)
	except:
		warning("line,",lineno(),m.string,m.groups())
	try: return datetime(int(g1),int(g2),int(g3),int(g4))
	except: pass	
	g = g1+g2+g3
	# warning(g,g[4:],g[:2],g[2:4]) 
	try: return datetime(int(g[4:]),int(g[:2]),int(g[2:4]),int(g4))
	except: pass	

	
# def filter8digit(line):
	# m = re.search("(\d{4})\D*(\d{4})", line)
	## if m: return m.group(0)
	# if m: return m
	# return None
	

# def filter8digit_convert(m):
	# try:
		# g1 = m.group(1)
		# g2 = m.group(2)
	# except:
		# warning(m)
	# try: return date(int(g1),int(g2[:2]),int(g2[2:]))
	# except: pass
	# try: return date(int(g2),int(g1[:2]),int(g1[2:]))
	# except: pass
	
	
def filter8digitany(line):
	m = re.search("\D+(\d{4})\D{0,2}(\d{2})\D{0,2}(\d{2})", line)
	# if m: return m.group(0)
	if m: return m
	return None
	
	
def filter8digitany_convert(m):
	try:
		g1 = m.group(1)
		g2 = m.group(2)
		g3 = m.group(3)
		# warning(g1,g2,g3)
	except:
		warning("line,",lineno(),m.string,m.groups())
	try: return datetime(int(g1),int(g2),int(g3))
	except: pass	
	g = g1+g2+g3
	# warning(g,g[4:],g[:2],g[2:4]) 
	try: return datetime(int(g[4:]),int(g[:2]),int(g[2:4]))
	except: pass	


def filter8digitanyrev(line):
	m = re.search("\D+(\d{2})\D{0,2}(\d{2})\D{0,2}(\d{4})", line)
	# if m: return m.group(0)
	if m: return m
	return None
	
	
def filter8digitanyrev_convert(m):
	try:
		g1 = m.group(1)
		g2 = m.group(2)
		g3 = m.group(3)
	except:
		warning("line,",lineno(),m.string,m.groups())
	try: return datetime(int(g3),int(g1),int(g2))
	except: pass	
	try: return datetime(int(g3),int(g2),int(g1))
	except: pass	


# def filter8digitslash(line):
	# m = re.search("\d{4}/\d{2}/\d{2}", line)
	# if m: return m.group(0)
	# return None
	
	
# def filter8digitspace(line):
	# m = re.search("\d{4} \d{2} \d{2}", line)
	# if m: return m.group(0)
	# return None
	
	
# def filter8digitdot(line):
	# m = re.search("\d{4}\.\d{2}\.\d{2}", line)
	# if m: return m.group(0)
	# return None
	
	
# def filter8digitdotreverse(line):
	# m = re.search("\d{2}\.\d{2}\.\d{4}", line)
	## if m: return m.group(0)
	# if m: return m
	# return None
	
	
# def filter8digitdotreverse_convert(m):
	# try:
		# g1 = m.group(1)
		# g2 = m.group(2)
		# g3 = m.group(3)
	# except:
		# warning(m)
	# try: return date(int(g3),int(g1),int(g2))
	# except: pass	
	
	
# def filter8digithyphen(line):
	# m = re.search("(\d{4})-?(\d{2})-?(\d{2})", line)
	## if m: return m.group(0)
	# if m: return m
	# return None
	
	
# def filter8digithyphen_convert(m):
	# try:
		# g1 = m.group(1)
		# g2 = m.group(2)
		# g3 = m.group(3)
	# except:
		# warning(m)
	# try: return date(int(g1),int(g2),int(g3))
	# except: pass	
	
	
def filter7digit(line):
	m = re.search("(\d{3})(\d{2})(\d{2})", line)
	# if m: return m.group(0)
	if m: return m
	return None
	
	
def filter7digit_convert(m):
	try:
		g1 = m.group(1)
		g2 = m.group(2)
		g3 = m.group(3)
	except:
		warning("line,",lineno(),m.string,m.groups())
	try: return datetime(1911+int(g1),int(g2),int(g3))
	except: pass
	
	
def filter7digitanychar(line):
	m = re.search("\D+(\d{3})\D{0,2}(\d{1,2})\D{0,2}(\d{1,2})", line)
	# if m: return m.group(0)
	if m: return m
	return None
	
	
def filter7digitanychar_convert(m):
	try:
		g1 = m.group(1)
		g2 = m.group(2)
		g3 = m.group(3)
	except:
		warning("line,",lineno(),m.string,m.groups())
	try: return datetime(1911+int(g1),int(g2),int(g3))
	except: pass	
	
	
def filter6digit(line):
	m = re.search("(\d{6})", line)
	# if m: return m.group(0)
	if m: return m
	return None
	
	
def filter6digit_convert(m):
	try:
		g1 = m.group(1)
	except:
		warning("line,",lineno(),m.string,m.groups())
	try: return datetime(2000+int(g1[:2]),int(g1[2:4]),int(g1[4:]))
	except: pass
	
	
def filter6digitslash(line):
	m = re.search("\d{2}/\d{2}/\d{2}", line)
	# if m: return m.group(0)
	if m: return m
	return None
	
	
def filter6digitslash_convert(m):
	try:
		g1 = m.group(1)
		g2 = m.group(2)
		g3 = m.group(3)
	except:
		warning("line,",lineno(),m.string,m.groups())
	try: return datetime(int(g1),int(g2),int(g3))
	except: pass
	try: return datetime(int(g2),int(g3),int(g1))
	except: pass
	
	
def filter4digit(line):
	m = re.search("(\d{4})", line)
	# if m: return m.group(0)
	if m: return m
	return None
	
	
def filter4digit_convert(m):
	try:
		g1 = m.group(1)
		try: return datetime(datetime.now().year,int(g1[:2]),int(g1[2:]))
		except: pass
		if isYear(int(g1)): return datetime(int(g1),1,1)
	except:
		warning("line,",lineno(),m.string,m.groups())
	
	
def filter4digitanychar(line):
	m = re.search("(\d{1,2})\D{0,2}(\d{1,2})", line)
	# if m: return m.group(0)
	if m: return m
	return None
	
	
def filter4digitanychar_convert(m):
	try:
		g1 = m.group(1)
		g2 = m.group(2)
	except:
		warning("line,",lineno(),m.string,m.groups())
	try: return datetime(datetime.now().year,int(g1),int(g2))
	except: pass
	
	
def datefilter(line):
	res = None
	filter = None
	convert = None
	if not res: filter = "8d+part";		convert = filter8digitwithpart_convert ;	res = filter8digitwithpart(line)
	# if not res: filter = "8d";		convert = filter8digit_convert ; 			res = filter8digit(line)
	if not res: filter = "8dany";		convert = filter8digitany_convert ;			res = filter8digitany(line)
	if not res: filter = "8danyrev";	convert = filter8digitanyrev_convert ;		res = filter8digitanyrev(line)
	# if not res: filter = "8dslash";	res = filter8digitslash(line)
	# if not res: filter = "8dspace"; 	res = filter8digitspace(line)
	# if not res: filter = "8ddot"; 	res = filter8digitdot(line) 
	# if not res: filter = "8ddotrev";	convert = filter8digitdotreverse_convert;	res = filter8digitdotreverse(line) 
	# if not res: filter = "8dhyphen";	convert = filter8digithyphen_convert;		res = filter8digithyphen(line) 
	if not res: filter = "7d"; 			convert = filter7digit_convert;				res = filter7digit(line)
	if not res: filter = "6d"; 			convert = filter6digit_convert;				res = filter6digit(line)
	if not res: filter = "7dany"; 		convert = filter7digitanychar_convert;		res = filter7digitanychar(line)
	if not res: filter = "6dslash"; 	convert = filter6digitslash_convert;		res = filter6digitslash(line)
	if not res: filter = "4d"; 			convert = filter4digit_convert;				res = filter4digit(line)
	if not res: filter = "4dany";		convert = filter4digitanychar_convert;		res = filter4digitanychar(line)
	
	# if res:
		# if convert: warning_item("[",filter,"]",convert(res),"|||",line);
		# else: warning_item("[",filter,"]",res,"|||",line);
	# else: warning_item("[======]",line)	
	
	if res: 
		if convert: 
			return str(convert(res)),str(filter)
	return None,None

	
def dofilter(file):
	list = []
	for line in file:
		line = line.decode('utf-8')
		if len(line) and line[0] != '#': continue
		if "===" in line: continue		
		
		print(filter(line))
		list.append(filter(line))
	
	print(sorted(list))
	
	
def main():
	dofilter(sys.stdin)
	
	
if __name__ == '__main__':
	import traceback
	import time
	
	try: 	
		main()
	except:
		traceback.print_exc()
		warning("Press Ctrl-C to Continue...")
		while True:  time.sleep(1)
