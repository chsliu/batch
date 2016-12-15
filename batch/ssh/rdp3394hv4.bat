set path=%path%;C:\Users\sita\PortableApps\GitPortable\App\Git\bin;C:\Users\sita\PortableApps\PuTTYPortable\App\putty

rem ssh root@sitahome.no-ip.org -L 3394:192.168.1.246:3389

plink -ssh -L 3394:192.168.1.246:3389 root@sitahome.no-ip.org

