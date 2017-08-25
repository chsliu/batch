@echo off

set _=3

DEL /F /S /Q \\nas\%_%\Documentary\DEL
RMDIR /S /Q  \\nas\%_%\Documentary\DEL
DEL /F /S /Q \\nas\%_%\Game\DEL
RMDIR /S /Q  \\nas\%_%\Game\DEL
DEL /F /S /Q \\nas\%_%\Media\DEL
RMDIR /S /Q  \\nas\%_%\Media\DEL

DEL /F /S /Q \\nas\%_%\Documentary\WATCHED
RMDIR /S /Q  \\nas\%_%\Documentary\WATCHED
DEL /F /S /Q \\nas\%_%\Media\WATCHED\Music\AV
RMDIR /S /Q  \\nas\%_%\Media\WATCHED\Music\AV
DEL /F /S /Q \\nas\%_%\Media\WATCHED\Documentary
RMDIR /S /Q  \\nas\%_%\Media\WATCHED\Documentary
DEL /F /S /Q \\nas\%_%\Media\WATCHED\Family
RMDIR /S /Q  \\nas\%_%\Media\WATCHED\Family
DEL /F /S /Q \\nas\%_%\Media\WATCHED\Mandarin
RMDIR /S /Q  \\nas\%_%\Media\WATCHED\Mandarin
DEL /F /S /Q \\nas\%_%\Media\WATCHED\Wife
RMDIR /S /Q  \\nas\%_%\Media\WATCHED\Wife

REM DEL /F /S /Q \\nas\%_%\Media\WATCHED\Dorama
REM RMDIR /S /Q  \\nas\%_%\Media\WATCHED\Dorama
REM DEL /F /S /Q \\nas\%_%\Media\WATCHED\Children
REM RMDIR /S /Q  \\nas\%_%\Media\WATCHED\Children
REM DEL /F /S /Q \\nas\%_%\Media\TV\!DEL
REM RMDIR /S /Q  \\nas\%_%\Media\TV\!DEL

REM DEL /F /S /Q \\nas\%_%\Documentary\#recycle
REM RMDIR /S /Q  \\nas\%_%\Documentary\#recycle
REM DEL /F /S /Q \\nas\%_%\Game\#recycle
REM RMDIR /S /Q  \\nas\%_%\Game\#recycle
REM DEL /F /S /Q \\nas\%_%\Media\#recycle
REM RMDIR /S /Q  \\nas\%_%\Media\#recycle
DEL /F /S /Q \\nas\%_%\#recycle
RMDIR /S /Q  \\nas\%_%\#recycle

pause
