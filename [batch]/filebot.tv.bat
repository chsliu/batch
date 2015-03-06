@echo off
set root=%~dp0

:loop
if [%1]==[] (
	pause
	goto :EOF
)


set L=tv
set S=20
set N=%~nx1
set K=single
set F=%~nx1
set D=%~dp1


call %root%\fb.amc.bat


shift
goto loop

Parameter: ut_label = 
Parameter: ut_state = 20
Parameter: ut_title = Modern Family S06E08 HDTV x264-KILLERS[ettv]
Parameter: ut_kind = multi
Parameter: ut_file = Modern.Family.S06E08.HDTV.x264-KILLERS.mp4
Parameter: ut_dir = D:\Download\Modern Family S06E08 HDTV x264-KILLERS[ettv]

REM pause
