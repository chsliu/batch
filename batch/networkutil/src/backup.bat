@echo off

set SOURCE=.
set TARGET=\\n3\users\sita\source\networkutil\src
set OPTION=/MIR 
set FILES=

robocopy %SOURCE% %TARGET% %FILES% %OPTION%

pause
