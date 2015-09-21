set path=C:\HashiCorp\Vagrant\embedded\bin;%path%

set INPUT="\\hv4\Software\UNIX\Lubuntu\xbmc\userdata\[special]\missing\missing.txt"
REM set INPUT="d:\Users\sita\Desktop\missing.txt"
set TEMPOUT=%temp%\missing.txt
set TEMPOUT2=%temp%\missing2.txt
set OUTPUT="\\hv4\Software\UNIX\Lubuntu\xbmc\userdata\[special]\missing\missing.filtered.txt"

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

REM notepad %TEMPOUT2% 
sort %TEMPOUT2% >%OUTPUT%
REM notepad %OUTPUT% 
del %TEMPOUT% %TEMPOUT2%
