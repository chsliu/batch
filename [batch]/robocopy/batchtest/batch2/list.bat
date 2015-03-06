@echo off

set SOURCE=\\n2\Music\iTunes
set TARGET=emptypath
set OPTION=/XD "System Volume Information" RECYCLER /S /L /FP /NS /NC /NDL /LOG:mp3.txt /TEE /NJH /NJS
set FILES=*.mp3

robocopy %SOURCE% %TARGET% %FILES% %OPTION%
