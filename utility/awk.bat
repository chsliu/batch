@echo off
SET _c=
FOR /F "tokens=5 delims= " %%G IN (%1) DO (
    IF DEFINED _c <nul set /p z=", "
    <nul set /p z=%%G
    SET _c=1
)