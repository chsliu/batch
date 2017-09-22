@setlocal enableextensions & cls & python -x "%~f0" %* & goto :EOF

import sys
import os
#import subprocess
from config import *

#def runProcess(exe):    
#    p = subprocess.Popen(exe, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
#    while(True):
#      retcode = p.poll() #returns None while subprocess is running
#      line = p.stdout.readline()
#      yield line
#      if(retcode is not None): break
				
#def main0():
#	for dir in savegameDirs:
#		savegame = os.path.expandvars(dir)
#		backup = backRoot + os.path.splitdrive(savegame)[1]
#		args = ['robocopy', savegame, backup, files] + options
#		print args,		
#		for line in runProcess(args): print line,
#		print ""

def main():
	for dir in savegameDirs:
		savegame = os.path.expandvars(dir)
		backup = '"' + backRoot + os.path.splitdrive(savegame)[1] + '"'
		savegame = '"' + savegame + '"'
		args = ['robocopy', savegame, backup, files] + options
		cmd = " ".join(args)
		print cmd
		os.system(cmd)
		
if __name__ == '__main__':	
	main()
	raw_input('Press any key to continue...')

