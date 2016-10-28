set path=%path%;C:\Program Files (x86)\Git\cmd
set SCHEDULE=13:30-14:00-14:30
set DAILY=%SCHEDULE:~0,5%
set WEEKLY=%SCHEDULE:~6,5%
set MONTHLY=%SCHEDULE:~12,5%


if not defined DOC goto :EOF
if not defined PASS goto :EOF

setx TASKS_ROOT %DOC%\tasks

if not exist %TASKS_ROOT% (
	mkdir %DOC%
	git clone https://github.com/chsliu/batch.git tasks
)

pushd %DOC%

SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC ONSTART /TN "%USERNAME%-startup" /TR "%TASKS_ROOT%\startup.bat"
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC DAILY /TN "%USERNAME%-daily" /TR "%TASKS_ROOT%\daily.bat" /ST %DAILY%
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D FRI /TN "%USERNAME%-weekly" /TR "%TASKS_ROOT%\weekly.bat" /ST %WEEKLY%
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC MONTHLY /MO LAST /D FRI /TN "%USERNAME%-monthly" /TR "%TASKS_ROOT%\monthly.bat" /ST %MONTHLY%

popd
