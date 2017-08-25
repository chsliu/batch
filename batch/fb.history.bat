@echo off
set path=%path%;D:\Users\sita\PortableApps\FileBot_4.5-portable

set log=D:\Users\sita\PortableApps\FileBot_4.5-portable\logs\history.log

rem filebot -script fn:history --log-file history.log
rem filebot -script fn:history --format "${from}\t${to}" --log off --log-file history.log
filebot -script fn:history --log-file history.log %1


ping 127.0.0.1 -n 10 -w 1000 > nul


type %log%
del %log%


pause
