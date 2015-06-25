@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat %0

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

REM astyle
REM atom
REM dependencywalker
REM fiddler
REM gource
REM icofx
REM jenkins
REM linqpad4
REM nodejs
REM procexp
REM procmon
REM pspad
REM pstools
REM python.pypy
REM ruby
REM sqliteadmin
REM sqlitebrowser
REM sublimetext3 
REM swig
REM sysinternals
REM wink

cinst -y git github hg python2 teraterm visualstudioexpress2008 winmerge

rem pause

C:\Windows\System32\timeout.exe 10
