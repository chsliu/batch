set path=%path%;D:\Users\sita\PortableApps\FileBot_4.5-portable

rem --log-file revert.log 

filebot -script fn:revert --action rename %1


rem pause
