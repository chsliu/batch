@echo off
setlocal enableextensions
if {%1}=={} goto :HELP
if {%1}=={/?} goto :HELP
goto :START

:HELP
echo Usage: %~n0 directory-name
echo.
echo Empties the contents of the specified directory,
echo WITHOUT CONFIRMATION. USE EXTREME CAUTION!
goto :DONE

:START
pushd %1 || goto :DONE
echo Emptying %1...
rd /q /s . 2>NUL
takeown /f . /r /D Y 2>NUL
rd /q /s . 2>NUL
popd

:DONE
endlocal

