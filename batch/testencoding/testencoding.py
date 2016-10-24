import chardet
import os
from sys import argv, stdin
from win32api import GetShortPathName
import locale

def main0():
	print argv
	for fname in os.listdir(unicode(argv[1])):
		#result = chardet.detect(fname)
		#print fname,type(fname),result
		#fname.decode(result['encoding'])
		#print fname,type(fname),chardet.detect(fname)
		#print fname.encode(locale.getpreferredencoding()),type(fname),
		#print argv[1]+'\\'+fname,
		print chardet.detect(fname),type(fname),
		fname = GetShortPathName(argv[1]+'\\'+fname).encode(locale.getpreferredencoding(),'ignore')
		#print type(fname)
		print chardet.detect(fname),type(fname),
		print fname

def main():
	for fname in os.listdir(unicode(argv[1])):
		fname = argv[1]+'\\'+fname
		if (os.path.isfile(fname)):
			try:
				f = open(fname,'r')
				f.close()
			except:
				print "open failed:", fname.encode(locale.getpreferredencoding(),'ignore')
		

if __name__ == '__main__':
    main()
