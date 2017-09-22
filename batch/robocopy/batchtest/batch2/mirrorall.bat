@echo off

set SOURCE=.
set TARGET=\\Whs\research
set OPTION=/XD "System Volume Information" RECYCLER /MIR /DCOPY:T /MT
set FILES=

robocopy %SOURCE% %TARGET% %FILES% %OPTION%
