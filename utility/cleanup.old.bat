@echo off

call %~dp0\clean.bat

del /S /Q /F \\n3\game\DEL\*.*		> d:\Users\sita\Desktop\cleanupdel.txt
del /S /Q /F \\n3\media\DEL\*.*		>> d:\Users\sita\Desktop\cleanupdel.txt
del /S /Q /F \\n3\software\DEL\*.*	>> d:\Users\sita\Desktop\cleanupdel.txt
del /S /Q /F \\vmn3\Game\DEL\*.*	>> d:\Users\sita\Desktop\cleanupdel.txt
del /S /Q /F \\vmw7\Download\DEL\*.*	>> d:\Users\sita\Desktop\cleanupdel.txt


rd  /S /Q \\n3\game\DEL\		>> d:\Users\sita\Desktop\cleanupdel.txt
rd  /S /Q \\n3\media\DEL\		>> d:\Users\sita\Desktop\cleanupdel.txt
rd  /S /Q \\n3\software\DEL\		>> d:\Users\sita\Desktop\cleanupdel.txt
rd  /S /Q \\vmn3\Game\DEL\		>> d:\Users\sita\Desktop\cleanupdel.txt
rd  /S /Q \\vmw7\Download\DEL\		>> d:\Users\sita\Desktop\cleanupdel.txt


rd /s /q \\hv3\Media\Movie\DEL
rd /s /q \\hv3\Media\TV\DEL

rd /s /q \\G2\暫存區

REM pause
