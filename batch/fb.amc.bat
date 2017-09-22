set path=%path%;D:\Users\sita\PortableApps\FileBot_4.5-portable

REM =================================

set LOG1=D:\Users\sita\PortableApps\FileBot_4.5-portable\logs\amc.txt

REM =================================

filebot -script fn:amc --output "\\\\hv3\\Media2\\TV" --log-file amc.txt --action move --conflict skip -non-strict --def artwork=y extras=y unsorted=y subtitles=en,zh "ut_label=%L%" "ut_state=%S%" "ut_title=%N%" "ut_kind=%K%" "ut_file=%F%" "ut_dir=%D% " xbmc=192.168.1.62 "seriesFormat=\\\\hv3\\Media2\\TV/{n} ({y})/{\"Season ${s.pad(2)}\"}/{n} - {s00e00} - {t} - {airdate}.{vf}{'.'+source}.{vc}{'-'+group}{'.'+lang}" "movieFormat=\\\\hv3\\Media2\\Movie/{y}/{y} {n} {audios.language}/{n.space('.')}.{y}.{vf}{'.'+source}.{vc}.{af}.{ac}{'-'+group}{'-'+\"CD$pi\"}{'.'+lang}" "animeFormat=\\\\hv3\\Media2\\ACG/{n} ({y})/{\"Season ${s.pad(2)}\"}/{n} - {s00e00} - {t} - {airdate}.{vf}{'.'+source}.{vc}{'-'+group}{'.'+lang}" "musicFormat=\\\\hv3\\Music/{n}/{'['+y+'] '+album+'/'}{pi.pad(2)+'. '} {artist} - {t} {[af, audio.SamplingRateString, audio.bitRateString]}"

REM =================================

echo Waiting for fb:amc on %N% ...

call :WaitForWord %LOG1% "Done" "Failure"

echo List of newly moved files:	
findstr /C:"[MOVE]" %LOG1%		

del %LOG1%

REM pause

goto :EOF

REM =================================

:WaitForWord

ping 127.0.0.1 -n 10 -w 1000 > nul

if not exist %1 goto :WaitForWord
echo Waiting for Logfile, size is %~z1

2>nul (
  >>%1 (call )
) && (
  echo Logfile %~nx1 is ready
) || (
  echo Logfile %~nx1 is not ready
  goto :WaitForWord
)

findstr %2 %1 > nul
if %ERRORLEVEL%==0 goto :EOF

findstr %3 %1 > nul
if %ERRORLEVEL%==0 goto :EOF

goto :WaitForWord



