@echo off

set SOURCE=\\n2\Public\source\batch
set TARGET=.
set OPTION=/S /XO
set FILES=

robocopy %SOURCE% %TARGET% %FILES% %OPTION%

pause
