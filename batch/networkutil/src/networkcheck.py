from pingserver import pingserver

##def pingserver(server,timeout=2):
##    import ping, socket
##    try:
##        delay = ping.do_one(server, timeout)
##        if delay  !=  None:
##            return None
##        error = "Ping failed. (timeout within %ssec.)" % timeout
##    except socket.error, e:
##        error = "Ping Error:" + str(e)
##    print error
##    return error


def usage(prog):
    print "%s servername" % prog


def testlog():
    import log
    cnt = log.getint('record','rebootcount')
    print 'rebootcount', cnt
    cnt += 1
    log.set('record','rebootcount',cnt)


def main():
    import sys
    import log
    from reboot import RebootServer,AbortReboot
    import servicemanager
    args = sys.argv[1:]
    if len(args) == 0:
        usage(sys.argv[0])

    for arg in args:
        server = arg
        errmsg =  pingserver(server)
        rcnt = log.getint('record','rebootcount')
        if errmsg:
            if rcnt < 3:
                rcnt += 1
                log.set('record','rebootcount',rcnt)
                message = '%s is not responsive, This server is going to reboot in 30 seconds' % server
                servicemanager.LogInfoMsg(message)
                RebootServer(message)
                raw_input('Press any key to stop reboot...')
                AbortReboot()
                servicemanager.LogInfoMsg('Reboot is been cancelled.')
            else:
                message = '%s is not responsive, but rebootcount is over %d, not more reboot' % (server,rcnt)
                servicemanager.LogInfoMsg(message)
        else:
            log.set('record','rebootcount',0)
            message = '%s is alive.' % (server)
            #servicemanager.LogInfoMsg(message)
            print message


if __name__ == "__main__":
    main()
