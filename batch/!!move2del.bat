@echo off
cls

echo python "%~dp0move2subpath.py" DEL %*

python "%~dp0move2subpath.py" DEL %*

timeout 10
rem pause
