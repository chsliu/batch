@echo off
REM for /f "delims=" %%i in ('cd') do set cwd=%%i

for /f "tokens=1-7 delims=\" %%g in ('cd') do (
set T1=%%g 
set T2=%%h 
set T3=%%i 
set T4=%%j 
set T5=%%k 
set T6=%%l 
set T7=%%m
)

REM for %%i in (%g %h %i %j %k %l %m) do if not %%i == "" set TARGET = %%i
REM for %%i in (%T1 %T2 %T3 %T4 %T5 %T6 %T7) do (echo %%i)
REM for %%i in (%%g %%h %%i %%j %%k %%l %%m) do (echo %%i)
REM for %%i in (%g% %h% %i% %j% %k% %l% %m%) do (echo %%i)

REM for %%i in (%T1% %T2% %T3% %T4% %T5% %T6% %T7%) do (echo %%i)
REM for %%i in (%T1% %T2% %T3% %T4% %T5% %T6% %T7%) do (set TARGET=%%i)

REM ==== working ===
for /f "tokens=1-7 delims=\" %%g in ("%CD%") do (
set T1=%%g 
set T2=%%h 
set T3=%%i 
set T4=%%j 
set T5=%%k 
set T6=%%l 
set T7=%%m
)

for %%i in (%T1% %T2% %T3% %T4% %T5% %T6% %T7%) do (set TARGET=%%i)


REM ========== path from file ===================
for /f "tokens=1-7 delims=\" %%g in ("%1") do (
set T1=%%g 
set T2=%%h 
set T3=%%i 
set T4=%%j 
set T5=%%k 
set T6=%%l 
set T7=%%m
)

REM for %%i in (%T1% %T2% %T3% %T4% %T5% %T6% %T7%) do (echo %%i)
for %%i in (%T7% %T6% %T5% %T4% %T3% %T2% %T1%) do (echo %%i)

pause



