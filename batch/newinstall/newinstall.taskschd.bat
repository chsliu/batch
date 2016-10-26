set path=%path%;C:\Program Files (x86)\Git\cmd

mkdir %DOC%
pushd %DOC%
git clone https://github.com/chsliu/batch.git tasks

setx TASKS_ROOT %DOC%\tasks

SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC ONSTART /TN "%USERNAME%-startup" /TR "%TASKS_ROOT%\startup.bat"
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC DAILY /TN "%USERNAME%-daily" /TR "%TASKS_ROOT%\daily.bat" /ST %DAILY%
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D FRI /TN "%USERNAME%-weekly" /TR "%TASKS_ROOT%\weekly.bat" /ST %WEEKLY%
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC MONTHLY /MO LAST /D FRI /TN "%USERNAME%-monthly" /TR "%TASKS_ROOT%\monthly.bat" /ST %MONTHLY%

popd
