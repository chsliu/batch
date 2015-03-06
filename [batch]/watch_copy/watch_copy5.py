import time
from pygame import cdrom

cdrom.init()
cd = cdrom.CD(1)
cd.init()


i = 0
while 1:
    i += 1
    print "[%d]Checking..." % i
    if not cd.get_empty():
        print "[%d]CDROM ejecting..." % i
        cd.eject()

    print "[%d]Sleeping..." % i
    time.sleep(10)
