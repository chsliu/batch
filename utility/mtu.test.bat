@echo off

if [%1]==[] goto :usage
if [%2]==[] goto :usage

goto :main

:usage

echo %0 [host] [packet size]

goto :EOF

:main

ping %1 -f -l %2

