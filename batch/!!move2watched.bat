@echo off
cls

echo python "%~dp0move2subpath.py" WATCHED %*

python "%~dp0move2subpath.py" WATCHED %*

REM pause
