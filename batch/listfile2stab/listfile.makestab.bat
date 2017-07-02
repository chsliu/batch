@echo off

set listfile.makestab=call "%TASKS_ROOT%\batch\listfile2stab\listfile.makestab.cmd"

call %listfile.makestab% "%1" "\\pve5\NetBackup\sita\HV3" "hv3" ".n2.txt"

