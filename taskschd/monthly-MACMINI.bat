REM =================================

call %~dp0\update.bat

REM =================================

choco upgrade all

REM =================================

call %~dp0\cleanup.bat
