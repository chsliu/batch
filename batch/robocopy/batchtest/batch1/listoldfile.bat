@echo off

set SOURCE=\\Whs\網管區
set TARGET=emptypath
set OPTION=/XD "System Volume Information" RECYCLER /S /L /FP /NS /NC /NDL /LOG:misoldfile-4.txt /TEE /NJH /NJS /minlad:1000 /LEV:5
set FILES=

robocopy %SOURCE% %TARGET% %FILES% %OPTION%


