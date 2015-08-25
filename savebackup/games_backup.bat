@echo off

set SOURCE=.
set TARGET=\\n2\Public\games
set OPTION=/S /XO 
set FILES=

robocopy %SOURCE% %TARGET% %FILES% %OPTION%

