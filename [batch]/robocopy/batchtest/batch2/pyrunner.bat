@echo off

REM ==================================================================
REM Get filename of batch
REM ==================================================================
for /f "tokens=1-7 delims=\" %%g in (%0) do (
set __1=%%g
set __2=%%h
set __3=%%i
set __4=%%j
set __5=%%k
set __6=%%l
set __7=%%m
)

for %%i in (%__1% %__2% %__3% %__4% %__5% %__6% %__7%) do (set _filename=%%i)

REM ==================================================================
REM Get filename of batch without extension
REM ==================================================================
for /f "tokens=1-7 delims=." %%g in ("%_filename%") do (
set _1=%%g
set _2=%%h
set _3=%%i
set _4=%%j
set _5=%%k
set _6=%%l
set _7=%%m
)

REM ==================================================================
REM combine path with filename + .py
REM ==================================================================
set _temp=%0
if [%_temp:~1,2%]==[\\] (set _pathname=\\) else (set _pathname=)
if not [%__1%]==[] (if not [%__2%]==[] set _pathname=%_pathname%%__1%)
if not [%__2%]==[] (if not [%__3%]==[] set _pathname=%_pathname%\%__2%)
if not [%__3%]==[] (if not [%__4%]==[] set _pathname=%_pathname%\%__3%)
if not [%__4%]==[] (if not [%__5%]==[] set _pathname=%_pathname%\%__4%)
if not [%__5%]==[] (if not [%__6%]==[] set _pathname=%_pathname%\%__5%)
if not [%__6%]==[] (if not [%__7%]==[] set _pathname=%_pathname%\%__6%)
set _pathname=%_pathname%\%_1%.py

python %_pathname% %1 %2 %3 %4 %5 %6 %7 %8 %9 




