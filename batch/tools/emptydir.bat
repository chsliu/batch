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
rd /q /s . 2> NUL
popd

:DONE
endlocal

