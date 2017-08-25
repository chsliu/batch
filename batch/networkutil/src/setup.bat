@echo off

echo ============== networkcheck ============== 
python setup.py py2exe

del *.pyc
del *.bak

REM pause
