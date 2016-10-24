@echo off

set SOURCE=\\N2\Media
set TARGET=emptypath
REM OPTION= 
set OPTION=/XD "System Volume Information" RECYCLER /S /L /FP /NS /NC /NDL /LOG:media300lv5.txt /TEE /NJH /NJS /minlad:300 /LEV:5
set FILES=

robocopy %SOURCE% %TARGET% %FILES% %OPTION%


