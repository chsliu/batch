@echo off

set RAMDISK=R:
set FULLSRC=%1
set SRC="%~n1"


xcopy %FULLSRC% %RAMDISK%\%SRC%\  /S /XO
mv %FULLSRC% %FULLSRC%-ramdiskized
mklink /j %FULLSRC% %RAMDISK%\%SRC%

REM pause
