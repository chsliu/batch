@setlocal enableextensions & cls & python -x "%~f0" %* & goto :EOF

import sys
import os
import os.path

def downloadSubtitle(pathfile):
	if os.path.isfile(pathfile):
		runfile = os.path.abspath("D:/Users/sita/Documents/tasks/ShooterSubPyDownloader/ShooterSubAll.py")
		# print runfile+' "'+pathfile+'"'
		os.system("python "+runfile+' "'+pathfile+'"')


def parseLog(filename):
	for line in open(filename,"r").readlines():
		if "[MOVE] Rename" in line:
			tokens = line.split("] to [")
			# print tokens[-1][:-2]
			downloadSubtitle(tokens[-1][:-2])
		

def main():
	fileNames = sys.argv[1:]
	# print "Hello World", fileNames 
	# raw_input()
	for file in fileNames:
		parseLog(file)
	# raw_input()
	

if __name__ == '__main__':
	main()
