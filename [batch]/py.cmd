@setlocal enableextensions & cls & python -x "%~f0" %* & goto :EOF

def main():
	print "Hello World"
	raw_input()
	

if __name__ == '__main__':
    main()
