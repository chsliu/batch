set path=C:\HashiCorp\Vagrant\embedded\bin;%path%

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%

REM =================================
set INPUT="\\hv4\Software\UNIX\Lubuntu\xbmc\userdata\[special]\missing\missing.txt"
REM set INPUT="d:\Users\sita\Desktop\missing.txt"
set TEMPOUT=%temp%\missing.txt
set TEMPOUT2=%temp%\missing2.txt
set OUTPUT="\\hv4\Software\UNIX\Lubuntu\xbmc\userdata\[special]\missing\missing.filtered-%TODAY%.txt"

REM =================================
findstr /C:".avi" %INPUT% >%TEMPOUT%
findstr /C:".mp4" %INPUT% >>%TEMPOUT%
findstr /C:".mkv" %INPUT% >>%TEMPOUT%
findstr /C:".rmvb" %INPUT% >>%TEMPOUT%
findstr /C:".rm" %INPUT% >>%TEMPOUT%
findstr /C:".vob" %INPUT% >>%TEMPOUT%
findstr /C:".VOB" %INPUT% >>%TEMPOUT%

findstr /C:"Library/Movies" %TEMPOUT% >%TEMPOUT2%
findstr /C:"Library/Music" %TEMPOUT% >>%TEMPOUT2%
findstr /C:"Library/TV Shows" %TEMPOUT% >>%TEMPOUT2%

REM =================================
REM notepad %TEMPOUT2% 
sort %TEMPOUT2% >%OUTPUT%
REM notepad %OUTPUT% 
del %TEMPOUT% %TEMPOUT2%
