@setlocal enableextensions & cls & python -x "%~f0" %* & goto :EOF

import sys
import os
#import subprocess
from config import *

def main():
	for dir in savegameDirs:
		savegame = os.path.expandvars(dir)
		backup = '"' + backRoot + os.path.splitdrive(savegame)[1] + '"'
		savegame = '"' + savegame + '"'
		args = ['robocopy', backup, savegame, files] + options
		cmd = " ".join(args)
		print cmd
		os.system(cmd)
		
if __name__ == '__main__':
	main()
	raw_input('Press any key to continue...')

