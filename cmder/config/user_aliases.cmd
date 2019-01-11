;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
a=alias
adel=alias /d $1
adiff="C:\Program Files (x86)\Meld\Meld.exe" C:\tools\cmder\config\user_aliases.cmd D:\Users\sita\Documents\tasks\cmder\config\user_aliases.cmd
aed="C:\Program Files\Notepad++\notepad++.exe" C:\tools\cmder\config\user_aliases.cmd
aload=%TASKS_ROOT%\utility\gitsync.bat & robocopy %TASKS_ROOT%\cmder C:\tools\cmder *.bat *.cmd *.sh *.xml /S /R:0 /NDL /NJH /NJS /MT & alias /reload
are=alias /reload
asave=robocopy C:\tools\cmder %TASKS_ROOT%\cmder *.bat *.cmd *.sh *.xml /S /R:0 /NDL /NJH /NJS /MT & %TASKS_ROOT%\utility\gitsync.bat
asort=sort C:\tools\cmder\config\user_aliases.cmd | uniq > %temp%\user_aliases.cmd & move /y %temp%\user_aliases.cmd C:\tools\cmder\config\user_aliases.cmd
clear=cls
cmderr=cd /d "%CMDER_ROOT%"
e.=explorer .
edit="C:\Program Files\Notepad++\notepad++.exe" $*
edhost="C:\Program Files\Notepad++\notepad++.exe" C:\Windows\System32\drivers\etc\hosts
gl=git log --oneline --all --graph --decorate  $*
gs=%TASKS_ROOT%\utility\gitsync.bat
gstat=git status
history=cat %CMDER_ROOT%\config\.history
ls=ls --show-control-chars -F --color $*
ohm=openhardwaremonitor
pathadd="%TASKS_ROOT%\util\setenv.cmd" +PATH "%CD%"
pd=popd
pdd=pushd D:\Users\%USERNAME%\Dropbox\Desktop
ping=ping -t $*
pk=pushd C:\Users\%USERNAME%\AppData\Roaming\Kodi\userdata
ph=pushd %TASKS_ROOT%\batch\ssh  
pu=pushd %TASKS_ROOT%\utility
pv=set VAGRANT_HOME=D:\Users\sita\.vagrant.d & pushd D:\Users\%USERNAME%\vagrant 
pwd=cd
py=pushd C:\Users\%USERNAME%\AppData\Roaming\Kodi\userdata\playlists\video\YouTube
su="%TASKS_ROOT%\utility\getadmin.bat" "%TASKS_ROOT%\utility\cmdk.bat"
v=vagrant $*
;vup=vagrant up
;vre=vagrant reload
vi=vim $*
diff="C:\Program Files (x86)\Meld\Meld.exe" $*
pr=pushd %TASKS_ROOT%\rsync\DeltaCopyRaw
;hosts=vi /c/Users/sita/.ssh/known_hosts
hosts=vi c:\Users\sita\.ssh\known_hosts