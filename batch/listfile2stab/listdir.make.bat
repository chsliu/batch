@echo off

set listdir.make=call "%TASKS_ROOT%\batch\listfile2stab\listdir.make.cmd"

call %listdir.make% "%1" "\\pve5\NetBackup\sita\HV3"

