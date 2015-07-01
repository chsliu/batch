set path=%path%;%~dp0\..\bin
set LOG1=%temp%\%~n0.txt
set LOG2=%temp%\%~n0-summary.txt

echo ======================	>>%LOG1% 2>>&1
echo smartctl -a /dev/pd1	>>%LOG1% 2>>&1
echo ======================	>>%LOG1% 2>>&1
smartctl -a /dev/pd1 		>>%LOG1% 2>>&1

findstr /C:"Power_On_Hours" %LOG1%							>>%LOG2%
findstr /C:"occurred at disk power-on lifetime" %LOG1%			>>%LOG2%


sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG2% %LOG1%

del %LOG1% %LOG2%

