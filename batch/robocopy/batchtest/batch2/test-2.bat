@echo off

echo %%0 is %0

for /f "tokens=1-7 delims=\" %%g in (%0) do (
set T1=%%g
set T2=%%h
set T3=%%i
set T4=%%j
set T5=%%k
set T6=%%l
set T7=%%m
)

REM goto exit

for %%i in (%T1% %T2% %T3% %T4% %T5% %T6% %T7%) do (set filename=%%i)

echo %%filename is %filename%

REM goto exit

for /f "tokens=1-7 delims=." %%g in ("%filename%") do (
set T1=%%g
set T2=%%h
set T3=%%i
set T4=%%j
set T5=%%k
set T6=%%l
set T7=%%m
)

echo %%T1 is %T1%
set T1=%T1%.py
echo %%T1 is %T1%

REM goto exit

c:\django\python26\python %T1% %1 %2 %3 %4 %5 %6 %7 %8 %9 

:exit

pause

