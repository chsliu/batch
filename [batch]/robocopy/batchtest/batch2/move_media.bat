@echo off

set SOURCE=.
set TARGET=\\n2\Media
set OPTION=/move /s /XD "System Volume Information"
set FILES=

robocopy %SOURCE% %TARGET% %FILES% %OPTION%
