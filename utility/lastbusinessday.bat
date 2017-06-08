REM @echo off
set qty=-1
:loop4weekends
set "separator="
echo >"%temp%\%~n0.vbs" s=DateAdd("d",%qty%,now)
echo>>"%temp%\%~n0.vbs" d=weekday(s)
echo>>"%temp%\%~n0.vbs" WScript.Echo year(s)^&_
echo>>"%temp%\%~n0.vbs"         right(100+month(s),2)^&_
echo>>"%temp%\%~n0.vbs"         right(100+day(s),2)^&_
echo>>"%temp%\%~n0.vbs"         d
for /f %%a in ('cscript //nologo "%temp%\%~n0.vbs"') do set result=%%a
rem del "%temp%\%~n0.vbs"
endlocal& set "YY=%result:~0,4%" & set "MM=%result:~4,2%" & set "DD=%result:~6,2%" & set "daynum=%result:~-1%"
:: if the daynum is a weekend then loop to get the friday
set "weekend="
echo %daynum%
if %daynum% EQU 1 set weekend=1&set "qty=-3"
if %daynum% EQU 7 set weekend=1&set "qty=-2"
if defined weekend goto :loop4weekends

set "day=%YY%%separator%%MM%%separator%%DD%"
echo %%day%% is set to "%day%" (without the quotes)
pause
