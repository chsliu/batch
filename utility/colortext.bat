@echo off

goto :main

REM =================================
:ColorTextInit
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

REM goto :main
exit /b

REM =================================
:ColorText
REM DEL=<BACKSPACE><SPACE><BACKSPACE>
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

echo off
pushd %temp%
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
popd

exit /b

REM =================================
:main
REM =================================
echo say the name of the colors, don't read

REM 0 = Black       8 = Gray
REM 1 = Blue        9 = Light Blue
REM 2 = Green       A = Light Green
REM 3 = Aqua        B = Light Aqua
REM 4 = Red         C = Light Red
REM 5 = Purple      D = Light Purple
REM 6 = Yellow      E = Light Yellow
REM 7 = White       F = Bright White

REM call :ColorTextInit
REM echo abc
call :ColorText 0a "blue"
call :ColorText 0C "green"
call :ColorText 0b "red"
echo.
call :ColorText 19 "yellow"
call :ColorText 2F "black"
call :ColorText 4e "white"
