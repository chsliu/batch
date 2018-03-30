@echo off

chcp 65001

:loop

ping -n 1 %* | grep TTL
sleep 10

goto loop
