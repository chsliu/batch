@echo off

set SOURCE=.
set TARGET=\\n2\Public\source\batch
set OPTION=/MIR 
set FILES=

robocopy %SOURCE% %TARGET% %FILES% %OPTION%

pause
