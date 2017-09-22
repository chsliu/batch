@echo off

set SOURCE=\\n2\Media
set TARGET=d:\temp
set OPTIONS=/MOVE /S /ETA /NDL /NJH /NJS /L
set FILES=pagefile.sys hiberfil.sys *.DS_Store Thumbs.db Temp "Recorded TV" "System Volume Information" RECYCLED RECYCLER $Recycle.Bin

robocopy %SOURCE% %TARGET% %FILES% %OPTIONS%

pause
