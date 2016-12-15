set path=%path%;C:\Users\sita\PortableApps\PuTTYPortable\App\putty

rem ssh root@sitahome.no-ip.org -L 3390:192.168.1.72:3389

plink -ssh root@sitahome.no-ip.org -L 3390:192.168.1.72:3389
