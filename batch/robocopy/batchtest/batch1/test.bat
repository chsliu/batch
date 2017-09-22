@echo off

set SOURCE=D:\Users\sita\Documents\PortableAppsRoot
set TARGET=emptypath
REM OPTION=/X /NFL 
set OPTION=/S /L /FP /NS /NC /NDL /LOG:test.txt /TEE /NJH /NJS /minlad:100 /LEV:4
set FILES=*.exe

robocopy %SOURCE% %TARGET% %FILES% %OPTION%


pause

