@echo off
for /d /r %1 %%A in (.) do (
  dir /a /b "%%~fA" 2>nul | findstr "^" >nul || echo %%~fA
)
