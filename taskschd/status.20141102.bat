REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

set LOG=%~dp0\log\status-%TODAY%.txt

echo %DATE%%TIME% 				>  %LOG%

REM =================================

echo wmic diskdrive get status			>> %LOG%
wmic diskdrive get status			>> %LOG%

call E:\Shares\Admin\script\poolstatus.bat 	>> %LOG%

dir C:\						>> %LOG%

dir E:\Shares					>> %LOG%

dir F:\Shares					>> %LOG%

REM =================================

net stats work					>> %LOG%

net stats srv					>> %LOG%

REM =================================

%~dp0\utility\sendemail -s msa.hinet.net -f chsliu@gmail.com -t chsliu@gmail.com -u %COMPUTERNAME%\%0 -m %~dp0\%0 -a %LOG%

del %LOG%

