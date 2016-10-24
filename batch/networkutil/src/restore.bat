@echo off

set SOURCE=\\n3\users\sita\source\networkutil\src
set TARGET=.
set OPTION=/S /XO
set FILES=

robocopy %SOURCE% %TARGET% %FILES% %OPTION%

pause
