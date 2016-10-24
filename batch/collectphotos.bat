@echo off

set ROOT=d:\Users\sita\Desktop\Photos\

chcp 950

set SRC="C:\Users\sita\Pictures\iCloud Photos\My Photo Stream"
set DST=%ROOT%\"My Photo Stream"
call :MOVETO

set SRC="C:\Users\sita\Pictures\Camera Roll"
set DST=%ROOT%\"Camera Roll"
call :MOVETO

set SRC="C:\Users\sita\Pictures\手機相簿"
set DST=%ROOT%\"手機相簿"
call :MOVETO

set SRC="C:\Users\sita\Pictures\從 Lisa Phone"
set DST=%ROOT%\"從 泰坦機(lisa)"
call :MOVETO

set SRC="D:\Users\sita\BTSync\Devices\DCIM\iPad mini 2"
set DST=%ROOT%\"iPad mini 2"
call :MOVETO

set SRC="D:\Users\sita\BTSync\Devices\DCIM\ME371MG"
set DST=%ROOT%\"ME371MG"
call :MOVETO

set SRC="D:\Users\sita\Dropbox\Camera Uploads"
set DST=%ROOT%\"Dropbox"
call :MOVETO


call :EMPTYSUB

goto :EOF


:MOVETO
set FILES=
set OPTION=/XF *.!sync .SyncID .SyncIgnore /XD .SyncArchive .thumbnails /S /MOVE

pushd %SRC%

robocopy . %DST% %FILES% %OPTION%

popd

exit /b

:EMPTYSUB

pushd %ROOT%

for /f "usebackq delims=" %%d in (`"dir /ad/b/s | C:\Windows\System32\sort.exe /R"`) do rd "%%d"

popd

exit /b
