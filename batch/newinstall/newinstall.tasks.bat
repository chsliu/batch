@echo off

set path=%path%;C:\Program Files (x86)\Git\cmd;C:\tools\cmder\vendor\msysgit\bin

if not defined DOC 		goto :EOF
set TASKS_ROOT=%DOC%\tasks

setx TASKS_ROOT %DOC%\tasks

if not exist %TASKS_ROOT% (
	mkdir %DOC%
	git clone https://github.com/chsliu/batch.git tasks
)

